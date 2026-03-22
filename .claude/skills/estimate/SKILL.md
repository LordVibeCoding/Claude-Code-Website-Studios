---
name: estimate
description: "Effort estimation — analyze requirements, provide time/complexity estimates"
tools: Read, Glob, Grep, AskUserQuestion
---

# Estimate — Effort Estimation

## Purpose
Analyze feature requirements and provide realistic effort estimates for Web3 website development tasks, accounting for frontend, contract, integration, and testing work.

## When to Use
- Before committing to a timeline or sprint plan
- When user asks "how long will this take?"
- Evaluating feasibility of a feature request
- Comparing implementation approaches by cost

## Step-by-Step Workflow

### 1. Clarify Requirements
Use `AskUserQuestion` if requirements are ambiguous:
- What exactly needs to be built?
- Is there an existing pattern to follow?
- What's the minimum viable version?
- Any non-negotiable features?

### 2. Break Into Work Streams
Every Web3 feature touches multiple layers:

| Stream | Examples |
|--------|---------|
| **Contract** | Solidity code, tests, deployment, verification |
| **Frontend** | Pages, components, styling, animations |
| **Integration** | wagmi hooks, ABI, contract calls, error handling |
| **Design** | Design tokens, responsive, animation polish |
| **Testing** | Unit, integration, E2E, contract tests |
| **DevOps** | Deployment, monitoring, CI/CD |

### 3. Estimate Each Stream
Use reference benchmarks for Web3 projects:

| Task | Typical Estimate |
|------|-----------------|
| Simple component (Button, Card) | 30min - 1h |
| Complex component (Swap widget, Mint card) | 2-4h |
| Full page with data fetching | 2-4h |
| GSAP/Framer animation section | 1-3h |
| BEP20 token contract + tests | 2-4h |
| NFT contract (ERC721A) + tests | 4-8h |
| DEX router integration | 4-8h |
| Staking contract + UI | 8-16h |
| Wallet connection setup | 1-2h |
| Contract deployment + verification | 1-2h |
| Design system base | 4-8h |
| Full landing page (5 sections) | 8-16h |
| Complete token page | 16-24h |
| Complete DApp | 40-80h |

### 4. Apply Multipliers
Adjust estimates for complexity:
- **New tech** (first time using a library): 1.5x
- **Complex animation** (3D, scroll storytelling): 1.5-2x
- **Contract security critical** (handles funds): 2x for testing
- **Multi-chain support**: 1.3x
- **Responsive across all breakpoints**: 1.2x
- **Accessibility compliance**: 1.2x

### 5. Identify Risk Factors
Flag items that could blow up the estimate:
- Unaudited third-party contract integration
- Complex animation interactions (GSAP + scroll + resize)
- Real-time data requirements (WebSocket, polling)
- First-time BSC deployment (testnet faucet, gas issues)
- Multi-wallet compatibility testing

### 6. Provide Estimate Range
Always give a range, never a single number:
```
Optimistic (everything goes right): X hours
Realistic (normal friction): Y hours
Pessimistic (problems encountered): Z hours
```

### 7. Generate Estimate Document
```markdown
## Estimate: {feature-name}

### Summary
| Stream | Optimistic | Realistic | Pessimistic |
|--------|-----------|-----------|-------------|
| Contract | | | |
| Frontend | | | |
| Integration | | | |
| Testing | | | |
| **Total** | **Xh** | **Yh** | **Zh** |

### Assumptions
- List key assumptions

### Risk Factors
- Items that could increase estimate

### Recommendation
- Suggested approach and timeline
```

## Output Format
- Work stream breakdown
- Three-point estimate (optimistic/realistic/pessimistic)
- Risk factors and assumptions
- Recommended approach

## Related Skills
`sprint-plan`, `brainstorm`, `scope-check`
