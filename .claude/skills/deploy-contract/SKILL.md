---
name: deploy-contract
description: "Deploy smart contract — compile, test, deploy to BSC testnet/mainnet, verify on BSCScan"
tools: Read, Glob, Grep, Write, Edit, Bash
---

# Deploy Contract — Smart Contract Deployment

## Purpose
Compile, test, and deploy Solidity smart contracts to BNB Chain (testnet or mainnet) using Hardhat, then verify source code on BSCScan.

## When to Use
- Deploying a new smart contract (token, NFT, staking, etc.)
- Upgrading a contract deployment
- Switching from testnet to mainnet deployment
- Re-verifying a contract on BSCScan

## Step-by-Step Workflow

### 1. Pre-Deployment Checks
Before any deployment:
- [ ] All contract tests passing: `npx hardhat test`
- [ ] Gas estimation acceptable: `npx hardhat test --gas-reporter`
- [ ] No compiler warnings in production contracts
- [ ] Constructor arguments documented
- [ ] Invoke `contract-review` for security check
- [ ] `.env` has `DEPLOYER_PRIVATE_KEY` and `BSCSCAN_API_KEY`

### 2. Verify Hardhat Config
Check `hardhat.config.ts` has:
```typescript
networks: {
  bscTestnet: {
    url: process.env.BSC_TESTNET_RPC || 'https://data-seed-prebsc-1-s1.binance.org:8545',
    chainId: 97,
    accounts: [process.env.DEPLOYER_PRIVATE_KEY],
  },
  bscMainnet: {
    url: process.env.BSC_MAINNET_RPC || 'https://bsc-dataseed.binance.org',
    chainId: 56,
    accounts: [process.env.DEPLOYER_PRIVATE_KEY],
  },
},
etherscan: {
  apiKey: { bsc: process.env.BSCSCAN_API_KEY, bscTestnet: process.env.BSCSCAN_API_KEY },
},
```

### 3. Write Deploy Script
Create `scripts/deploy-{contract}.ts`:
- Import contract factory
- Parse constructor arguments from config or env
- Deploy with gas price/limit settings
- Wait for deployment confirmation (2-3 blocks on BSC)
- Log deployed address
- Save deployment info to `deployments/{network}/{contract}.json`

### 4. Deploy to Testnet First
```bash
npx hardhat run scripts/deploy-{contract}.ts --network bscTestnet
```
- Record deployed address
- Test all functions manually or with integration tests
- Verify contract behavior matches expectations

### 5. Verify on BSCScan
```bash
npx hardhat verify --network bscTestnet {CONTRACT_ADDRESS} {CONSTRUCTOR_ARGS}
```
- For contracts with complex constructor args, create `arguments.ts` file
- Verify proxy implementation if using upgradeable pattern

### 6. Update Frontend Integration
After successful deployment:
- Update `src/contracts/addresses.ts` with new address
- Copy ABI from `artifacts/` to `src/contracts/abis/`
- Regenerate typed hooks if using TypeChain
- Update wagmi contract config

### 7. Mainnet Deployment
When testnet validation is complete:
```bash
npx hardhat run scripts/deploy-{contract}.ts --network bscMainnet
```
- Double-check gas price (BSC gas is low but still matters)
- Verify on BSCScan mainnet
- Update frontend addresses for mainnet chain ID

### 8. Post-Deployment Checklist
- [ ] Contract verified on BSCScan
- [ ] Frontend reads from correct contract address
- [ ] All write functions work with connected wallet
- [ ] Events are emitting correctly
- [ ] Owner/admin functions restricted properly
- [ ] Save deployment TX hash and block number
- [ ] Document deployment in `deployments/README.md`

## Output Format
- Compiled contracts in `artifacts/`
- Deploy scripts in `scripts/`
- Deployment records in `deployments/`
- BSCScan verified source code
- Frontend contract config updated

## Related Skills
`contract-review`, `connect-wallet`, `new-dapp`, `new-token`, `new-nft`
