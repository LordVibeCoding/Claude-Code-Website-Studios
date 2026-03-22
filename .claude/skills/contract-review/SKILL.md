---
name: contract-review
description: "Smart contract security review — reentrancy, access control, gas, overflow, front-running audit"
tools: Read, Glob, Grep
---

# Contract Review — Smart Contract Security Audit

## Purpose
Perform a comprehensive security review of Solidity smart contracts targeting BNB Chain, covering common vulnerabilities, gas optimization, and best practices.

## When to Use
- Before deploying any contract to testnet or mainnet
- After modifying contract logic
- Reviewing third-party contract integrations
- Periodic security assessment of deployed contracts

## Step-by-Step Workflow

### 1. Inventory Contracts
Scan `contracts/` directory:
- List all `.sol` files with their purpose
- Check Solidity version (must be 0.8.x for overflow safety)
- Identify imported libraries (OpenZeppelin, etc.)
- Map contract inheritance hierarchy
- Check compiler settings in `hardhat.config.ts`

### 2. Reentrancy Analysis
- [ ] State changes BEFORE external calls (checks-effects-interactions)
- [ ] `nonReentrant` modifier on functions that transfer value
- [ ] No callback patterns without reentrancy guards
- [ ] Cross-function reentrancy considered
- [ ] Read-only reentrancy in view functions checked

### 3. Access Control
- [ ] `onlyOwner` / role-based access on admin functions
- [ ] Ownership transfer is two-step (OZ `Ownable2Step`)
- [ ] No unprotected `selfdestruct` or `delegatecall`
- [ ] Constructor sets owner correctly
- [ ] Timelock on critical parameter changes
- [ ] Renounce ownership implications documented

### 4. Integer & Math Safety
- [ ] Solidity 0.8.x used (built-in overflow checks)
- [ ] `unchecked` blocks justified and safe
- [ ] Division before multiplication avoided
- [ ] Decimal precision handled correctly (18 decimals standard)
- [ ] Token amount calculations use SafeMath patterns

### 5. Front-Running & MEV
- [ ] Commit-reveal for sensitive operations
- [ ] Slippage protection on swap functions
- [ ] Deadline parameter on time-sensitive transactions
- [ ] No price-dependent logic without oracle protection
- [ ] Batch operations don't create sandwich opportunities

### 6. Token-Specific Checks (BEP20)
- [ ] Transfer fee/tax logic handles edge cases
- [ ] Approve race condition mitigated (increaseAllowance)
- [ ] Max wallet/max transaction limits work correctly
- [ ] Anti-bot delay mechanism (if present) has bypass for owner
- [ ] Liquidity lock mechanism verified
- [ ] Mint/burn permissions properly restricted

### 7. Gas Optimization
- [ ] Storage variables packed efficiently (32-byte slots)
- [ ] `calldata` used instead of `memory` for external function params
- [ ] Mappings preferred over arrays for lookups
- [ ] Events emitted for important state changes (cheaper than storage)
- [ ] Loop bounds checked (no unbounded iterations)
- [ ] `immutable` and `constant` used for fixed values

### 8. External Interaction Safety
- [ ] Low-level `.call` used instead of `.transfer`/`.send`
- [ ] Return values of external calls checked
- [ ] Untrusted contract interactions isolated
- [ ] Oracle manipulation resistance (TWAP, multiple sources)
- [ ] Flash loan attack vectors considered

### 9. Generate Audit Report
```markdown
## Smart Contract Audit Report — {date}

### Contracts Reviewed
| Contract | LOC | Complexity |
|----------|-----|------------|

### CRITICAL — Exploitable vulnerabilities
### HIGH — Security risks
### MEDIUM — Best practice violations
### LOW — Gas optimizations
### INFORMATIONAL — Code quality

### Vulnerability Summary
| Category | Critical | High | Medium | Low |
|----------|----------|------|--------|-----|

### Recommendations
1. Priority fixes
2. Gas optimization suggestions
3. Architecture improvements
```

## Output Format
- Detailed audit report with categorized findings
- Specific line references and exploit scenarios
- Fix suggestions with code examples
- Gas optimization recommendations

## Related Skills
`deploy-contract`, `security-audit`, `code-review`
