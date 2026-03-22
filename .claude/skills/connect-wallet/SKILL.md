---
name: connect-wallet
description: "Implement wallet connection — wagmi v2, RainbowKit, chain config, wallet hooks"
tools: Read, Glob, Grep, Write, Edit, Bash
---

# Connect Wallet — Wallet Integration

## Purpose
Setup complete wallet connection flow for BNB Chain using wagmi v2 and RainbowKit, including chain switching, transaction management, and connection state handling.

## When to Use
- Setting up wallet connection in a new DApp
- Adding Web3 capabilities to an existing site
- Upgrading wallet integration (e.g., wagmi v1 to v2)
- Fixing wallet connection issues

## Step-by-Step Workflow

### 1. Install Dependencies
```bash
pnpm add wagmi viem @tanstack/react-query @rainbow-me/rainbowkit
```

### 2. Configure Chains
Create `src/config/chains.ts`:
```typescript
import { bsc, bscTestnet } from 'viem/chains'

export const supportedChains = [bsc, bscTestnet] as const
export const defaultChain = process.env.NEXT_PUBLIC_CHAIN_ID === '56' ? bsc : bscTestnet
```

### 3. Configure wagmi
Create `src/config/wagmi.ts`:
- Define transports for each chain (public + fallback RPCs)
- Configure connectors: MetaMask, WalletConnect, Coinbase Wallet, Injected
- Set `WalletConnectProjectId` from env
- Enable auto-connect with `reconnectOnMount: true`
- Setup `@tanstack/react-query` client with sensible defaults

### 4. Create Provider Wrapper
Create `src/providers/Web3Provider.tsx`:
```typescript
// Wraps: WagmiProvider > QueryClientProvider > RainbowKitProvider
// Handles: SSR hydration, theme sync, locale
```
Integrate into `src/app/layout.tsx`.

### 5. Custom RainbowKit Theme
Create `src/config/rainbow-theme.ts`:
- Match project's design tokens (colors, fonts, radii)
- Custom `darkTheme()` or `lightTheme()` override
- Brand-colored accent for connect button
- Custom modal styling

### 6. Build Wallet Hooks
Create `src/hooks/`:
- `useWalletConnection.ts` — Connection state, address, chain, disconnect
- `useChainSwitch.ts` — Switch to correct chain with error handling
- `useTokenBalance.ts` — BNB and BEP20 token balances
- `useTransactionFlow.ts` — Submit → pending → confirm → success/error
- `useApproval.ts` — Check allowance → request approval → wait
- `useWrongChain.ts` — Detect wrong chain, prompt switch

### 7. Build Wallet Components
Create `src/components/web3/`:
- `ConnectButton.tsx` — Custom styled connect button (wraps RainbowKit)
- `WalletInfo.tsx` — Connected address, balance, chain indicator
- `ChainSwitcher.tsx` — Switch between BSC mainnet/testnet
- `DisconnectButton.tsx` — Disconnect with confirmation
- `WrongChainBanner.tsx` — Full-width warning when on wrong chain
- `TransactionToast.tsx` — Transaction status notifications

### 8. Handle Edge Cases
- Server-side rendering: Use `mounted` state to avoid hydration mismatch
- Mobile wallets: Deep link support for MetaMask/Trust Wallet mobile
- Multiple wallets: Handle wallet conflict when multiple extensions installed
- Network errors: Retry logic for RPC failures
- Session persistence: Reconnect on page refresh
- Account/chain change: React to `accountChanged` and `chainChanged` events

### 9. Add BSC-Specific Config
- Pre-configure BSC RPC endpoints with fallbacks
- Add BNB as native currency display
- Configure BSCScan as block explorer
- Add common BSC tokens to token list (BUSD, USDT, CAKE, etc.)

## Output Format
- wagmi + RainbowKit fully configured
- Provider wrapper integrated in layout
- Custom hooks for wallet interaction
- Wallet UI components
- Edge cases handled

## Related Skills
`setup-stack`, `new-dapp`, `deploy-contract`, `design-system`
