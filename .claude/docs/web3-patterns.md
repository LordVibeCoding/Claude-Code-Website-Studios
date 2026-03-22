# Web3 Development Patterns

Common patterns for BNB Chain (BSC) DApp development with wagmi v2 + viem.

---

## Wallet Connection Flow

### Pattern: Connect → Verify Chain → Ready

```typescript
// src/lib/web3/config.ts
import { createConfig, http } from 'wagmi'
import { bsc, bscTestnet } from 'wagmi/chains'
import { getDefaultConfig } from '@rainbow-me/rainbowkit'

export const config = getDefaultConfig({
  appName: 'My DApp',
  projectId: process.env.NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID!,
  chains: [bsc, bscTestnet],
  transports: {
    [bsc.id]: http('https://bsc-dataseed.bnbchain.org'),
    [bscTestnet.id]: http('https://data-seed-prebsc-1-s1.bnbchain.org:8545'),
  },
})
```

### Connection States

```
Disconnected → Connecting → Connected → Wrong Chain → Switching → Ready
     │              │            │            │            │          │
     └──[click]─────┘            └──[check]───┘            └──[auto]──┘
                                      │
                                 Chain correct? ──yes──→ Ready
```

### Handling Connection in Components

```typescript
// Pattern: guard component with wallet state
import { useAccount, useChainId, useSwitchChain } from 'wagmi'

function DAppPage() {
  const { isConnected, address } = useAccount()
  const chainId = useChainId()
  const { switchChain } = useSwitchChain()

  if (!isConnected) {
    return <ConnectWalletPrompt />
  }

  if (chainId !== bsc.id && chainId !== bscTestnet.id) {
    return <WrongChainPrompt onSwitch={() => switchChain({ chainId: bsc.id })} />
  }

  return <DAppContent address={address} />
}
```

---

## Transaction Lifecycle

### States: Idle → Pending → Confirming → Confirmed / Failed

```
User Action
    │
    ▼
[Simulate] ──fail──→ Show Error (gas estimation, revert reason)
    │
  success
    │
    ▼
[Send TX] ──reject──→ User Rejected (wallet popup closed)
    │
  submitted
    │
    ▼
[Wait for Receipt] ──timeout──→ TX Pending (show hash + BSCScan link)
    │
  mined
    │
    ▼
[Check Status]
    │
    ├──success──→ TX Confirmed (show success, refresh data)
    └──reverted──→ TX Failed (show revert reason, suggest retry)
```

### Implementation Pattern

```typescript
import { useWriteContract, useWaitForTransactionReceipt } from 'wagmi'
import { parseAbi } from 'viem'

function useTokenTransfer() {
  const {
    writeContract,
    data: hash,
    isPending: isWritePending,
    error: writeError,
  } = useWriteContract()

  const {
    isLoading: isConfirming,
    isSuccess: isConfirmed,
    error: receiptError,
  } = useWaitForTransactionReceipt({ hash })

  const transfer = (to: `0x${string}`, amount: bigint) => {
    writeContract({
      address: TOKEN_ADDRESS,
      abi: parseAbi(['function transfer(address to, uint256 amount) returns (bool)']),
      functionName: 'transfer',
      args: [to, amount],
    })
  }

  return {
    transfer,
    hash,
    isWritePending,   // Wallet popup open
    isConfirming,     // TX submitted, waiting for block
    isConfirmed,      // TX mined successfully
    error: writeError || receiptError,
  }
}
```

---

## Contract Interaction Patterns

### Read Pattern (no wallet required)

```typescript
import { useReadContract } from 'wagmi'

function TokenBalance({ address }: { address: `0x${string}` }) {
  const { data: balance, isLoading, error } = useReadContract({
    address: TOKEN_ADDRESS,
    abi: TOKEN_ABI,
    functionName: 'balanceOf',
    args: [address],
  })

  if (isLoading) return <Skeleton />
  if (error) return <ErrorDisplay error={error} />

  return <span>{formatUnits(balance!, 18)} TOKEN</span>
}
```

### Write Pattern (wallet required)

```typescript
import { useWriteContract, useSimulateContract } from 'wagmi'

function StakeButton({ amount }: { amount: bigint }) {
  // 1. Simulate first to catch errors before user signs
  const { data: simulation } = useSimulateContract({
    address: STAKING_ADDRESS,
    abi: STAKING_ABI,
    functionName: 'stake',
    args: [amount],
  })

  // 2. Write only if simulation succeeds
  const { writeContract, isPending } = useWriteContract()

  const handleStake = () => {
    if (!simulation?.request) return
    writeContract(simulation.request)
  }

  return (
    <button onClick={handleStake} disabled={isPending || !simulation}>
      {isPending ? 'Staking...' : 'Stake'}
    </button>
  )
}
```

### Multicall Pattern (batch reads)

```typescript
import { useReadContracts } from 'wagmi'

function TokenDashboard() {
  const { data } = useReadContracts({
    contracts: [
      { address: TOKEN_ADDRESS, abi: TOKEN_ABI, functionName: 'totalSupply' },
      { address: TOKEN_ADDRESS, abi: TOKEN_ABI, functionName: 'decimals' },
      { address: TOKEN_ADDRESS, abi: TOKEN_ABI, functionName: 'name' },
      { address: TOKEN_ADDRESS, abi: TOKEN_ABI, functionName: 'symbol' },
    ],
  })

  const [totalSupply, decimals, name, symbol] = data ?? []
  // ...
}
```

---

## Token Approval Flow

### Pattern: Check Allowance → Approve (if needed) → Execute

BEP20 tokens require a two-step process for contracts to spend tokens on behalf of users.

```
Check Allowance
    │
    ├── allowance >= amount → Execute Operation
    │
    └── allowance < amount → Approve
                                │
                                ▼
                           Wait Confirmation
                                │
                                ▼
                           Execute Operation
```

### Implementation

```typescript
import { useReadContract, useWriteContract, useWaitForTransactionReceipt } from 'wagmi'
import { maxUint256 } from 'viem'

function useApproveAndExecute(tokenAddress: `0x${string}`, spenderAddress: `0x${string}`) {
  const { address } = useAccount()

  // 1. Check current allowance
  const { data: allowance, refetch: refetchAllowance } = useReadContract({
    address: tokenAddress,
    abi: ERC20_ABI,
    functionName: 'allowance',
    args: [address!, spenderAddress],
    query: { enabled: !!address },
  })

  // 2. Approve if needed
  const {
    writeContract: approve,
    data: approveHash,
    isPending: isApproving,
  } = useWriteContract()

  const { isSuccess: isApproved } = useWaitForTransactionReceipt({
    hash: approveHash,
  })

  const needsApproval = (amount: bigint) => {
    return !allowance || allowance < amount
  }

  const requestApproval = () => {
    approve({
      address: tokenAddress,
      abi: ERC20_ABI,
      functionName: 'approve',
      args: [spenderAddress, maxUint256],  // Infinite approval (or use exact amount)
    })
  }

  return { needsApproval, requestApproval, isApproving, isApproved, refetchAllowance }
}
```

---

## Error Handling for Web3 Calls

### Error Categories

| Category | Example | User Message |
|----------|---------|--------------|
| User Rejected | User closed MetaMask popup | "Transaction cancelled" |
| Insufficient Funds | Not enough BNB for gas | "Insufficient BNB balance for gas fees" |
| Contract Revert | `require()` failed in contract | Parse revert reason, show specific message |
| Network Error | RPC endpoint down | "Network error. Please try again." |
| Chain Mismatch | Wrong network selected | "Please switch to BNB Smart Chain" |
| Nonce Error | Stuck pending transaction | "Transaction stuck. Try resetting in wallet." |

### Error Parser

```typescript
export function parseWeb3Error(error: unknown): string {
  const message = error instanceof Error ? error.message : String(error)

  // User rejection
  if (message.includes('User rejected') || message.includes('user rejected')) {
    return 'Transaction cancelled.'
  }

  // Insufficient funds
  if (message.includes('insufficient funds')) {
    return 'Insufficient BNB balance for gas fees.'
  }

  // Contract revert with reason
  const revertMatch = message.match(/reason="([^"]+)"/)
  if (revertMatch) {
    return `Contract error: ${revertMatch[1]}`
  }

  // Specific contract errors
  if (message.includes('execution reverted')) {
    const customErrors: Record<string, string> = {
      'InsufficientBalance': 'Your token balance is too low.',
      'ExceedsMaxSupply': 'Maximum supply reached.',
      'MintNotActive': 'Minting is not currently active.',
      'ExceedsMaxPerWallet': 'You have reached the maximum mint limit.',
      'InvalidProof': 'Your wallet is not on the whitelist.',
    }

    for (const [key, msg] of Object.entries(customErrors)) {
      if (message.includes(key)) return msg
    }

    return 'Transaction failed. The contract rejected the operation.'
  }

  // Network errors
  if (message.includes('network') || message.includes('timeout') || message.includes('ECONNREFUSED')) {
    return 'Network error. Please check your connection and try again.'
  }

  return 'An unexpected error occurred. Please try again.'
}
```

---

## Chain Switching

### Pattern: Detect Wrong Chain → Prompt Switch → Auto-retry

```typescript
import { useSwitchChain, useChainId } from 'wagmi'
import { bsc } from 'wagmi/chains'

function ChainGuard({ children }: { children: React.ReactNode }) {
  const chainId = useChainId()
  const { switchChain, isPending } = useSwitchChain()

  const targetChainId = Number(process.env.NEXT_PUBLIC_CHAIN_ID) || bsc.id

  if (chainId !== targetChainId) {
    return (
      <div className="text-center p-8">
        <p>Please switch to BNB Smart Chain to continue.</p>
        <button
          onClick={() => switchChain({ chainId: targetChainId })}
          disabled={isPending}
        >
          {isPending ? 'Switching...' : 'Switch Network'}
        </button>
      </div>
    )
  }

  return <>{children}</>
}
```

---

## Gas Estimation

### Pattern: Estimate → Display → Allow Override

```typescript
import { useEstimateGas, useGasPrice } from 'wagmi'
import { formatEther, formatGwei } from 'viem'

function GasEstimate({
  to,
  data,
  value,
}: {
  to: `0x${string}`
  data: `0x${string}`
  value?: bigint
}) {
  const { data: gasEstimate } = useEstimateGas({
    to,
    data,
    value,
  })

  const { data: gasPrice } = useGasPrice()

  if (!gasEstimate || !gasPrice) return null

  const estimatedCost = gasEstimate * gasPrice
  // Add 20% buffer for safety
  const bufferedCost = estimatedCost + (estimatedCost * 20n) / 100n

  return (
    <div className="text-sm text-muted">
      <p>Estimated gas: {gasEstimate.toString()} units</p>
      <p>Gas price: {formatGwei(gasPrice)} Gwei</p>
      <p>Estimated cost: ~{formatEther(bufferedCost)} BNB</p>
    </div>
  )
}
```

---

## Event Listening

### Pattern: Watch Contract Events

```typescript
import { useWatchContractEvent } from 'wagmi'

function TransferWatcher() {
  useWatchContractEvent({
    address: TOKEN_ADDRESS,
    abi: TOKEN_ABI,
    eventName: 'Transfer',
    onLogs(logs) {
      for (const log of logs) {
        const { from, to, value } = log.args
        console.log(`Transfer: ${from} → ${to}: ${formatUnits(value, 18)}`)
        // Update UI, show notification, etc.
      }
    },
  })

  return null // or render transfer feed
}
```

---

## BSCScan Verification

### Pattern: Post-deploy Verification

```typescript
// hardhat.config.ts
import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-verify'

const config: HardhatUserConfig = {
  networks: {
    bsc: {
      url: 'https://bsc-dataseed.bnbchain.org',
      chainId: 56,
      accounts: [process.env.DEPLOYER_PRIVATE_KEY!],
    },
    bscTestnet: {
      url: 'https://data-seed-prebsc-1-s1.bnbchain.org:8545',
      chainId: 97,
      accounts: [process.env.DEPLOYER_PRIVATE_KEY!],
    },
  },
  etherscan: {
    apiKey: {
      bsc: process.env.BSCSCAN_API_KEY!,
      bscTestnet: process.env.BSCSCAN_API_KEY!,
    },
  },
}
```

Verify after deployment:
```bash
npx hardhat verify --network bscTestnet CONTRACT_ADDRESS "ConstructorArg1" "ConstructorArg2"
```

---

## Common Utility Functions

```typescript
// src/lib/web3/formatters.ts

/** Shorten address: 0x1234...abcd */
export function shortenAddress(address: string, chars = 4): string {
  return `${address.slice(0, chars + 2)}...${address.slice(-chars)}`
}

/** Format token amount with decimals */
export function formatTokenAmount(
  amount: bigint,
  decimals: number,
  displayDecimals = 4
): string {
  const divisor = 10n ** BigInt(decimals)
  const whole = amount / divisor
  const fraction = amount % divisor
  const fractionStr = fraction.toString().padStart(decimals, '0').slice(0, displayDecimals)
  return `${whole.toLocaleString()}.${fractionStr}`
}

/** BSCScan URL for address or transaction */
export function getBscScanUrl(
  hashOrAddress: string,
  type: 'address' | 'tx' = 'address',
  testnet = false
): string {
  const base = testnet ? 'https://testnet.bscscan.com' : 'https://bscscan.com'
  return `${base}/${type}/${hashOrAddress}`
}
```
