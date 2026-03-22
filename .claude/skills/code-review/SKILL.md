---
name: code-review
description: "Full code review — architecture, SOLID, Web3 patterns, structured report with severity levels"
tools: Read, Glob, Grep
---

# Code Review — Comprehensive Code Analysis

## Purpose
Perform a thorough code review of Next.js + Web3 codebase, checking architecture, coding standards, Web3 best practices, and producing a structured report with actionable findings.

## When to Use
- After completing a feature or significant code change
- Before merging a branch or creating a PR
- Periodic codebase health check
- After another developer's contribution

## Step-by-Step Workflow

### 1. Scope the Review
Determine review scope:
- **Full**: Entire `src/` and `contracts/` directories
- **Focused**: Specific files or directories changed recently
- **Diff**: Only files changed since last commit/branch point
Use `git diff --name-only` for focused reviews.

### 2. Check Project Standards
Read `CLAUDE.md` and `.claude/` configs for project-specific rules:
- Code style requirements
- Architecture patterns
- Naming conventions
- File organization rules

### 3. Architecture Review
- [ ] App Router pages follow consistent patterns
- [ ] Components are properly separated (ui / layout / web3 / feature)
- [ ] Hooks encapsulate reusable logic
- [ ] No business logic in components (extract to hooks/utils)
- [ ] Proper separation: contracts/ → hooks/ → components/ → pages/
- [ ] No circular dependencies

### 4. TypeScript Quality
- [ ] No `any` types (except prototype code)
- [ ] Proper generic usage in Web3 hooks
- [ ] Contract types generated from ABIs
- [ ] Props interfaces defined for all components
- [ ] Discriminated unions for state management
- [ ] Strict null checks respected

### 5. Web3 Patterns
- [ ] Contract addresses from config, not hardcoded
- [ ] ABIs imported correctly, typed with `as const`
- [ ] Transaction error handling covers user rejection, insufficient gas, revert
- [ ] Approval flow before token operations
- [ ] Chain ID checks before contract calls
- [ ] BigInt used for token amounts (not Number)
- [ ] Proper decimal handling for different tokens

### 6. React / Next.js Patterns
- [ ] Server vs Client components used appropriately
- [ ] `'use client'` only where needed
- [ ] Proper Suspense boundaries
- [ ] Loading and error states for data fetching
- [ ] No unnecessary re-renders (memo, useMemo, useCallback)
- [ ] Image optimization with Next.js Image
- [ ] Metadata exports for SEO

### 7. Security Check
- [ ] No private keys or secrets in source
- [ ] User input sanitized
- [ ] CSP headers configured
- [ ] No `dangerouslySetInnerHTML` without sanitization
- [ ] Environment variables properly prefixed (`NEXT_PUBLIC_`)

### 8. Generate Report
Output structured review with severity levels:

```markdown
## Code Review Report — {date}

### CRITICAL (must fix)
- [C1] Description — file:line — Fix suggestion

### HIGH (should fix)
- [H1] Description — file:line — Fix suggestion

### MEDIUM (recommended)
- [M1] Description — file:line — Fix suggestion

### LOW (nice to have)
- [L1] Description — file:line — Fix suggestion

### POSITIVE
- Things done well worth noting

### Summary
- Files reviewed: N
- Issues found: N (C:x H:x M:x L:x)
- Overall quality: [score/10]
```

## Output Format
- Structured review report with severity levels
- Specific file:line references
- Actionable fix suggestions
- Overall quality score

## Related Skills
`contract-review`, `security-audit`, `design-review`, `tech-debt`
