---
name: new-token
description: "Create BEP20 token page — token info display, contract interaction, buy/swap integration"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion
---

# New Token — BEP20 Token Page Generator

## Purpose
Build a token-centric website for a BEP20 token on BNB Chain with live price, tokenomics display, and swap/buy integration.

## When to Use
- User is launching a BEP20 token and needs a website
- Token already deployed and needs a marketing/info page
- Meme token, utility token, or governance token sites

## Step-by-Step Workflow

### 1. Gather Token Details
Ask via `AskUserQuestion`:
- Token name, symbol, decimals
- Contract address (or "not deployed yet")
- Total supply and distribution breakdown
- Token utility description
- DEX listing (PancakeSwap, etc.)
- Social links (Twitter, Telegram, Discord)

### 2. Setup Token Contract Integration
If contract address provided:
- Fetch ABI from BSCScan API or use standard BEP20 ABI
- Generate typed hooks in `src/contracts/hooks/useToken.ts`:
  - `useTokenBalance` — User balance
  - `useTokenSupply` — Total/circulating supply
  - `useTokenPrice` — Price from DEX pair
  - `useTokenAllowance` — Approval state
  - `useTokenTransfer` — Transfer tokens

### 3. Generate Token Pages
```
src/app/
  page.tsx          — Hero with live price ticker
  tokenomics/       — Distribution chart, vesting schedule
  buy/page.tsx      — PancakeSwap embed or custom swap UI
  staking/page.tsx  — Staking interface (if applicable)
  airdrop/page.tsx  — Claim page (if applicable)
```

### 4. Build Token Components
- `TokenHero.tsx` — Name, logo, price, 24h change, market cap
- `TokenStats.tsx` — Supply, holders, transactions, liquidity
- `TokenChart.tsx` — Price chart (integrate DexScreener or GeckoTerminal iframe)
- `Tokenomics.tsx` — Pie/donut chart with distribution
- `BuyWidget.tsx` — PancakeSwap swap widget or router integration
- `ContractInfo.tsx` — Contract address with copy + BSCScan link
- `HowToBuy.tsx` — Step-by-step buy guide for newcomers

### 5. Live Data Integration
Setup data fetching:
- On-chain: wagmi hooks for supply, balance, price from pair
- Off-chain: DexScreener API for price history, volume
- WebSocket: Real-time price updates via BSC node or API
- Cache with `@tanstack/react-query` for optimal UX

### 6. Security Features
- Contract verification link (BSCScan)
- Audit report link section
- Liquidity lock display (if applicable)
- Renounced ownership badge (if applicable)
- Tax/fee display for taxed tokens

### 7. Marketing Sections
- Partners/backers logos
- Roadmap timeline
- Team section (optional, anon-friendly)
- FAQ accordion
- Newsletter signup

## Output Format
- Token info pages with live data
- Swap/buy integration
- Tokenomics visualization
- Security verification display

## Related Skills
`new-site`, `connect-wallet`, `deploy-contract`, `pick-style`
