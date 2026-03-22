---
name: prototype
description: "Quick throwaway prototype — rapid implementation in prototypes/ directory with relaxed standards"
tools: Read, Glob, Grep, Write, Edit, Bash
---

# Prototype — Rapid Prototyping

## Purpose
Build a quick, throwaway prototype to validate an idea, test a design concept, or demo a Web3 interaction. Lives in `prototypes/` directory with intentionally relaxed code standards.

## When to Use
- Need to validate a concept before committing to full implementation
- Testing a new animation style or layout approach
- Experimenting with a smart contract interaction flow
- Building a quick demo for stakeholders
- Comparing two design approaches side by side

## Step-by-Step Workflow

### 1. Define Prototype Scope
Determine what's being validated:
- **Visual**: Design style, animation, layout concept
- **Functional**: Smart contract interaction, data flow, state management
- **UX**: User flow, onboarding, transaction experience
- **Integration**: Third-party API, DEX widget, price feed

### 2. Create Prototype Directory
```
prototypes/
  {name}-{date}/
    page.tsx        — Main prototype page
    components/     — Prototype-specific components
    README.md       — What this prototype tests, findings
```

### 3. Rapid Implementation Rules
Relaxed standards for speed:
- Inline styles allowed
- Hardcoded values allowed
- Skip error handling for happy path
- No tests required
- Single-file components OK
- `any` types acceptable
- Copy-paste from main codebase OK

### 4. Web3 Prototype Patterns
Common prototype scenarios:
- **Swap UI**: Mock token selector + price impact display + slippage
- **Mint Flow**: Connect → check eligibility → mint → success
- **Staking Dashboard**: Balance cards + APY + claim button
- **Token Chart**: Price feed + candlestick + volume bars
- **Gallery Grid**: NFT cards + filter sidebar + infinite scroll

### 5. Use Existing Design Tokens
Import from main project when available:
```typescript
import { designTokens } from '@/styles/design-tokens'
```
This ensures the prototype matches the actual project aesthetic.

### 6. Validate & Document
After building:
- Run the prototype: `pnpm dev` and navigate to prototype route
- Take screenshots or record interactions
- Document findings in `prototypes/{name}/README.md`:
  - What was tested
  - What worked / what didn't
  - Decision: adopt, modify, or discard
  - Items to carry into production code

### 7. Graduation Path
If prototype is approved:
- Extract reusable patterns to `src/components/`
- Rewrite with proper types, error handling, tests
- Delete prototype directory
- Reference prototype README in commit message

## Output Format
- Working prototype in `prototypes/` directory
- README with findings and decision
- Optional: migration plan to production

## Related Skills
`brainstorm`, `design-system`, `pick-style`, `connect-wallet`
