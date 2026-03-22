# Tokenomics Design Document

**Project:** [Project Name]
**Token:** $[SYMBOL]
**Date:** YYYY-MM-DD
**Author:** [Name/Handle]
**Status:** Draft | Review | Approved

---

## 1. Token Basics

| Property | Value |
|----------|-------|
| Token Name | [Full Name] |
| Symbol | $[SYMBOL] |
| Standard | BEP-20 (ERC-20 compatible) |
| Chain | BNB Smart Chain (Chain ID: 56) |
| Total Supply | [e.g., 1,000,000,000] |
| Decimals | 18 |
| Mintable | Yes / No |
| Burnable | Yes / No |
| Pausable | Yes / No |
| Upgradeable | Yes (Proxy) / No |

---

## 2. Token Distribution

### 2.1 Allocation Table

| Category | Percentage | Token Amount | Wallet Type |
|----------|-----------|-------------|-------------|
| Public Sale (IDO/IEO) | [X]% | [Amount] | [Vesting contract / direct] |
| Private Sale | [X]% | [Amount] | [Vesting contract] |
| Team & Founders | [X]% | [Amount] | [Vesting contract] |
| Advisors | [X]% | [Amount] | [Vesting contract] |
| Development Fund | [X]% | [Amount] | [Multi-sig] |
| Ecosystem & Community | [X]% | [Amount] | [Multi-sig] |
| Liquidity Pool | [X]% | [Amount] | [LP lock contract] |
| Treasury / Reserve | [X]% | [Amount] | [Multi-sig + timelock] |
| Marketing | [X]% | [Amount] | [Multi-sig] |
| Staking Rewards | [X]% | [Amount] | [Staking contract] |
| Airdrops | [X]% | [Amount] | [Airdrop contract] |
| **Total** | **100%** | **[Total Supply]** | |

### 2.2 Distribution Rules

- Maximum allocation to team + advisors: recommended <= 20%
- Liquidity pool: recommended >= 5% of supply, locked for >= 12 months
- No single non-contract wallet should hold > [X]% of total supply
- Community/ecosystem allocation should be >= 30% for healthy decentralization

---

## 3. Vesting Schedules

### 3.1 Team & Founders

| Phase | Duration | Release |
|-------|----------|---------|
| Cliff | [12] months | 0% (locked) |
| Linear Vesting | [24] months | [1/24] per month |
| Total Vesting | [36] months | 100% |

### 3.2 Private Sale

| Phase | Duration | Release |
|-------|----------|---------|
| TGE (Token Generation Event) | Day 0 | [10]% |
| Cliff | [3] months | 0% |
| Linear Vesting | [12] months | [90]% over period |
| Total Vesting | [15] months | 100% |

### 3.3 Advisors

| Phase | Duration | Release |
|-------|----------|---------|
| Cliff | [6] months | 0% |
| Linear Vesting | [18] months | [1/18] per month |
| Total Vesting | [24] months | 100% |

### 3.4 Vesting Contract Requirements

- Smart contract-enforced vesting (not manual transfers)
- Beneficiary can claim unlocked tokens at any time
- Vesting cannot be accelerated (no admin override)
- Revocable vs. irrevocable: [specify]
- Events emitted on claim for transparency

---

## 4. Fee Mechanism

### 4.1 Transaction Tax (if applicable)

| Fee Component | Buy Tax | Sell Tax | Transfer Tax |
|--------------|---------|----------|-------------|
| Liquidity Pool | [X]% | [X]% | 0% |
| Development | [X]% | [X]% | 0% |
| Marketing | [X]% | [X]% | 0% |
| Burn | [X]% | [X]% | 0% |
| Reflection/Rewards | [X]% | [X]% | 0% |
| **Total** | **[X]%** | **[X]%** | **0%** |

### 4.2 Fee Rules

- Maximum total tax: recommended <= 10% buy, <= 10% sell
- Tax-exempt addresses: contract deployer, LP pairs, vesting contracts
- Anti-whale: maximum single transaction = [X]% of total supply
- Anti-dump: maximum sell per wallet per [24h] = [X] tokens
- Cooldown between sells: [X] seconds (optional)

### 4.3 Fee Distribution Mechanism

```
Transaction Fee
    │
    ├── [X]% → Liquidity Pool (auto-add via contract)
    │            └── BNB + Token paired, added to PancakeSwap LP
    │
    ├── [X]% → Development Wallet (multi-sig)
    │            └── Used for: development, infrastructure, audits
    │
    ├── [X]% → Burn Address (0x000...dead)
    │            └── Permanently removed from supply
    │
    └── [X]% → Staking Rewards Pool
                 └── Distributed to stakers proportionally
```

---

## 5. Utility and Governance

### 5.1 Token Utility

| Utility | Description | Mechanism |
|---------|-------------|-----------|
| Governance | Vote on protocol proposals | 1 token = 1 vote (or quadratic) |
| Staking | Stake for yield and protocol revenue | Proportional reward distribution |
| Fee Discount | Reduced platform fees | [X]% discount when paying with $[SYMBOL] |
| Access/Gating | Unlock premium features | Minimum balance check |
| Collateral | Use as collateral in lending | Over-collateralized, liquidatable |
| NFT Minting | Pay mint fees in $[SYMBOL] | [X] tokens per mint |

### 5.2 Governance Parameters

| Parameter | Value |
|-----------|-------|
| Proposal Threshold | [X] tokens to create proposal |
| Quorum | [X]% of circulating supply |
| Voting Period | [X] days |
| Timelock Delay | [X] hours after vote passes |
| Vote Delegation | Allowed / Not allowed |

---

## 6. Economic Model

### 6.1 Supply Dynamics

| Force | Mechanism | Expected Impact |
|-------|-----------|----------------|
| Deflationary | Burn on transactions | -[X]% supply per year (estimated) |
| Deflationary | Buyback and burn | -[X]% supply per quarter |
| Inflationary | Staking rewards emission | +[X]% supply per year |
| Neutral | Vesting unlocks (temporary) | [X] tokens/month for [Y] months |

### 6.2 Emission Schedule

| Year | Total Supply (start) | Emissions | Burns (est.) | Total Supply (end) |
|------|---------------------|-----------|-------------|-------------------|
| 1 | [Amount] | [Staking rewards] | [Burn estimate] | [Amount] |
| 2 | [Amount] | [Staking rewards] | [Burn estimate] | [Amount] |
| 3 | [Amount] | [Staking rewards] | [Burn estimate] | [Amount] |

### 6.3 Liquidity Strategy

| DEX | Pair | Initial Liquidity | Lock Duration |
|-----|------|-------------------|---------------|
| PancakeSwap V2 | $[SYMBOL]/BNB | [X] BNB + [Y] tokens | [12] months |
| PancakeSwap V2 | $[SYMBOL]/USDT | [X] USDT + [Y] tokens | [12] months |

- LP tokens locked via [Team.Finance / PinkLock / custom lock contract]
- Lock proof: [BSCScan link to lock transaction]

### 6.4 Price Stability Mechanisms

- Anti-dump: maximum sell [X]% of wallet per 24 hours
- Auto-liquidity: [X]% of sell tax added to LP
- Buyback: treasury buys and burns during dips (governance-approved)
- Staking incentive: high APY reduces circulating supply

---

## 7. Security Considerations

### 7.1 Contract Security

- [ ] Reentrancy guard on all token transfer hooks
- [ ] Ownable with renounce capability
- [ ] Timelock on tax rate changes (minimum [24h] delay)
- [ ] Maximum tax cap hardcoded (e.g., cannot exceed 15%)
- [ ] Blacklist function limited or absent (potential rug vector)
- [ ] No hidden mint function
- [ ] LP lock verified on-chain

### 7.2 Risk Factors

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Smart contract exploit | Medium | Critical | Audit, bug bounty, insurance |
| Liquidity drain | Low | Critical | LP locked, multi-sig treasury |
| Team dump | Low | High | Vesting contracts, public wallets |
| Regulatory action | Medium | High | Legal opinion, jurisdictional compliance |
| Low adoption | Medium | Medium | Marketing, partnerships, utility |

---

## 8. Appendix

### A. Token Contract Interface

```solidity
interface IToken is IERC20 {
    function burn(uint256 amount) external;
    function setTaxRate(uint256 buyTax, uint256 sellTax) external;
    function excludeFromTax(address account) external;
    function includeInTax(address account) external;
    function setMaxTransaction(uint256 amount) external;
    function setMaxWallet(uint256 amount) external;
}
```

### B. Multi-sig Wallet Addresses

| Purpose | Address | Signers | Threshold |
|---------|---------|---------|-----------|
| Treasury | [0x...] | [N] | [M-of-N] |
| Development | [0x...] | [N] | [M-of-N] |
| Marketing | [0x...] | [N] | [M-of-N] |

### C. Comparable Projects

| Project | Supply | Burn | Tax | Market Cap |
|---------|--------|------|-----|-----------|
| [Comp 1] | [X]B | [X]%/tx | [X]%/[X]% | $[X]M |
| [Comp 2] | [X]B | [X]%/tx | [X]%/[X]% | $[X]M |

---

_This document is a living document and will be updated as the project evolves._
