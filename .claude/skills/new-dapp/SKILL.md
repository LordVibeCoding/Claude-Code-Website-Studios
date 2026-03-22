---
name: new-dapp
description: "Create DApp project — wallet connection, contract integration, DApp-specific UI scaffold"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion
---

# New DApp — Decentralized Application Generator

## Purpose
Scaffold a complete DApp on BNB Chain with wallet connection, smart contract integration, and type-safe contract hooks.

## When to Use
- User wants to build a DEX, staking platform, lending protocol, NFT marketplace, or custom DApp
- Any project requiring on-chain interaction beyond simple token display

## Step-by-Step Workflow

### 1. Identify DApp Type
Ask via `AskUserQuestion`:
```
What type of DApp?
1. DEX / Swap — Token swap interface with liquidity pools
2. Staking / Yield — Stake tokens, earn rewards
3. Lending / Borrowing — Supply and borrow assets
4. NFT Marketplace — Buy, sell, auction NFTs
5. DAO / Governance — Proposal and voting system
6. Custom DApp — Describe your use case
```

### 2. Define Contract Requirements
Based on DApp type, determine needed contracts:
- **DEX**: Router, Factory, Pair, WBNB wrapper
- **Staking**: StakingPool, RewardDistributor, TimeLock
- **Lending**: LendingPool, PriceOracle, InterestRateModel
- **NFT Marketplace**: Marketplace, Escrow, RoyaltyEngine
- **DAO**: Governor, TimelockController, VotingToken

### 3. Scaffold Contract Integration
Generate in `src/contracts/`:
```
src/contracts/
  abis/           — Contract ABIs (JSON)
  addresses.ts    — Contract addresses per chain
  hooks/          — wagmi useReadContract/useWriteContract hooks
  types.ts        — TypeScript types from ABI
```

### 4. Setup Wallet Connection
Invoke `connect-wallet` skill to configure:
- wagmi v2 with BNB Chain (56) and BSC Testnet (97)
- RainbowKit with custom theme matching design style
- Auto-connect, chain switching, disconnect handling
- Transaction notification system

### 5. Generate DApp Pages
Create pages specific to DApp type:
- **DEX**: Swap page, Pool page, Liquidity page
- **Staking**: Dashboard, Stake/Unstake, Rewards
- **Lending**: Markets, Supply, Borrow, Liquidations
- **NFT Marketplace**: Browse, Item Detail, Create Listing
- **DAO**: Proposals, Vote, Delegate

### 6. Add Web3 Utilities
Generate `src/lib/web3/`:
- `formatters.ts` — Token amounts, addresses, timestamps
- `constants.ts` — Chain IDs, block explorers, RPC URLs
- `errors.ts` — User-friendly transaction error messages
- `multicall.ts` — Batch read optimization

### 7. Transaction UX
Create transaction flow components:
- Approval flow (check allowance → approve → execute)
- Transaction pending/success/error states
- Gas estimation display
- Recent transactions list

## Output Format
- Contract ABIs and typed hooks
- DApp-specific pages and components
- Wallet connection configured
- Transaction UX components

## Related Skills
`connect-wallet`, `deploy-contract`, `contract-review`, `setup-stack`
