---
name: brainstorm
description: "Creative ideation session — structured brainstorming for features, design, UX"
tools: Read, Glob, Grep, AskUserQuestion
---

# Brainstorm — Creative Ideation

## Purpose
Run a structured brainstorming session for Web3 website features, design concepts, tokenomics, user flows, or marketing strategies. Uses interactive Q&A to explore ideas.

## When to Use
- Starting feature planning for a new project
- Stuck on design direction or UX flow
- Exploring innovative Web3 features
- Ideating tokenomics or game mechanics

## Step-by-Step Workflow

### 1. Define Brainstorm Scope
Ask via `AskUserQuestion`:
```
What area do you want to brainstorm?
1. Features & Functionality — What should the product do?
2. Design & Visual — How should it look and feel?
3. User Experience — How should users interact?
4. Tokenomics & Mechanics — Token utility, incentives, game theory
5. Growth & Marketing — How to attract and retain users?
6. Open — Free-form exploration
```

### 2. Context Gathering
- Read `CLAUDE.md` and `.claude/project-brief.md` for project context
- Scan existing pages/components to understand current state
- Check `contracts/` for existing on-chain features
- Review competitor sites in the same niche

### 3. Generate Ideas Matrix
For each brainstorm area, generate ideas across dimensions:

**Features**: Core utility | Social/community | Gamification | Analytics | Composability
**Design**: Hero section | Navigation | Data visualization | Micro-interactions | Empty states
**UX**: Onboarding flow | First-time user | Power user | Error recovery | Delight moments
**Tokenomics**: Earning | Spending | Staking | Governance | Burn mechanics
**Growth**: Referral | Airdrop | Quest system | Partnerships | Content

### 4. Interactive Refinement
For each promising idea, drill deeper with `AskUserQuestion`:
- "This concept: [idea]. Scale 1-5 how interested?"
- "Should this be MVP or Phase 2?"
- "Any existing Web3 project does this well?"
- "Technical constraints or dependencies?"

### 5. Prioritization Framework
Score surviving ideas:
| Criteria | Weight |
|----------|--------|
| User impact | 30% |
| Technical feasibility | 25% |
| Uniqueness / moat | 20% |
| Time to implement | 15% |
| Revenue potential | 10% |

### 6. Output Ideation Document
Create `.claude/brainstorm-{date}.md`:
- Session summary
- Top 5-10 ideas with scores
- Recommended MVP features
- Future roadmap candidates
- Technical dependencies identified
- Open questions for further research

## Output Format
- Interactive Q&A session
- Prioritized ideas document in `.claude/`
- Feature candidates ready for `sprint-plan`

## Related Skills
`sprint-plan`, `estimate`, `prototype`, `start`
