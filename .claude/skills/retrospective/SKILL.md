---
name: retrospective
description: "Sprint retrospective — what went well, what didn't, action items"
tools: Read, Glob, Grep, Bash, AskUserQuestion
---

# Retrospective — Sprint Retrospective

## Purpose
Conduct a structured sprint retrospective: analyze what worked, what didn't, extract lessons learned, and generate actionable improvements for next sprint.

## When to Use
- End of a sprint or development phase
- After a major feature delivery
- After a production incident
- When development velocity feels off

## Step-by-Step Workflow

### 1. Gather Sprint Data
Collect objective metrics:
```bash
# Commits in sprint period
git log --oneline --since="{sprint-start}" --until="{sprint-end}" | wc -l

# Files changed
git diff --stat {sprint-start-commit}..HEAD

# Lines added/removed
git diff --shortstat {sprint-start-commit}..HEAD
```

Read:
- `.claude/sprint-plan.md` — What was planned
- Recent milestone review reports
- Any bug reports or incidents

### 2. Delivery Assessment
Compare planned vs delivered:
```markdown
| Planned | Delivered | On Time | Quality |
|---------|-----------|---------|---------|
| Landing page | Yes | Yes | Good |
| Token swap | Partial | Late | OK |
| Staking | No | — | — |
```

Calculate delivery rate: `delivered / planned * 100%`

### 3. What Went Well
Ask via `AskUserQuestion` and analyze code:
- Which features were delivered smoothly?
- What technical decisions paid off?
- Which tools/libraries saved time?
- What reusable patterns emerged?

Common Web3 wins to check for:
- Clean contract-to-frontend integration pipeline
- Design system enabled fast UI building
- wagmi hooks made Web3 interaction clean
- GSAP animations worked first try
- Testnet deployment caught issues early

### 4. What Didn't Go Well
Identify friction points:
- Which tasks took longer than estimated? Why?
- Were there any rework cycles?
- Did scope creep occur? (invoke `scope-check` data)
- Any dependency issues? (versions, APIs, RPCs)
- What caused frustration?

Common Web3 pain points:
- Contract changes requiring ABI regeneration
- RPC rate limits during development
- Wallet connection edge cases on mobile
- Gas estimation inaccuracies
- BSCScan verification failures
- Animation performance on low-end devices

### 5. Lessons Learned
Extract patterns:
- **Process**: What process changes would help?
- **Technical**: What architectural decisions to revisit?
- **Tools**: What tools to add or remove?
- **Knowledge**: What knowledge gaps were exposed?

### 6. Generate Action Items
Create specific, assignable actions:
```markdown
| Action | Owner | Priority | Sprint |
|--------|-------|----------|--------|
| Add multicall to reduce RPC calls | team-web3 | High | Next |
| Create reusable transaction flow hook | team-frontend | Medium | Next |
| Setup contract ABI auto-generation | team-contract | High | Next |
| Add error boundary around wallet components | team-frontend | Medium | Next |
```

### 7. Generate Retrospective Document
Save to `.claude/retrospective-{date}.md`:
```markdown
## Sprint Retrospective — {sprint-name} — {date}

### Metrics
- Delivery rate: X%
- Commits: N
- Files changed: N

### What Went Well
1. ...

### What Didn't Go Well
1. ...

### Lessons Learned
1. ...

### Action Items
| Action | Priority | Target Sprint |

### Team Morale: [1-5 scale]
```

## Output Format
- Objective sprint metrics
- Categorized feedback (good/bad/learned)
- Actionable improvement items
- `.claude/retrospective-{date}.md` created

## Related Skills
`sprint-plan`, `milestone-review`, `scope-check`, `tech-debt`
