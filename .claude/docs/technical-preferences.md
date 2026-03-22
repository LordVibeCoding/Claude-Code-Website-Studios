# Technical Preferences

Default technology choices for all studio projects. Deviations require an ADR approved by the Technical Director.

---

## Framework & Language

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Frontend Framework** | Next.js 15 (App Router) | Pages Router, Remix, Vite SPA | RSC, streaming, file-based routing, built-in optimization |
| **Routing** | App Router | Pages Router | Server Components, layouts, loading/error states, parallel routes |
| **Language** | TypeScript 5 (strict mode) | JavaScript | Type safety for contract ABIs, props, API responses |
| **TypeScript Config** | `strict: true`, `noUncheckedIndexedAccess: true` | Permissive config | Catch errors at compile time, not runtime |

### TypeScript Strictness Requirements

```json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "forceConsistentCasingInFileNames": true,
    "exactOptionalPropertyTypes": true
  }
}
```

---

## Styling

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **CSS Framework** | Tailwind CSS 4 | CSS-in-JS (styled-components, Emotion) | Zero runtime, utility-first, design token integration |
| **CSS Architecture** | Tailwind utilities + CSS Modules (for complex components) | Sass, Less, CSS-in-JS | Tailwind for 90% of styling, CSS Modules for animations/complex selectors |
| **Design Tokens** | TypeScript objects + Tailwind config | CSS custom properties only | Type-safe tokens, auto-complete in IDE |
| **Dark Mode** | Tailwind `dark:` variant with `class` strategy | Media query strategy | User-controllable, works with system preference |

---

## Web3 Stack

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Ethereum Library** | wagmi v2 + viem | ethers.js, web3.js | Type-safe, React hooks, smaller bundle, better tree-shaking |
| **Wallet UI** | RainbowKit | Custom modal, Web3Modal | Built for wagmi, customizable themes, mobile support |
| **Contract Framework** | Hardhat | Truffle, Foundry | Mature ecosystem, TypeScript support, plugin system |
| **Solidity** | 0.8.x (latest stable) | 0.7.x or older | Built-in overflow checks, custom errors, improved gas |
| **Chain** | BNB Smart Chain (BSC) | Ethereum mainnet (for cost) | Low gas fees, EVM compatible, large DeFi ecosystem |
| **Indexing** | The Graph / BSCScan API | Custom indexer | Decentralized, standard GraphQL queries |

### Why NOT ethers.js

- wagmi v2 + viem provides React hooks natively (no manual effect management)
- viem is 35x smaller than ethers.js
- Type-safe ABI encoding/decoding (no `any` types)
- Better error messages with typed contract errors
- Built-in multicall support

---

## Package Management

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Package Manager** | pnpm | npm, yarn | Strict dependency resolution, disk efficient, faster installs |
| **Lock File** | `pnpm-lock.yaml` | `package-lock.json`, `yarn.lock` | Matches pnpm, strict hoisting |

### pnpm Rules

- Always use `pnpm add` to install packages (not `npm install`)
- Use `pnpm add -D` for dev dependencies
- Run scripts with `pnpm run <script>` or `pnpm <script>`
- Never delete `pnpm-lock.yaml` unless intentionally resetting deps

---

## State Management

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Client State** | Zustand | Redux, Jotai, Recoil, MobX | Minimal boilerplate, no providers, TypeScript-first |
| **Server State** | TanStack Query (React Query) | SWR, manual fetch | Caching, deduplication, background refetching, devtools |
| **Form State** | React Hook Form + Zod | Formik, manual state | Performance (uncontrolled), schema validation with Zod |
| **URL State** | nuqs (Next.js search params) | Manual useSearchParams | Type-safe, serialization, SSR-compatible |

---

## Animation

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Scroll Animation** | GSAP + ScrollTrigger | Intersection Observer only | Professional scroll-linked animations, pin, scrub, timeline |
| **Component Animation** | Framer Motion | React Spring, anime.js | Layout animations, AnimatePresence for exit, gesture support |
| **SVG Animation** | GSAP | CSS animations | Path morphing, stagger, complex timelines |
| **Micro-interactions** | Framer Motion | CSS transitions | `whileHover`, `whileTap`, layout animation |
| **3D (when needed)** | React Three Fiber | Raw Three.js | React integration, declarative, hooks |

### Animation Performance Rules

- Animate only `transform` and `opacity` (GPU-accelerated)
- Use `will-change` sparingly and remove after animation completes
- GSAP: use `gsap.context()` for React cleanup
- Framer Motion: use `lazy` variants for off-screen content
- Test on low-end devices (throttle CPU in DevTools)

---

## Testing

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Unit/Integration** | Vitest | Jest | Vite-native, faster, ESM support, compatible API |
| **E2E** | Playwright | Cypress, Puppeteer | Multi-browser, auto-wait, network mocking, trace viewer |
| **Contract Testing** | Hardhat Test (Mocha + Chai) | Foundry forge test | Integrated with Hardhat, JavaScript-native |
| **Component Testing** | Vitest + Testing Library | Storybook test runner | Standard React testing patterns |
| **Coverage** | v8 (via Vitest) | Istanbul | Faster, built into V8 engine |

### Coverage Targets

| Scope | Target |
|-------|--------|
| `src/lib/**` | 100% |
| `src/hooks/**` | 90% |
| `src/components/**` | 80% |
| `src/contracts/**` (Solidity) | 100% branch coverage |
| Overall | 80% minimum |

---

## Linting & Formatting

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Linter** | ESLint 9 (flat config) | ESLint legacy config | New standard, faster, cleaner config |
| **Formatter** | Prettier | ESLint formatting rules | Consistent, no debates, integrates with ESLint |
| **Solidity Linter** | Solhint | Ethlint | Active maintenance, rule ecosystem |
| **Commit Lint** | Conventional Commits (enforced by hook) | Free-form messages | Changelog generation, semantic versioning |

---

## Deployment

| Decision | Choice | NOT | Rationale |
|----------|--------|-----|-----------|
| **Frontend Hosting** | Vercel | Netlify, AWS, self-hosted | Next.js-native, edge functions, preview deployments |
| **Contract Deployment** | Hardhat Ignition | Hardhat deploy scripts | Declarative, reproducible, state management |
| **CI/CD** | GitHub Actions | CircleCI, Jenkins | GitHub-native, free for open source |
| **Monitoring** | Sentry | Datadog, New Relic | Free tier sufficient, Next.js integration |
| **Analytics** | Mixpanel or GA4 | Amplitude, Heap | Event tracking, funnel analysis |

---

## File & Code Organization

| Decision | Choice | Rationale |
|----------|--------|-----------|
| **Imports** | Absolute paths (`@/components/...`) | No relative path hell (`../../..`) |
| **File naming** | kebab-case for files, PascalCase for components | Consistent, URL-safe |
| **Export style** | Named exports for utilities, default export for components | Tree-shakeable utilities, clean component imports |
| **Barrel files** | Avoid in `src/lib/` | Tree-shaking issues, circular dependencies |
| **Constants** | UPPER_SNAKE_CASE in dedicated files | Easy to find, type-safe |
| **Environment** | `.env.local` (never committed) | Security, per-environment config |

---

## Dependency Decision Tree

Before adding any new dependency:

```
1. Does the project already have a tool for this? → Use existing
2. Can it be done with platform APIs (Web APIs, Node APIs)? → No dependency needed
3. Is it in the approved stack above? → Use it
4. Otherwise → Write an ADR, get Technical Director approval
```

### ADR Required For:
- Any new runtime dependency over 50KB gzipped
- Any alternative to an approved stack choice
- Any dependency with fewer than 1000 GitHub stars
- Any dependency not updated in the last 6 months
- Any dependency that requires native binaries
