---
path:
  - "src/dapp/**"
---

# dApp Code Standards

## Wallet Connection State

Every dApp component that interacts with Web3 must handle all connection states explicitly.

```tsx
type WalletState =
  | { status: "disconnected" }
  | { status: "connecting" }
  | { status: "connected"; address: string; chainId: number }
  | { status: "error"; error: Error };

// CORRECT: Exhaustive state handling
function DAppContent() {
  const { status, address, chainId, error } = useWallet();

  switch (status) {
    case "disconnected":
      return <ConnectWalletPrompt />;
    case "connecting":
      return <Skeleton className="h-12 w-full" />;
    case "error":
      return <WalletError error={error} onRetry={reconnect} />;
    case "connected":
      return <Dashboard address={address} chainId={chainId} />;
  }
}

// WRONG: Only handling the happy path
function DAppContent() {
  const { address } = useWallet();
  return <Dashboard address={address!} />;  // Crashes when disconnected
}
```

## Error Boundaries for Web3 Calls

Wrap all Web3 interaction zones in error boundaries. Blockchain calls can fail unpredictably (RPC down, rejected transaction, reverted call).

```tsx
"use client";
import { ErrorBoundary } from "react-error-boundary";

function Web3ErrorFallback({ error, resetErrorBoundary }: FallbackProps) {
  const message = parseWeb3Error(error); // Extract user-friendly message

  return (
    <div role="alert" className="rounded-lg border border-red-200 p-4">
      <h3 className="font-semibold text-red-800">Transaction Failed</h3>
      <p className="text-red-600">{message}</p>
      <button onClick={resetErrorBoundary}>Try Again</button>
    </div>
  );
}

// Usage
<ErrorBoundary FallbackComponent={Web3ErrorFallback}>
  <MintSection />
</ErrorBoundary>
```

## Loading and Pending States for Transactions

All blockchain transactions must show clear state transitions:

```tsx
type TxState =
  | { step: "idle" }
  | { step: "approving" }           // Wallet popup open
  | { step: "pending"; hash: string } // Tx submitted, waiting for confirmation
  | { step: "confirming"; hash: string; confirmations: number }
  | { step: "success"; hash: string; receipt: TransactionReceipt }
  | { step: "error"; error: Error };

function MintButton() {
  const [txState, setTxState] = useState<TxState>({ step: "idle" });

  const handleMint = async () => {
    try {
      setTxState({ step: "approving" });
      const tx = await contract.mint(tokenId);

      setTxState({ step: "pending", hash: tx.hash });
      const receipt = await tx.wait(1); // Wait for 1 confirmation

      setTxState({ step: "success", hash: tx.hash, receipt });
    } catch (err) {
      setTxState({ step: "error", error: err as Error });
    }
  };

  return (
    <>
      <button
        onClick={handleMint}
        disabled={txState.step !== "idle" && txState.step !== "error"}
      >
        {txState.step === "approving" && "Confirm in Wallet..."}
        {txState.step === "pending" && "Transaction Pending..."}
        {txState.step === "idle" && "Mint NFT"}
        {txState.step === "error" && "Retry Mint"}
        {txState.step === "success" && "Minted!"}
      </button>
      {txState.step === "pending" && (
        <a href={`${explorerUrl}/tx/${txState.hash}`} target="_blank" rel="noopener">
          View on Explorer
        </a>
      )}
    </>
  );
}
```

## Chain ID Validation

Always verify the user is on the correct network before any transaction. Support chain switching.

```tsx
const SUPPORTED_CHAINS: Record<number, string> = {
  1: "Ethereum Mainnet",
  137: "Polygon",
  8453: "Base",
  42161: "Arbitrum One",
};

function useChainGuard() {
  const { chainId, switchChain } = useWallet();
  const isSupported = chainId != null && chainId in SUPPORTED_CHAINS;

  return {
    isSupported,
    chainName: chainId ? SUPPORTED_CHAINS[chainId] : undefined,
    switchToDefault: () => switchChain(8453), // Default to Base
  };
}

// CORRECT: Guard all transaction components
function StakeForm() {
  const { isSupported, switchToDefault } = useChainGuard();

  if (!isSupported) {
    return (
      <div role="alert">
        <p>Please switch to a supported network.</p>
        <button onClick={switchToDefault}>Switch to Base</button>
      </div>
    );
  }

  return <StakeFormInner />;
}
```

## Proper Disconnect Handling

Clean up all subscriptions, cached state, and listeners when a wallet disconnects.

```tsx
function useWalletCleanup() {
  const { status, provider } = useWallet();
  const prevStatus = useRef(status);

  useEffect(() => {
    // Detect disconnect transition
    if (prevStatus.current === "connected" && status === "disconnected") {
      // Clean up cached balances, approvals, etc.
      queryClient.removeQueries({ queryKey: ["balance"] });
      queryClient.removeQueries({ queryKey: ["allowance"] });
      queryClient.removeQueries({ queryKey: ["nfts"] });
    }

    prevStatus.current = status;
  }, [status]);

  // Clean up provider listeners on unmount
  useEffect(() => {
    if (!provider) return;

    const handleChainChanged = () => window.location.reload();
    const handleAccountsChanged = (accounts: string[]) => {
      if (accounts.length === 0) disconnect();
    };

    provider.on("chainChanged", handleChainChanged);
    provider.on("accountsChanged", handleAccountsChanged);

    return () => {
      provider.removeListener("chainChanged", handleChainChanged);
      provider.removeListener("accountsChanged", handleAccountsChanged);
    };
  }, [provider]);
}
```

## Gas Estimation Before Transactions

Never submit transactions without first estimating gas. Show the user estimated costs.

```tsx
async function estimateAndExecute(
  contract: Contract,
  method: string,
  args: unknown[],
) {
  // 1. Estimate gas
  const gasEstimate = await contract[method].estimateGas(...args);

  // 2. Add 20% buffer for safety
  const gasLimit = (gasEstimate * 120n) / 100n;

  // 3. Get current gas price
  const feeData = await contract.runner?.provider?.getFeeData();

  // 4. Calculate total cost
  const estimatedCost = gasLimit * (feeData?.gasPrice ?? 0n);

  // 5. Execute with explicit gas limit
  const tx = await contract[method](...args, { gasLimit });

  return { tx, estimatedCost };
}
```
