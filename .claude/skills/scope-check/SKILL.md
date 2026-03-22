---
name: scope-check
description: "Scope creep detection — compare current work against sprint plan, flag deviations"
tools: Read, Glob, Grep, Bash
---

# Scope Check — Scope Creep Detection

## Purpose
Compare current development work against the sprint plan and project brief, identify scope creep, unplanned features, and deviation from original requirements.

## When to Use
- Mid-sprint to verify alignment with plan
- When a feature is taking longer than estimated
- Before accepting new feature requests
- When the project feels like it's growing uncontrollably

## Step-by-Step Workflow

### 1. Load Project Boundaries
Read project definition files:
- `.claude/project-brief.md` — Original scope and requirements
- `.claude/sprint-plan.md` — Current sprint tasks and estimates
- `CLAUDE.md` — Project constraints and priorities
- Git branch naming / PR titles for planned features

### 2. Inventory Current Work
Scan the codebase for what's actually been built:
- List all pages in `src/app/` — are they in the plan?
- List all components — which are unplanned?
- Check `contracts/` — any unscoped contracts?
- Review recent git commits — what was worked on?
```bash
git log --oneline --since="sprint-start-date" | head -50
```

### 3. Compare Plan vs Reality
Create a comparison matrix:
```markdown
| Planned Feature | Status | Notes |
|----------------|--------|-------|
| Hero section   | Done   | As planned |
| Token swap     | In progress | Added extra chart — SCOPE CREEP |
| Staking page   | Not started | On track |
| NFT gallery    | Done   | NOT IN PLAN — who requested? |
```

### 4. Identify Scope Creep Patterns
Flag common Web3 scope creep:
- "Just add a chart" → Full TradingView integration
- "Simple token page" → Became a DEX
- "Basic mint page" → Added rarity system, reveal mechanism
- "Connect wallet" → Added multi-chain, ENS resolution, wallet profiles
- "Quick landing page" → 10+ pages with animations

### 5. Impact Assessment
For each deviation, evaluate:
- **Time impact**: How much extra time was/will be spent?
- **Quality risk**: Does it dilute focus on core features?
- **Dependency risk**: Does it block other planned work?
- **Value**: Does the unplanned feature actually add value?

### 6. Recommend Actions
For each out-of-scope item:
- **KEEP**: High value, low cost, already done
- **DEFER**: Move to next sprint/phase
- **CUT**: Remove, doesn't align with goals
- **SIMPLIFY**: Reduce to minimum viable version

### 7. Generate Scope Report
```markdown
## Scope Check Report — {date}

### Sprint: {sprint-name}
### Planned items: N | Completed: N | In-scope: N | Out-of-scope: N

### Scope Deviations
| Item | Type | Impact | Recommendation |

### Timeline Impact
- Original estimate: X days
- Current trajectory: Y days
- Deviation: +Z days

### Action Items
1. Items to cut/defer
2. Items to simplify
3. Plan adjustments needed
```

## Output Format
- Plan vs reality comparison table
- Identified scope deviations with impact
- Recommended actions (keep/defer/cut/simplify)
- Updated timeline estimate

## Related Skills
`sprint-plan`, `estimate`, `milestone-review`, `tech-debt`
