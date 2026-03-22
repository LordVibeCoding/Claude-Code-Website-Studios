---
name: team-web3
description: "Assemble Web3 team — web3-lead, wallet-integration-developer, blockchain-developer, subgraph-developer"
tools: Read, Glob, Grep, Write, Edit, Bash, Agent
---

# Team Web3 — Web3 Integration Team

## Purpose
Orchestrate a multi-agent team for Web3 integration: wallet connection, blockchain data reading, contract interaction hooks, and indexing/subgraph setup for BNB Chain.

## When to Use
- Setting up Web3 integration for a new project
- Adding new contract interactions to the frontend
- Building real-time blockchain data features
- Optimizing on-chain data fetching

## Team Composition

### web3-lead
**Role**: Web3 architecture, chain configuration, integration strategy.
**Responsibilities**:
- Define Web3 integration architecture
- Choose data fetching strategy (RPC vs indexer vs API)
- Configure chain settings (BSC mainnet, testnet, RPCs)
- Coordinate between wallet, contract, and data layers
- Define error handling strategy for chain interactions
- Review all Web3 code for security and correctness

### wallet-integration-developer
**Role**: Wallet connection and user identity.
**Responsibilities**:
- Configure wagmi v2 with BNB Chain
- Setup RainbowKit with custom theme
- Implement connection flow (connect → detect chain → switch if needed)
- Build wallet UI components (ConnectButton, AddressDisplay, Balance)
- Handle mobile wallet deep links
- Implement Sign-In with Ethereum (SIWE) if needed
- Handle multi-wallet edge cases
- Persist connection across page navigation

### blockchain-developer
**Role**: Contract interaction hooks and transaction management.
**Responsibilities**:
- Generate typed contract hooks from ABIs
- Implement read hooks: `useReadContract`, `useReadContracts` (multicall)
- Implement write hooks: `useWriteContract` with preparation
- Build approval flow: check allowance → approve → execute
- Create transaction status tracking (pending → confirming → success/error)
- Implement event watching for real-time updates
- Handle gas estimation and price display
- Build error decoder for Solidity revert reasons

### subgraph-developer
**Role**: Indexed data and historical queries.
**Responsibilities**:
- Setup subgraph or indexer for contract events
- Define entity schemas for indexed data
- Implement event handlers (Transfer, Swap, Mint, Stake)
- Build GraphQL queries for historical data
- Alternative: Setup BSCScan API integration for event logs
- Alternative: Configure The Graph or Envio for BSC
- Build data transformation layer
- Implement pagination for large data sets

## Workflow

### 1. Architecture (web3-lead)
Define the integration layers:
```
src/
  config/
    wagmi.ts           — wagmi + chain config
    contracts.ts       — Contract addresses per chain
  contracts/
    abis/              — Contract ABIs
    hooks/             — Generated contract hooks
  hooks/
    useWallet.ts       — Wallet connection state
    useTransaction.ts  — Transaction lifecycle
    useTokenData.ts    — Token-specific data hooks
  lib/
    web3/
      formatters.ts    — Address, amount, date formatters
      errors.ts        — Error decoding and messages
      multicall.ts     — Batched read utilities
```

### 2. Parallel Setup
Launch agents simultaneously:
- **wallet-integration-developer**: wagmi + RainbowKit setup
- **blockchain-developer**: Contract hooks and transaction flows
- **subgraph-developer**: Indexer setup and historical data queries

### 3. Integration
- Connect wallet hooks to contract hooks
- Wire up real-time data to UI components
- Connect indexed data to dashboard/analytics pages

### 4. Testing
- Test wallet connect/disconnect cycle
- Test on BSC testnet with real transactions
- Verify error handling for all failure modes:
  - User rejects in wallet
  - Insufficient balance
  - Contract revert
  - RPC timeout
  - Wrong chain
- Load test RPC calls (multicall optimization)

## Output Format
- wagmi configuration with BNB Chain
- Typed contract hooks
- Transaction management system
- Wallet UI components
- Indexed data queries (if applicable)
- Error handling for all Web3 interactions

## Related Skills
`connect-wallet`, `deploy-contract`, `team-contract`, `team-frontend`
