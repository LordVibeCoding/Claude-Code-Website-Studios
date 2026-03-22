---
name: project-stage-detect
description: "Detect project stage by scanning files, git history, dependencies"
tools: Read, Glob, Grep, Bash
---

# Project Stage Detect — Automatic Stage Detection

## Purpose
Automatically determine the current development stage of a Web3 website project by analyzing file structure, git history, dependencies, and code maturity.

## When to Use
- When opening a project for the first time
- When `start` skill needs to understand current state
- When generating status reports
- When deciding which skills are relevant

## Step-by-Step Workflow

### 1. File Structure Scan
Check for key indicators:
```
Level 0 (Empty):
  - No package.json
  - No src/ directory
  - Maybe just CLAUDE.md or README

Level 1 (Scaffolded):
  - package.json exists
  - next.config.* exists
  - src/app/ has layout.tsx + page.tsx
  - tailwind.config.* exists
  - No substantial components

Level 2 (In Development):
  - Multiple pages in src/app/
  - Components in src/components/
  - Design tokens or theme configured
  - Some contract files in contracts/
  - Active development visible

Level 3 (Feature Complete):
  - All planned pages exist with content
  - Contract integration working
  - Wallet connection configured
  - Tests exist (not necessarily passing)
  - Design system established

Level 4 (Production Ready):
  - All tests passing
  - Contracts deployed and verified
  - Performance optimized
  - SEO configured
  - Security reviewed
  - Documentation complete
```

### 2. Git History Analysis
```bash
git log --oneline | wc -l          # Commit count
git log --oneline -1 --format=%cr  # Last commit age
git branch -a                       # Branch structure
git tag                             # Release tags
```

Infer stage from git:
- 0 commits → Empty
- 1-5 commits → Scaffolded
- 5-50 commits → In Development
- 50-200 commits → Feature Complete
- 200+ commits with tags → Production Ready

### 3. Dependency Analysis
Check `package.json` for installed packages:
- **No package.json**: Stage 0
- **Next.js only**: Stage 1
- **wagmi + viem**: Web3 capabilities added
- **GSAP / Framer Motion**: Animation work started
- **Testing libs**: Quality practices in place
- **@openzeppelin**: Contract development active

### 4. Contract Stage
Check `contracts/` and `deployments/`:
- No contracts → No contract layer
- `.sol` files only → Development
- Tests in `test/` → Testing phase
- `deployments/testnet/` → Testnet deployed
- `deployments/mainnet/` → Production deployed

### 5. Quality Indicators
Check for quality signals:
- `.eslintrc` / `eslint.config.*` → Linting configured
- `jest.config.*` / `vitest.config.*` → Testing configured
- `.github/workflows/` → CI/CD setup
- `Dockerfile` → Containerized
- `.env.example` → Environment documented

### 6. Generate Stage Report
```markdown
## Project Stage Report

### Overall Stage: {0-4} — {stage-name}

### Layer Status
| Layer | Stage | Evidence |
|-------|-------|----------|
| Frontend | In Development | 5 pages, 12 components |
| Contracts | Scaffolded | 2 contracts, no tests |
| Web3 Integration | Not Started | wagmi not configured |
| Design | In Development | Design tokens exist |
| Testing | Not Started | No test files found |
| DevOps | Not Started | No CI/CD |

### File Counts
- Pages: N
- Components: N
- Contracts: N
- Tests: N
- Total LOC: ~N

### Suggested Next Steps
1. Based on current stage, recommend immediate actions
2. Identify gaps between layers
3. Suggest appropriate skills to invoke
```

## Output Format
- Stage classification (0-4)
- Layer-by-layer status
- File counts and metrics
- Recommended next steps and skills

## Related Skills
`start`, `tech-debt`, `scope-check`, `sprint-plan`
