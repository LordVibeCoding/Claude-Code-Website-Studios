---
name: team-polish
description: "Assemble polish team — qa-tester, e2e-tester, accessibility-specialist, performance-optimizer, seo-specialist"
tools: Read, Glob, Grep, Bash, Write, Edit, Agent
---

# Team Polish — Quality & Polish Team

## Purpose
Orchestrate a multi-agent team for final polish: testing, accessibility, performance optimization, and SEO for Web3 websites before release.

## When to Use
- After features are built, before release
- When quality feels inconsistent
- Sprint dedicated to polish and optimization
- Pre-launch quality assurance phase

## Team Composition

### qa-tester
**Role**: Functional testing and bug detection.
**Responsibilities**:
- Write and run unit tests for components and hooks
- Test Web3 interaction flows:
  - Connect wallet → view balance → disconnect
  - Approve token → execute swap → view result
  - Mint NFT → view in gallery → transfer
- Test error scenarios (wrong chain, insufficient balance, reverts)
- Test loading and empty states
- Verify data displays correctly (token amounts, addresses, dates)
- Report bugs with reproduction steps

### e2e-tester
**Role**: End-to-end user flow testing.
**Responsibilities**:
- Write E2E tests with Playwright or Cypress
- Test critical user journeys:
  - Landing page → Connect wallet → Navigate to DApp
  - Token page → Buy button → PancakeSwap redirect
  - NFT page → Mint → View owned NFTs
  - Staking → Stake → Wait → Claim rewards
- Test cross-browser (Chrome, Firefox, Safari, mobile)
- Test wallet extension interaction flows
- Verify navigation and routing works correctly
- Run visual regression tests (screenshot comparison)

### accessibility-specialist
**Role**: WCAG 2.1 compliance and inclusive design.
**Responsibilities**:
- Run `accessibility-check` skill
- Verify keyboard navigation through all interactive elements
- Test with screen reader (VoiceOver narration flow)
- Check color contrast ratios (4.5:1 minimum)
- Verify ARIA labels on Web3 components
- Ensure transaction status updates are announced
- Check focus management in modals and dropdowns
- Verify `prefers-reduced-motion` support
- Fix critical accessibility violations

### performance-optimizer
**Role**: Speed and efficiency optimization.
**Responsibilities**:
- Run `perf-profile` skill
- Optimize bundle size:
  - Dynamic import heavy components (charts, 3D, animations)
  - Tree-shake wagmi/viem imports
  - Analyze and remove unused dependencies
- Optimize rendering:
  - Identify unnecessary re-renders with React DevTools
  - Add `React.memo`, `useMemo`, `useCallback` where needed
  - Convert client components to server components where possible
- Optimize Web3:
  - Batch RPC calls with multicall
  - Configure proper staleTime in React Query
  - Reduce polling frequency for non-critical data
- Optimize assets:
  - Compress images, use WebP/AVIF
  - Preload critical fonts
  - Lazy load below-fold content

### seo-specialist
**Role**: Search engine optimization and social preview.
**Responsibilities**:
- Run `seo-check` skill
- Configure `metadata` exports on every page
- Generate Open Graph images (1200x630)
- Create `sitemap.ts` and `robots.ts`
- Add JSON-LD structured data
- Optimize heading hierarchy (H1 → H6)
- Add alt text to all images
- Configure canonical URLs
- Test social sharing previews (Twitter, Discord, Telegram)

## Workflow

### 1. Parallel Quality Assessment
Launch all 5 agents simultaneously:
```
qa-tester         → Unit tests + functional testing
e2e-tester        → E2E flow tests
accessibility     → WCAG audit
performance       → Bundle + render + Web3 optimization
seo               → Meta tags + structured data
```

### 2. Issue Collection
Aggregate all findings into a unified report:
```markdown
| # | Category | Severity | Description | File | Fix |
|---|----------|----------|-------------|------|-----|
```

### 3. Fix Prioritization
- **P0**: Broken functionality, security issues → Fix immediately
- **P1**: Accessibility violations, SEO blockers → Fix before release
- **P2**: Performance improvements → Fix if time allows
- **P3**: Nice-to-haves → Add to backlog

### 4. Fix & Verify
- Apply fixes in priority order
- Re-run affected tests after each fix
- Verify no regressions introduced

## Output Format
- Unified quality report from all 5 specialists
- Prioritized issue list
- Fixes applied and verified
- Quality scores (a11y, perf, SEO)

## Related Skills
`code-review`, `accessibility-check`, `perf-profile`, `seo-check`, `release-checklist`
