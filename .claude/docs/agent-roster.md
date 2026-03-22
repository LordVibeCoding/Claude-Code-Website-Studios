# Agent Roster — Complete Reference

36 specialized agents organized by tier and department.

## Tier 1 — Directors (Claude Opus)

Strategic decision-makers. They set direction, not implementation.

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 1 | **Creative Director** | Opus | Vision | Brand consistency, visual direction, design pillar enforcement, style palette management, review all design output |
| 2 | **Technical Director** | Opus | Architecture | Tech stack governance, ADR authoring, performance budgets, coding standards, dependency evaluation, cross-team conflict resolution |
| 3 | **Producer** | Opus | Coordination | Sprint planning, scope management, milestone tracking, cross-team dependency resolution, stakeholder communication, release coordination |

**When to invoke Directors:**
- Creative Director: brand identity decisions, design style selection, visual quality gates
- Technical Director: new dependency evaluation, architecture decisions, performance issues, technical debt prioritization
- Producer: sprint planning, scope creep, timeline conflicts, cross-team blockers, release readiness

---

## Tier 2 — Department Leads (Claude Sonnet)

Manage their domain and coordinate specialists.

### Creative Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 4 | **UI/UX Lead** | Sonnet | Design | Design system ownership, user flow definition, accessibility standards, component design specs |

### Frontend Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 5 | **Frontend Lead** | Sonnet | UI Development | React/Next.js architecture, component strategy, RSC boundaries, rendering patterns, performance optimization strategy |

### Smart Contract Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 6 | **Smart Contract Lead** | Sonnet | Blockchain | Solidity contract architecture, BEP20 token design, upgrade patterns, gas optimization strategy, audit coordination |

### Web3 Integration Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 7 | **Web3 Lead** | Sonnet | Integration | Wallet connection strategy, chain interaction patterns, indexing architecture, RPC management, transaction UX |

### Infrastructure Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 8 | **DevOps Lead** | Sonnet | Infrastructure | CI/CD pipeline design, deployment strategy, monitoring setup, environment management, rollback procedures |

### Quality Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 9 | **QA Lead** | Sonnet | Quality | Test strategy, coverage requirements, release gates, E2E test planning, regression test management |

### Security Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 10 | **Security Lead** | Sonnet | Security | Web security standards, contract audit coordination, vulnerability response, security gate enforcement, key management |

### Content Department

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 11 | **Content Lead** | Sonnet | Content | Copy strategy, SEO content planning, localization coordination, voice & tone alignment with brand |

**When to invoke Leads:**
- Start of any department-level initiative
- Cross-specialist coordination within the department
- Quality gate reviews before escalating to Directors
- When specialists need guidance or conflict resolution

---

## Tier 3 — Specialists (Claude Sonnet / Haiku)

Execute implementation work within their expertise.

### Creative Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 12 | **Visual Designer** | Sonnet | UI Design | UI design, branding, color palette creation, typography selection, asset direction |
| 13 | **Interaction Designer** | Sonnet | Motion | Micro-interactions, page transitions, scroll animations, hover states, UX flow choreography |
| 14 | **Design System Developer** | Sonnet | Components | Design token implementation, component library, Storybook, theme configuration |

### Frontend Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 15 | **React Developer** | Sonnet | Next.js | Next.js 15 App Router, RSC, data fetching, routing, layouts, server actions |
| 16 | **Animation Developer** | Sonnet | Animation | GSAP timelines, Framer Motion variants, Lottie integration, scroll-triggered animations |
| 17 | **Responsive Developer** | Haiku | Mobile | Mobile-first layouts, cross-browser testing, touch interactions, viewport handling |
| 18 | **Performance Optimizer** | Sonnet | Core Web Vitals | Bundle analysis, lazy loading, image optimization, code splitting, LCP/FID/CLS |

### Smart Contract Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 19 | **Solidity Developer** | Sonnet | Contracts | Contract implementation, OpenZeppelin patterns, BEP20/ERC721/ERC1155 logic |
| 20 | **Contract Auditor** | Sonnet | Security | Reentrancy detection, overflow checks, access control review, gas analysis |
| 21 | **Token Engineer** | Sonnet | Tokenomics | BEP20 tokenomics, vesting schedules, distribution mechanics, tax/fee models |
| 22 | **DeFi Developer** | Sonnet | DeFi | Staking contracts, LP mechanics, yield farming, reward distribution, flash loan protection |

### Web3 Integration Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 23 | **Wallet Integration Developer** | Sonnet | Wallets | MetaMask, WalletConnect, Trust Wallet integration, chain switching, session management |
| 24 | **Blockchain Developer** | Sonnet | On-chain | Contract reads/writes, event listening, multicall batching, transaction management |
| 25 | **Subgraph Developer** | Sonnet | Indexing | The Graph subgraph development, entity mapping, query optimization |
| 26 | **NFT Developer** | Sonnet | NFTs | ERC-721/1155, metadata standards, IPFS integration, marketplace integration |

### Infrastructure Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 27 | **DevOps Engineer** | Haiku | CI/CD | Vercel deployment, Docker containers, GitHub Actions, environment variables |
| 28 | **Analytics Engineer** | Haiku | Tracking | Event tracking, conversion funnels, on-chain analytics, dashboard setup |

### Content Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 29 | **SEO Specialist** | Haiku | SEO | Technical SEO, schema markup (JSON-LD), sitemap, robots.txt, meta tags, Core Web Vitals |
| 30 | **Copywriter** | Sonnet | Copy | Web copy, whitepapers, documentation, token descriptions, CTA optimization |
| 31 | **Localization Specialist** | Haiku | i18n | Internationalization setup, RTL support, translation workflow, locale routing |

### QA Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 32 | **QA Tester** | Haiku | Functional | Unit testing, integration testing, regression testing, test data management |
| 33 | **E2E Tester** | Sonnet | E2E | Playwright tests, cross-browser testing, wallet flow testing, visual regression |
| 34 | **Accessibility Specialist** | Haiku | WCAG | WCAG 2.1 compliance, screen reader testing, keyboard navigation, color contrast |

### Security Specialists

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 35 | **Security Auditor** | Sonnet | Web Security | OWASP Top 10, XSS prevention, CSRF protection, CSP headers, injection prevention |

### Additional

| # | Agent | Model | Domain | Key Responsibilities |
|---|-------|-------|--------|---------------------|
| 36 | **Localization Specialist** | Haiku | i18n | Multi-language support, RTL layouts, translation management, locale-specific content |

---

## Agent Count by Department

| Department | Lead | Specialists | Total |
|-----------|------|-------------|-------|
| Directors | 3 | — | 3 |
| Creative | 1 | 3 | 4 |
| Frontend | 1 | 4 | 5 |
| Smart Contract | 1 | 4 | 5 |
| Web3 Integration | 1 | 4 | 5 |
| Infrastructure | 1 | 2 | 3 |
| Content | 1 | 3 | 4 |
| QA | 1 | 3 | 4 |
| Security | 1 | 1 | 2 |
| **Total** | | | **36** |

## Model Distribution

| Model | Count | Use Case |
|-------|-------|----------|
| Claude Opus | 3 | Strategic decisions, cross-domain conflict resolution |
| Claude Sonnet | 25 | Implementation, department leadership, complex specialist work |
| Claude Haiku | 8 | Routine checks, lightweight specialist tasks, high-frequency operations |
