---
name: milestone-review
description: "Milestone review — check deliverables, quality gates, blockers"
tools: Read, Glob, Grep, Bash
---

# Milestone Review — Deliverable Assessment

## Purpose
Review project progress against defined milestones, check quality gates, identify blockers, and determine if the project is ready to advance to the next phase.

## When to Use
- End of a sprint or development phase
- Before presenting progress to stakeholders
- When deciding whether to proceed to mainnet deployment
- At predefined project checkpoints

## Step-by-Step Workflow

### 1. Load Milestone Definition
Read from `.claude/sprint-plan.md` or `.claude/project-brief.md`:
- What deliverables were promised?
- What quality standards were set?
- What was the timeline?

### 2. Deliverable Status Check
For each planned deliverable, verify:
```markdown
| Deliverable | Status | Evidence |
|-------------|--------|----------|
| Landing page | DONE | src/app/page.tsx exists, renders |
| Wallet connect | DONE | RainbowKit configured, tested |
| Token swap | PARTIAL | UI done, contract integration pending |
| Staking page | NOT STARTED | Blocked by contract |
```

Evidence types:
- File exists and has substantial content
- Tests passing for the feature
- Contract deployed and verified
- Page renders without errors

### 3. Quality Gates
Run automated checks:
```bash
pnpm build              # Build succeeds
pnpm test               # Tests pass
npx hardhat test         # Contract tests pass
pnpm lint                # No lint errors
```

Manual quality checks:
- [ ] No CRITICAL code review findings
- [ ] No CRITICAL contract audit findings
- [ ] Performance targets met (LCP < 2.5s)
- [ ] Accessibility basics pass (no critical WCAG violations)
- [ ] Mobile responsive verified

### 4. Blocker Identification
Identify what's preventing progress:
- **Technical blockers**: Missing dependency, API unavailable, contract bug
- **Design blockers**: Waiting for assets, unclear requirements
- **External blockers**: Third-party integration pending, BSCScan API limits
- **Scope blockers**: Feature expanded beyond estimate

### 5. Risk Assessment
For each remaining item:
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Contract bug on mainnet | Medium | Critical | More testnet testing |
| Design style doesn't work on mobile | Low | High | Mobile-first refactor |
| Gas costs too high for users | Medium | Medium | Optimize contract |

### 6. Go/No-Go Decision
Evaluate against criteria:
- **GO**: All critical deliverables done, quality gates pass, no critical blockers
- **CONDITIONAL GO**: Minor items remaining, plan to address within 1-2 days
- **NO-GO**: Critical deliverables missing, quality gates failing, major blockers

### 7. Generate Milestone Report
```markdown
## Milestone Review — {milestone-name} — {date}

### Status: GO / CONDITIONAL GO / NO-GO

### Deliverables
| Item | Status | Quality | Notes |

### Quality Gates
| Gate | Pass/Fail | Details |

### Blockers
| Blocker | Type | Owner | Resolution |

### Risks
| Risk | Level | Mitigation |

### Next Steps
1. Immediate actions
2. Next milestone goals
3. Carry-over items
```

## Output Format
- Deliverable status matrix
- Quality gate results
- Blocker list with owners
- Go/No-Go recommendation
- Next milestone definition

## Related Skills
`sprint-plan`, `scope-check`, `release-checklist`, `retrospective`
