---
name: release-checklist
description: "Pre-release verification — tests, contracts verified, security reviewed, performance acceptable"
tools: Read, Glob, Grep, Bash
---

# Release Checklist — Pre-Release Verification

## Purpose
Comprehensive pre-release verification ensuring the Web3 website is ready for deployment: all tests passing, contracts verified, security reviewed, and performance meets targets.

## When to Use
- Before deploying to production
- Before switching from testnet to mainnet
- Before announcing launch to the community
- As final quality gate

## Step-by-Step Workflow

### 1. Build Verification
```bash
pnpm build
```
- [ ] Build completes without errors
- [ ] No TypeScript errors
- [ ] No ESLint warnings on critical rules
- [ ] Bundle size within budget (<200KB first load JS)
- [ ] All pages generate without errors

### 2. Test Suite
```bash
pnpm test              # Frontend tests
npx hardhat test       # Contract tests
pnpm test:e2e          # E2E tests (if configured)
```
- [ ] All unit tests passing
- [ ] All integration tests passing
- [ ] Contract tests passing with coverage > 80%
- [ ] E2E tests for critical flows passing
- [ ] No skipped tests without documented reason

### 3. Contract Verification
- [ ] Contracts deployed to mainnet (if applicable)
- [ ] Source code verified on BSCScan
- [ ] Constructor arguments correct
- [ ] Owner/admin set to correct address (multisig recommended)
- [ ] Initial state correct (supply, permissions, parameters)
- [ ] Upgrade path documented (if proxy pattern)

### 4. Security Sign-Off
Invoke `security-audit` and `contract-review` if not done recently:
- [ ] No CRITICAL or HIGH security findings
- [ ] All dependencies up to date (`pnpm audit` clean)
- [ ] No secrets in codebase
- [ ] CSP headers configured
- [ ] Rate limiting enabled on API routes
- [ ] Contract audit completed (internal or external)

### 5. Performance Check
Invoke `perf-profile`:
- [ ] LCP < 2.5s on 3G
- [ ] CLS < 0.1
- [ ] INP < 200ms
- [ ] Images optimized (WebP/AVIF)
- [ ] Fonts loaded without FOUT
- [ ] No render-blocking resources

### 6. SEO & Accessibility
Invoke `seo-check` and `accessibility-check`:
- [ ] All pages have meta titles and descriptions
- [ ] Open Graph images generated
- [ ] Sitemap and robots.txt present
- [ ] WCAG AA compliance (no critical violations)
- [ ] Keyboard navigation works

### 7. Web3 Functionality
- [ ] Wallet connect works (MetaMask, WalletConnect, Coinbase)
- [ ] Correct chain detection and switch prompt
- [ ] All contract interactions work on target network
- [ ] Transaction error messages user-friendly
- [ ] Token amounts display correctly (decimals)
- [ ] Block explorer links correct (BSCScan)

### 8. Environment & Config
- [ ] `.env.production` has all required variables
- [ ] `NEXT_PUBLIC_CHAIN_ID` set to 56 (mainnet)
- [ ] RPC endpoints are production-grade (not public defaults)
- [ ] WalletConnect project ID is production
- [ ] Analytics configured
- [ ] Error tracking configured (Sentry, etc.)

### 9. Generate Release Report
```markdown
## Release Checklist — v{version} — {date}

### Status: READY / NOT READY

### Checks
| Category | Status | Blockers |
|----------|--------|----------|
| Build | PASS/FAIL | |
| Tests | PASS/FAIL | |
| Security | PASS/FAIL | |
| Performance | PASS/FAIL | |
| SEO | PASS/FAIL | |
| Accessibility | PASS/FAIL | |
| Web3 | PASS/FAIL | |
| Config | PASS/FAIL | |

### Blockers (if NOT READY)
1. Issue — Fix required

### Sign-Off
- [ ] Developer sign-off
- [ ] Security sign-off
- [ ] Contract sign-off
```

## Output Format
- Pass/fail checklist for all categories
- Blocker list if not ready
- Sign-off section
- Clear READY / NOT READY verdict

## Related Skills
`launch-checklist`, `security-audit`, `perf-profile`, `contract-review`
