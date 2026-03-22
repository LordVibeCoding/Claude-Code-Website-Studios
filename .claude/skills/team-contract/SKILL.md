---
name: team-contract
description: "Assemble contract team — smart-contract-lead, solidity-developer, contract-auditor, token-engineer"
tools: Read, Glob, Grep, Write, Edit, Bash, Agent
---

# Team Contract — Smart Contract Development Team

## Purpose
Orchestrate a multi-agent team for smart contract development on BNB Chain: Solidity development, testing, auditing, and tokenomics engineering.

## When to Use
- Developing new smart contracts
- Building token or NFT contracts
- Contract upgrade or modification
- Pre-deployment contract verification

## Team Composition

### smart-contract-lead
**Role**: Architecture, coordination, deployment strategy.
**Responsibilities**:
- Design contract architecture (inheritance, interfaces, libraries)
- Choose upgrade pattern (if needed): transparent proxy, UUPS, diamond
- Define deployment order and initialization sequence
- Coordinate between developers and auditor
- Manage contract addresses and deployment records

### solidity-developer
**Role**: Core contract implementation.
**Responsibilities**:
- Write Solidity contracts in `contracts/`
- Implement using OpenZeppelin base contracts
- Follow checks-effects-interactions pattern
- Write comprehensive NatSpec documentation
- Implement access control (Ownable2Step, AccessControl)
- Gas-optimize storage and logic

### contract-auditor
**Role**: Security review and vulnerability detection.
**Responsibilities**:
- Run `contract-review` skill on all contracts
- Check for reentrancy, overflow, front-running
- Verify access control completeness
- Test edge cases and attack vectors
- Validate economic assumptions
- Generate audit report

### token-engineer
**Role**: Tokenomics and economic design.
**Responsibilities**:
- Design token distribution and vesting schedules
- Implement fee/tax mechanisms (if applicable)
- Design staking reward calculations
- Model economic incentives and game theory
- Validate anti-whale and anti-bot mechanisms
- Ensure liquidity pool mechanics are sound

## Workflow

### 1. Architecture Planning (smart-contract-lead)
Define contract structure:
```
contracts/
  interfaces/
    IToken.sol          — Token interface
    IStaking.sol        — Staking interface
  Token.sol             — BEP20 token implementation
  Staking.sol           — Staking pool
  Vesting.sol           — Token vesting
  libraries/
    TokenMath.sol       — Shared math utilities
```

### 2. Parallel Development
Launch agents:
- **solidity-developer**: Implement contracts following architecture
- **token-engineer**: Design and validate tokenomics parameters
- Both reference OpenZeppelin contracts and BSC-specific patterns

### 3. Testing Phase
```bash
npx hardhat test
npx hardhat coverage
```
Test coverage targets:
- All public/external functions tested
- Edge cases (zero values, max values, overflow)
- Access control tests (unauthorized calls revert)
- Multi-step flow tests (approve → stake → claim → withdraw)

### 4. Audit Phase (contract-auditor)
- Full security review
- Gas optimization review
- Economic model validation
- Attack vector analysis
- Generate signed audit report

### 5. Deployment (smart-contract-lead)
- Deploy to BSC testnet first
- Integration test with frontend
- Deploy to BSC mainnet
- Verify on BSCScan
- Update frontend contract config

## Output Format
- Solidity contracts with NatSpec documentation
- Comprehensive test suite (>90% coverage)
- Audit report
- Deployment records
- Frontend integration config (ABIs, addresses)

## Related Skills
`deploy-contract`, `contract-review`, `new-token`, `new-nft`, `team-web3`
