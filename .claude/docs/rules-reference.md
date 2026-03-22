# Rules Reference — All 11 Path-Scoped Rules

## Overview

Rules are path-scoped coding standards that agents enforce when working in specific directories. They are defined in CLAUDE.md under "Path-Scoped Rules" and enforced by the relevant department leads and specialists.

---

## Rule Definitions

### 1. Site Pages Rule

| Field | Value |
|-------|-------|
| **Path** | `src/site/**` |
| **Enforced By** | Frontend Lead, React Developer, SEO Specialist |
| **Gate** | Creative Director (design), QA Lead (accessibility) |

**Standards:**
- All pages must export `metadata` (Next.js Metadata API) with title, description, Open Graph, Twitter card
- Server-side rendered where possible (RSC by default)
- Core Web Vitals targets: LCP < 2.5s, FID < 100ms, CLS < 0.1
- All images use `next/image` with explicit width/height and WebP format
- No client-side data fetching for SEO-critical content
- Structured data (JSON-LD) for key pages
- Semantic HTML (`<main>`, `<article>`, `<section>`, `<nav>`)
- WCAG 2.1 AA compliance minimum

**How to customize:** Adjust Core Web Vitals targets based on project needs. Add page-specific metadata requirements.

---

### 2. DApp Pages Rule

| Field | Value |
|-------|-------|
| **Path** | `src/dapp/**` |
| **Enforced By** | Frontend Lead, Web3 Lead, React Developer |
| **Gate** | Technical Director (architecture), QA Lead (testing) |

**Standards:**
- Every page must handle wallet not connected state
- Error boundaries around all contract interaction components
- Loading states for all async operations (skeleton UI, not spinners)
- Transaction pending/success/error states displayed clearly
- Chain mismatch detection and switch prompt
- Graceful degradation when RPC is unavailable
- All contract calls wrapped in try-catch with user-friendly error messages
- No raw error messages exposed to users (e.g., "execution reverted")

**How to customize:** Add DApp-specific states (e.g., insufficient liquidity, slippage warnings) per project type.

---

### 3. Smart Contracts Rule

| Field | Value |
|-------|-------|
| **Path** | `src/contracts/**` |
| **Enforced By** | Smart Contract Lead, Solidity Developer, Contract Auditor |
| **Gate** | Security Lead (audit), Technical Director (architecture) |

**Standards:**
- Solidity 0.8.x with explicit compiler version (`pragma solidity ^0.8.20`)
- All functions must have NatSpec documentation (`@dev`, `@param`, `@return`)
- Reentrancy guard on all external-calling functions (use OpenZeppelin `ReentrancyGuard`)
- No hardcoded gas values — use dynamic gas estimation
- Access control on all administrative functions (Ownable or AccessControl)
- Events emitted for all state changes
- No `tx.origin` for authentication (use `msg.sender`)
- No floating pragma — pin exact Solidity version
- All public/external functions tested with 100% branch coverage
- Gas optimization: avoid storage reads in loops, use `calldata` over `memory`

**How to customize:** Add project-specific security patterns (e.g., pause mechanism, timelock).

---

### 4. Shared Components Rule

| Field | Value |
|-------|-------|
| **Path** | `src/components/**` |
| **Enforced By** | UI/UX Lead, Design System Developer, Frontend Lead |
| **Gate** | Creative Director (visual), QA Lead (testing) |

**Standards:**
- All components must have typed props (`interface Props { ... }`)
- Default exports only — one component per file
- Props interface exported alongside component
- Storybook-ready: must work in isolation without page context
- Responsive by default (mobile-first breakpoints)
- Support light/dark mode via design tokens
- No hardcoded colors, spacing, or font sizes — use Tailwind tokens or design variables
- `data-testid` attributes on interactive elements for E2E testing
- Forwarded refs where applicable (`React.forwardRef`)

**How to customize:** Add project-specific component patterns (e.g., loading skeleton variants).

---

### 5. Custom Hooks Rule

| Field | Value |
|-------|-------|
| **Path** | `src/hooks/**` |
| **Enforced By** | Frontend Lead, React Developer |
| **Gate** | Technical Director (patterns) |

**Standards:**
- Follow `use` prefix naming convention
- Proper cleanup in `useEffect` return functions (unsubscribe, cancel, clear)
- No direct DOM manipulation — use refs
- AbortController for fetch requests
- Custom hooks must be composable (accept config objects, return consistent shapes)
- Error state handling in all hooks that perform async operations
- TypeScript generics where applicable for reusability
- No side effects on mount without cleanup

**How to customize:** Add Web3-specific hook patterns (e.g., `useContractRead` wrappers).

---

### 6. Utility Libraries Rule

| Field | Value |
|-------|-------|
| **Path** | `src/lib/**` |
| **Enforced By** | Technical Director, Frontend Lead |
| **Gate** | Technical Director (architecture) |

**Standards:**
- Pure functions only — no side effects, no mutations
- Full TypeScript type coverage (no `any`, no `as` casting)
- 100% unit test coverage for all exported functions
- No imports from `src/components/` or `src/app/` (dependency direction: lib → nothing)
- Tree-shakeable exports (named exports, no barrel files that re-export everything)
- Constants in UPPER_SNAKE_CASE
- Immutable patterns — return new objects, never mutate arguments
- JSDoc comments on all exported functions

**How to customize:** Add domain-specific utility categories (e.g., `lib/web3/`, `lib/format/`).

---

### 7. Styles Rule

| Field | Value |
|-------|-------|
| **Path** | `src/styles/**` |
| **Enforced By** | UI/UX Lead, Visual Designer, Design System Developer |
| **Gate** | Creative Director (brand) |

**Standards:**
- Design tokens as TypeScript objects (not CSS custom properties alone)
- Responsive breakpoints: `sm: 640px`, `md: 768px`, `lg: 1024px`, `xl: 1280px`, `2xl: 1536px`
- Dark mode support via Tailwind `dark:` variant
- Color system with semantic names (`primary`, `secondary`, `accent`, `destructive`, `muted`)
- Typography scale defined (heading 1-6, body, caption, overline)
- Spacing scale: 4px base unit (4, 8, 12, 16, 24, 32, 48, 64, 96)
- Animation tokens: duration (`fast: 150ms`, `normal: 300ms`, `slow: 500ms`) and easing curves
- No `!important` unless overriding third-party library styles (documented)

**How to customize:** Adjust color palette, typography, and spacing to match brand guidelines.

---

### 8. Design Documents Rule

| Field | Value |
|-------|-------|
| **Path** | `design/**` |
| **Enforced By** | Creative Director, UI/UX Lead |
| **Gate** | Creative Director (approval) |

**Standards:**
- Required sections in every design doc:
  - **Overview** — what is being designed and why
  - **User Persona** — who is the target user
  - **User Flow** — step-by-step user journey
- Wireframes or mockup references included
- Color palette and typography specified
- Interaction notes for animations and transitions
- Responsive behavior documented (mobile/tablet/desktop)
- Accessibility considerations noted

**How to customize:** Add project-specific sections (e.g., "Token Economy UI" for DeFi projects).

---

### 9. Test Files Rule

| Field | Value |
|-------|-------|
| **Path** | `tests/**` |
| **Enforced By** | QA Lead, QA Tester, E2E Tester |
| **Gate** | QA Lead (coverage), Technical Director (patterns) |

**Standards:**
- Naming: `*.test.ts` for unit/integration, `*.spec.ts` for E2E
- Naming pattern: `[feature].test.ts` or `[feature].spec.ts`
- Minimum 80% coverage for unit tests
- Tests grouped by `describe` blocks matching feature/component names
- Each test has a clear description: `it('should [expected behavior] when [condition]')`
- No test interdependencies — each test runs in isolation
- Mock external services (RPC, APIs) — never hit real endpoints in tests
- Contract tests use Hardhat's local network with forked state
- E2E tests use Playwright with wallet mocking

**How to customize:** Adjust coverage thresholds, add contract-specific test patterns.

---

### 10. Production Documents Rule

| Field | Value |
|-------|-------|
| **Path** | `production/**` |
| **Enforced By** | Producer |
| **Gate** | Producer (approval) |

**Standards:**
- Sprint plans follow standard template (goal, stories, tasks, estimates, assignments)
- Milestone documents track: planned vs actual, velocity, risks
- Release notes include: features, fixes, breaking changes, deployment steps
- Contract review logs reference specific contract files and audit findings
- Session logs capture: date, accomplishments, blockers, next steps

**How to customize:** Add project-specific tracking (e.g., token launch milestones, audit rounds).

---

### 11. Assets Rule

| Field | Value |
|-------|-------|
| **Path** | `src/assets/**` |
| **Enforced By** | Visual Designer, Performance Optimizer |
| **Gate** | Creative Director (quality), Frontend Lead (performance) |

**Standards:**
- File naming: kebab-case (`hero-background.webp`, not `heroBackground.webp`)
- Images: WebP format preferred, fallback PNG/JPG only when necessary
- Maximum image file size: 200KB for non-hero images, 500KB for hero/background
- SVG icons: cleaned and optimized (no editor metadata)
- Fonts: WOFF2 format, subset to characters needed
- No duplicate assets — check before adding
- Alt text requirements documented alongside images

**How to customize:** Adjust size limits, add brand-specific asset naming conventions.

---

## Rules Summary Table

| # | Path | Key Focus | Enforcer |
|---|------|-----------|----------|
| 1 | `src/site/**` | SEO, accessibility, Core Web Vitals | Frontend Lead |
| 2 | `src/dapp/**` | Wallet-aware, error boundaries, loading states | Web3 Lead |
| 3 | `src/contracts/**` | Gas optimized, reentrancy safe, auditable | Smart Contract Lead |
| 4 | `src/components/**` | Reusable, typed props, Storybook-ready | UI/UX Lead |
| 5 | `src/hooks/**` | Cleanup, composable, async error handling | Frontend Lead |
| 6 | `src/lib/**` | Pure functions, no side effects, full types | Technical Director |
| 7 | `src/styles/**` | Design tokens, responsive, dark mode | UI/UX Lead |
| 8 | `design/**` | Required sections, user flows | Creative Director |
| 9 | `tests/**` | Naming, coverage, isolation | QA Lead |
| 10 | `production/**` | Sprint plans, milestones, releases | Producer |
| 11 | `src/assets/**` | Naming, optimization, size limits | Visual Designer |
