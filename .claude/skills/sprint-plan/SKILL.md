---
name: sprint-plan
description: "Sprint planning — break features into tasks, estimate effort, assign to agents, create timeline"
tools: Read, Glob, Grep, Write, AskUserQuestion
---

# Sprint Plan — Sprint Planning

## Purpose
Break down features into implementable tasks, estimate effort, assign to agent teams, and create a sprint timeline for Web3 website development.

## When to Use
- Starting a new development sprint
- Planning a feature implementation
- After brainstorming to turn ideas into tasks
- When the team needs clear direction

## Step-by-Step Workflow

### 1. Gather Sprint Inputs
Read context:
- `.claude/project-brief.md` — Project goals
- `.claude/brainstorm-*.md` — Ideation outputs (if any)
- Recent `scope-check` or `tech-debt` reports
- User feature requests via `AskUserQuestion`

### 2. Define Sprint Goal
One clear sentence: "By end of sprint, users can [action]"
Examples:
- "Users can connect wallet and view token balance"
- "Users can mint NFTs during whitelist phase"
- "Users can swap tokens via PancakeSwap integration"

### 3. Break Down Features
For each feature, create task hierarchy:
```
Feature: Token Swap Page
├── Task 1: Setup PancakeSwap router integration (contract hooks)
├── Task 2: Build token selector component
├── Task 3: Implement price quote display
├── Task 4: Build swap confirmation modal
├── Task 5: Add transaction history
└── Task 6: Write tests for swap flow
```

### 4. Estimate Effort
Use T-shirt sizing mapped to hours:
| Size | Hours | Description |
|------|-------|-------------|
| XS | <1h | Config change, copy update, simple fix |
| S | 1-2h | Single component, simple hook |
| M | 2-4h | Feature with multiple components |
| L | 4-8h | Complex feature, contract + frontend |
| XL | 8-16h | Multi-page feature, new integration |

### 5. Assign to Agent Teams
Map tasks to teams from team-* skills:
| Task Type | Agent Team |
|-----------|------------|
| UI components, pages, animations | `team-frontend` |
| Smart contracts, deploy, test | `team-contract` |
| Design system, visual, UX | `team-design` |
| Wallet, chain, on-chain data | `team-web3` |
| Deploy, CI/CD, monitoring | `team-release` |
| QA, a11y, perf, SEO | `team-polish` |

### 6. Identify Dependencies
Create dependency graph:
```
setup-stack → connect-wallet → contract-hooks → swap-page → tests
                                                     ↑
                              design-system → token-selector
```
Flag blockers and critical path items.

### 7. Create Sprint Timeline
```markdown
## Sprint: {name} — {start} to {end}

### Day 1-2: Foundation
- [ ] Setup stack and design system
- [ ] Deploy contracts to testnet

### Day 3-4: Core Features
- [ ] Build main pages
- [ ] Implement contract interactions

### Day 5-6: Polish
- [ ] Animation and transitions
- [ ] Error handling and edge cases

### Day 7: Review & Ship
- [ ] Code review + contract review
- [ ] Performance and accessibility check
- [ ] Deploy to staging
```

### 8. Write Sprint Plan
Save to `.claude/sprint-plan.md` with all tasks, estimates, assignments, and timeline.

## Output Format
- Sprint goal statement
- Task breakdown with estimates
- Agent team assignments
- Dependency graph
- Day-by-day timeline
- `.claude/sprint-plan.md` created

## Related Skills
`estimate`, `brainstorm`, `scope-check`, `milestone-review`, `team-frontend`, `team-contract`
