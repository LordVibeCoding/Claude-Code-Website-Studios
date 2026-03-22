# Skills Reference — All 38 Slash Commands

## Project Bootstrap

| # | Skill | Description | Category |
|---|-------|-------------|----------|
| 1 | `/start` | Guided project entry point. Detects project stage, asks what to build, routes to the correct bootstrap skill. | Bootstrap |
| 2 | `/new-site` | Generate official website — brand setup, design style selection, page structure, SEO, component library. | Bootstrap |
| 3 | `/new-dapp` | Scaffold DApp — wallet connection, contract integration, DApp-specific pages (DEX/staking/lending/marketplace/DAO). | Bootstrap |
| 4 | `/new-token` | Create BEP20 token page — live price ticker, tokenomics charts, swap widget, contract info display. | Bootstrap |
| 5 | `/new-nft` | Build NFT collection project — mint page, gallery, rarity display, metadata integration, IPFS setup. | Bootstrap |
| 6 | `/setup-stack` | Install and configure tech stack — Next.js 15, TypeScript, Tailwind CSS v3 (NOT v4), wagmi v2, Hardhat, testing tools. | Bootstrap |
| 7 | `/pick-style` | Interactive design style selector from 25 built-in styles with recommendations by project type. | Bootstrap |
| 8 | `/ui-ux-pro-max` | Design intelligence — 67 styles, 96 color palettes (161 product types), 57 font pairings. Auto-generates design system by product type. Eliminates default blue/purple. | Design |

### Typical Bootstrap Chain

```
/start → /new-site (or /new-dapp, /new-token, /new-nft) → /setup-stack → /pick-style → ui-ux-pro-max (auto)
```

---

## Development

| # | Skill | Description | Category |
|---|-------|-------------|----------|
| 8 | `/brainstorm` | Creative ideation session. Generate ideas for features, designs, marketing angles, tokenomics models. | Creative |
| 9 | `/prototype` | Quick throwaway prototype. Fast implementation to validate an idea — explicitly NOT production code. | Creative |
| 10 | `/design-system` | Build or update design system — tokens (colors, spacing, typography), component variants, theme config. | Design |
| 11 | `/connect-wallet` | Implement wallet connection — wagmi v2 config, RainbowKit setup, BSC chain config, auto-connect, chain switching. | Web3 |
| 12 | `/deploy-contract` | Deploy smart contract to BSC — compile, test, deploy, verify on BSCScan. Handles testnet and mainnet. | Web3 |

### When to Use Each

- `/brainstorm` — early stage, exploring possibilities, no commitment
- `/prototype` — want to see something working fast, will throw away later
- `/design-system` — starting a new project or updating brand identity
- `/connect-wallet` — any project that needs wallet interaction
- `/deploy-contract` — contract is tested and ready to go on-chain

---

## Review & Analysis

| # | Skill | Description | Category |
|---|-------|-------------|----------|
| 13 | `/code-review` | Full code review — architecture, patterns, error handling, TypeScript strictness, performance. | Quality |
| 14 | `/contract-review` | Smart contract security review — reentrancy, overflow, access control, gas optimization, common exploits. | Security |
| 15 | `/design-review` | UI/UX design review — brand consistency, accessibility, responsive behavior, interaction quality. | Design |
| 16 | `/security-audit` | Comprehensive security assessment — OWASP checks, dependency audit, key management, CSP, CORS. | Security |
| 17 | `/perf-profile` | Performance profiling — Core Web Vitals analysis, bundle size, rendering performance, contract gas costs. | Performance |
| 18 | `/seo-check` | SEO analysis — meta tags, structured data, sitemap, robots.txt, Open Graph, page speed impact. | Content |
| 19 | `/accessibility-check` | WCAG 2.1 compliance check — color contrast, keyboard navigation, screen reader, ARIA attributes. | Quality |
| 20 | `/scope-check` | Scope creep detection — compare current work against project brief, flag additions, suggest cuts. | Management |
| 21 | `/tech-debt` | Technical debt assessment — identify debt, categorize severity, estimate payoff effort, prioritize. | Quality |

### Review Workflow Chain

```
Code written → /code-review → /contract-review (if Solidity) → /security-audit → /perf-profile
```

---

## Production Management

| # | Skill | Description | Category |
|---|-------|-------------|----------|
| 22 | `/sprint-plan` | Plan sprint tasks — break features into stories, estimate effort, assign to agent teams, set milestones. | Management |
| 23 | `/milestone-review` | Review milestone progress — completed vs planned, velocity tracking, risk identification. | Management |
| 24 | `/estimate` | Effort estimation — break down feature into tasks, estimate hours/complexity, identify risks. | Management |
| 25 | `/retrospective` | Sprint retrospective — what went well, what didn't, actionable improvements for next sprint. | Management |
| 26 | `/project-stage-detect` | Detect current project stage — scans files, git history, dependencies to classify project maturity. | Management |

---

## Release

| # | Skill | Description | Category |
|---|-------|-------------|----------|
| 27 | `/release-checklist` | Pre-release verification — tests passing, security reviewed, performance met, docs updated. | Release |
| 28 | `/launch-checklist` | Launch day checklist — deployment verified, DNS, SSL, analytics, monitoring, social links, mobile. | Release |
| 29 | `/changelog` | Generate changelog from git history — group by type (feat/fix/refactor), include breaking changes. | Release |
| 30 | `/hotfix` | Emergency fix workflow — identify issue, create hotfix branch, implement fix, fast-track review and deploy. | Release |

### Release Workflow Chain

```
/release-checklist → /security-audit → /launch-checklist → /changelog
```

---

## Team Orchestration

| # | Skill | Description | Category |
|---|-------|-------------|----------|
| 31 | `/team-frontend` | Assemble frontend team — Frontend Lead + React Dev + Animation Dev + Responsive Dev + Performance Opt. | Team |
| 32 | `/team-contract` | Assemble contract team — Smart Contract Lead + Solidity Dev + Contract Auditor + Token Engineer. | Team |
| 33 | `/team-design` | Assemble design team — Creative Director + UI/UX Lead + Visual Designer + Interaction Designer + Design System Dev. | Team |
| 34 | `/team-web3` | Assemble Web3 team — Web3 Lead + Wallet Integration Dev + Blockchain Dev + Subgraph Dev + NFT Dev. | Team |
| 35 | `/team-release` | Assemble release team — Producer + DevOps Lead + QA Lead + Security Lead. | Team |
| 36 | `/team-polish` | Assemble polish/QA team — QA Lead + E2E Tester + Accessibility Spec + Perf Optimizer + SEO Spec. | Team |
| 37 | `/map-systems` | Map system dependencies — visualize how contracts, APIs, pages, and components connect. | Architecture |

---

## Skills by Category

| Category | Skills | Count |
|----------|--------|-------|
| Bootstrap | start, new-site, new-dapp, new-token, new-nft, setup-stack, pick-style | 7 |
| Creative | brainstorm, prototype | 2 |
| Design | design-system, design-review, ui-ux-pro-max | 3 |
| Web3 | connect-wallet, deploy-contract | 2 |
| Quality | code-review, accessibility-check, tech-debt | 3 |
| Security | contract-review, security-audit | 2 |
| Performance | perf-profile | 1 |
| Content | seo-check | 1 |
| Management | sprint-plan, milestone-review, estimate, retrospective, project-stage-detect, scope-check | 6 |
| Release | release-checklist, launch-checklist, changelog, hotfix | 4 |
| Team | team-frontend, team-contract, team-design, team-web3, team-release, team-polish | 6 |
| Architecture | map-systems | 1 |
| **Total** | | **38** |
