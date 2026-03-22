---
name: start
description: "Guided project setup — detect stage, ask what to build, route to setup skills"
tools: Read, Glob, Grep, Bash, AskUserQuestion, Agent
---

# Start — Project Entry Point

## Purpose
Detect current project stage and guide user through initial setup. Routes to the correct bootstrap skill based on what they want to build.

## When to Use
- First time opening the project
- User says "start", "new project", "init", "begin"
- Project directory is empty or partially set up

## Step-by-Step Workflow

### 1. Detect Project Stage
Run `project-stage-detect` to scan:
- Check for `package.json`, `next.config.*`, `hardhat.config.*`
- Check for `contracts/`, `src/app/`, `public/` directories
- Check git history depth and last commit
- Classify: `empty` | `scaffolded` | `in-progress` | `mature`

### 2. Ask What They're Building
Use `AskUserQuestion` with options:
```
What are you building?
1. Official Website — Brand site, landing page, product showcase
2. DApp — DEX, staking, lending, NFT marketplace
3. Token Page — BEP20 token info + buy/swap
4. NFT Project — Collection mint page + gallery
5. Continue existing project
```

### 3. Route to Setup Skill
| Choice | Skill | Follow-up |
|--------|-------|-----------|
| Website | `new-site` | Ask industry, brand, style |
| DApp | `new-dapp` | Ask DApp type, features |
| Token | `new-token` | Ask token details, contract address |
| NFT | `new-nft` | Ask collection details |
| Continue | `project-stage-detect` | Analyze and suggest next steps |

### 4. Stack Setup
After routing, invoke `setup-stack` if `package.json` doesn't exist.
Then invoke `pick-style` for design direction.

### 5. Generate Project Brief
Create `.claude/project-brief.md` with:
- Project type and description
- Target chain (BSC mainnet / testnet)
- Selected design style
- Key pages and features
- Contract requirements (if any)

## Output Format
- Interactive Q&A session via `AskUserQuestion`
- `.claude/project-brief.md` generated
- Routed to appropriate bootstrap skill

## Related Skills
`new-site`, `new-dapp`, `new-token`, `new-nft`, `setup-stack`, `pick-style`, `project-stage-detect`
