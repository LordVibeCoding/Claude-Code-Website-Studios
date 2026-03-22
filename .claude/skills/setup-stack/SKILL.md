---
name: setup-stack
description: "Configure technology stack — install deps, setup Next.js, Tailwind, wagmi, Hardhat configs"
tools: Read, Glob, Bash, Write, Edit
---

# Setup Stack — Technology Stack Configuration

## Purpose
Install and configure the complete Web3 website development stack: Next.js 15, TypeScript, Tailwind CSS 4, wagmi v2, viem, RainbowKit, Hardhat, and supporting libraries.

## When to Use
- Starting a new project from scratch
- `package.json` doesn't exist or is missing key dependencies
- Need to add Web3 capabilities to an existing Next.js project

## Step-by-Step Workflow

### 1. Initialize Next.js 15
```bash
npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
```
If project already exists, skip and verify `next.config.ts`.

### 2. Install Core Dependencies
```bash
# Web3
pnpm add wagmi viem @tanstack/react-query @rainbow-me/rainbowkit

# Animation
pnpm add gsap @gsap/react framer-motion

# UI Utilities
pnpm add clsx tailwind-merge class-variance-authority lucide-react

# Dev Dependencies
pnpm add -D @types/node hardhat @nomicfoundation/hardhat-toolbox hardhat-deploy
pnpm add -D @openzeppelin/contracts
```

### 3. Configure Tailwind CSS 4
Update `tailwind.config.ts`:
- Add custom color palette (from design tokens)
- Configure font families (Inter, Space Grotesk, JetBrains Mono)
- Add custom spacing/breakpoints
- Setup animation keyframes
- Configure `content` paths for all source files

### 4. Configure wagmi v2
Create `src/config/wagmi.ts`:
- Define BNB Chain (56) and BSC Testnet (97) configs
- Setup transports (public RPC + optional Ankr/QuickNode)
- Configure connectors (MetaMask, WalletConnect, Coinbase)
- Setup `@tanstack/react-query` QueryClient
- Create WagmiProvider wrapper component

### 5. Configure Hardhat
Create `hardhat.config.ts`:
- BSC mainnet and testnet networks
- Solidity 0.8.x compiler with optimizer (200 runs)
- BSCScan verification API key (from env)
- Gas reporter config
- TypeChain for type generation

### 6. Setup Project Structure
```
src/
  app/              — Next.js App Router pages
  components/       — React components
    ui/             — Base UI components
    layout/         — Header, Footer, Sidebar
    web3/           — Wallet, Transaction, Chain components
  contracts/        — ABIs, addresses, hooks
  hooks/            — Custom React hooks
  lib/              — Utilities, helpers, constants
  styles/           — Global styles, design tokens
  config/           — wagmi, chains, env config
  types/            — TypeScript type definitions
contracts/          — Solidity smart contracts
  test/             — Contract tests
  scripts/          — Deploy scripts
public/             — Static assets
```

### 7. Environment Setup
Create `.env.example`:
```
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=
NEXT_PUBLIC_CHAIN_ID=97
BSC_MAINNET_RPC=https://bsc-dataseed.binance.org
BSC_TESTNET_RPC=https://data-seed-prebsc-1-s1.binance.org:8545
BSCSCAN_API_KEY=
DEPLOYER_PRIVATE_KEY=
```

### 8. Utility Files
- `src/lib/cn.ts` — `clsx` + `tailwind-merge` helper
- `src/lib/constants.ts` — Chain IDs, explorer URLs, token addresses
- `src/lib/formatters.ts` — Address truncation, token formatting

## Output Format
- Fully configured Next.js 15 project
- All dependencies installed
- Config files for wagmi, Hardhat, Tailwind
- Project directory structure created
- Environment template ready

## Related Skills
`start`, `new-site`, `new-dapp`, `connect-wallet`, `design-system`
