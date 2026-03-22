---
name: hotfix
description: "Emergency fix workflow — identify issue, create fix branch, minimal change, deploy"
tools: Read, Glob, Grep, Write, Edit, Bash
---

# Hotfix — Emergency Fix Workflow

## Purpose
Rapid emergency fix process for production issues: identify the bug, create a minimal fix, test, and deploy with minimal risk and maximum speed.

## When to Use
- Production site is broken or showing errors
- Smart contract interaction failing for users
- Security vulnerability discovered in production
- Critical visual bug affecting user experience

## Step-by-Step Workflow

### 1. Triage the Issue
Identify severity level:
- **P0 — Site Down**: Page not loading, white screen, build failure
- **P1 — Feature Broken**: Wallet connect fails, transactions fail, mint broken
- **P2 — Degraded UX**: Layout broken, animation glitch, data not loading
- **P3 — Minor Visual**: Typo, wrong color, alignment issue

### 2. Create Hotfix Branch
```bash
git checkout -b hotfix/{issue-description} main
```
NEVER fix directly on main. Always branch.

### 3. Identify Root Cause
Based on issue type, check common causes:

**Site Down**:
- Check `pnpm build` output for errors
- Check for broken imports or missing dependencies
- Check environment variables in production
- Check if contract addresses are correct for production chain

**Web3 Broken**:
- Check RPC endpoint availability
- Check contract ABI matches deployed contract
- Check chain ID configuration
- Check wallet connection provider setup
- Check if contract is paused/locked

**UI Broken**:
- Check responsive breakpoints
- Check for missing `'use client'` directive
- Check Tailwind classes purging issue
- Check SSR hydration mismatch

### 4. Minimal Fix Rule
**CRITICAL**: Hotfixes must be MINIMAL.
- Fix ONLY the broken thing
- No refactoring
- No "while we're at it" improvements
- No dependency upgrades
- Change as few files as possible
- If in doubt, revert the breaking change

### 5. Test the Fix
```bash
pnpm build                    # Build succeeds
pnpm test -- --related        # Related tests pass
```
Manual verification:
- Reproduce the original bug → confirm it's fixed
- Test adjacent functionality → confirm nothing else broke
- Test on mobile if UI-related
- Test wallet connection if Web3-related

### 6. Contract Hotfix (if applicable)
If the issue is in a smart contract:
- **Cannot hotfix deployed contracts** (immutable)
- Options:
  - Deploy new contract version + update frontend addresses
  - Use admin function to adjust parameters (if available)
  - Pause contract (if pause mechanism exists)
  - Deploy proxy upgrade (if upgradeable pattern)
- Document the contract change and communicate to users

### 7. Deploy Fix
```bash
git add {only-changed-files}
git commit -m "fix: {description of what was broken and how it's fixed}"
git checkout main
git merge hotfix/{issue-description}
```
Deploy immediately via production pipeline.

### 8. Post-Hotfix
- [ ] Verify fix is live in production
- [ ] Monitor error tracking for issue recurrence
- [ ] Notify team/community that issue is resolved
- [ ] Create follow-up ticket for proper fix if hotfix was a band-aid
- [ ] Add test to prevent regression
- [ ] Update `CHANGELOG.md` with fix
- [ ] Retrospective: Why did this happen? How to prevent?

## Output Format
- Root cause identified
- Minimal fix applied
- Tests verified
- Deployed to production
- Post-fix monitoring active

## Related Skills
`release-checklist`, `code-review`, `contract-review`, `security-audit`
