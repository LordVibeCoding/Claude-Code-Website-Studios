# Claude Code Website Studios

> Turn a single Claude Code session into a full Web3 website development studio.
> 36 agents. 37 workflows. One coordinated AI team.

## What This Is

A structured development environment for building Web3 websites, official sites, DApps, token pages, and NFT projects on the BNB Chain (BEP20) ecosystem. Rather than one general-purpose AI, this provides **36 specialized agents** organized in a studio hierarchy with defined roles, escalation paths, and quality checkpoints.

## Studio Hierarchy

### Tier 1 — Directors (Claude Opus)
| Agent | Domain | Responsibility |
|-------|--------|----------------|
| Creative Director | Vision | Brand consistency, visual direction, design decisions |
| Technical Director | Architecture | Tech stack, performance strategy, architectural decisions |
| Producer | Coordination | Sprint planning, cross-team coordination, scope management |

### Tier 2 — Department Leads (Claude Sonnet)
| Agent | Domain | Responsibility |
|-------|--------|----------------|
| Frontend Lead | UI Development | React/Next.js architecture, component strategy |
| Smart Contract Lead | Blockchain | Solidity contracts, BEP20 tokens, on-chain logic |
| UI/UX Lead | Design | Design system, user flows, accessibility |
| Web3 Lead | Integration | Wallet connection, chain interactions, indexing |
| DevOps Lead | Infrastructure | CI/CD, deployment, monitoring |
| QA Lead | Quality | Test strategy, coverage requirements, release gates |
| Security Lead | Security | Web security, contract audits, vulnerability assessment |
| Content Lead | Content | Copy, localization, SEO content strategy |

### Tier 3 — Specialists (Claude Sonnet/Haiku)
| Agent | Domain |
|-------|--------|
| React Developer | Next.js 15, App Router, RSC |
| Animation Developer | GSAP, Framer Motion, Lottie |
| Responsive Developer | Mobile-first, cross-browser |
| Performance Optimizer | Core Web Vitals, bundle optimization |
| Solidity Developer | Smart contract implementation |
| Contract Auditor | Security analysis, vulnerability detection |
| Token Engineer | BEP20 tokenomics, vesting, distribution |
| DeFi Developer | Staking, LP, yield mechanics |
| Visual Designer | UI design, branding, asset creation |
| Interaction Designer | Micro-interactions, transitions, UX flows |
| Design System Developer | Component library, design tokens |
| Wallet Integration Developer | MetaMask, WalletConnect, Trust Wallet |
| Blockchain Developer | On-chain reads/writes, event listening |
| Subgraph Developer | The Graph, data indexing, queries |
| NFT Developer | ERC-721/1155, metadata, marketplace |
| DevOps Engineer | Vercel, Docker, CI/CD pipelines |
| Analytics Engineer | Tracking, conversion, on-chain analytics |
| SEO Specialist | Technical SEO, schema markup, performance |
| QA Tester | Functional testing, regression |
| E2E Tester | Playwright, cross-browser, wallet testing |
| Accessibility Specialist | WCAG 2.1, screen readers, keyboard nav |
| Security Auditor | OWASP, XSS, CSRF, injection prevention |
| Copywriter | Web copy, whitepapers, documentation |
| Localization Specialist | i18n, RTL support, translation workflows |

## Collaboration Model

**User-driven collaboration, not autonomous execution.**

```
Question → Options → Decision → Draft → Approval
```

- Agents ASK before proposing solutions
- Present 2-4 options with pros/cons
- User ALWAYS makes final decisions
- Draft and show work before finalizing
- Nothing gets written without explicit approval

## Agent Coordination

1. **Vertical delegation** — Directors → Leads → Specialists
2. **Horizontal consultation** — Peers advise but don't override
3. **Conflict resolution** — Escalates to shared parent director
4. **Change propagation** — Producer coordinates cross-department changes
5. **Domain boundaries** — Agents respect file ownership

## Design Style System

25 built-in design styles available via `/pick-style`:

| # | Style | Best For |
|---|-------|----------|
| 1 | Scroll Storytelling | High-end product launches |
| 2 | Bento Grid | SaaS, DApp dashboards |
| 3 | Glassmorphism | Modern DApps, wallets |
| 4 | Neumorphism | Control panels, dashboards |
| 5 | Dark Mode + Neon | Web3, crypto, gaming |
| 6 | Brutalism | Meme tokens, punk projects |
| 7 | Minimalism | Premium brands |
| 8 | Big Typography | Token launches, announcements |
| 9 | Horizontal Scroll | Portfolio, NFT galleries |
| 10 | Card Stacking | Feature showcases |
| 11 | Split Screen | Before/after, comparisons |
| 12 | 3D Immersive | GameFi, metaverse |
| 13 | Parallax | Brand stories, roadmaps |
| 14 | Grain & Retro | Vintage crypto projects |
| 15 | Illustrated | Community-focused projects |
| 16 | Cursor Interaction | Creative DApps |
| 17 | Gradient Mesh | Token pages, modern crypto |
| 18 | Claymorphism | Casual GameFi |
| 19 | Aurora | AI + crypto projects |
| 20 | Layered Paper | Documentation sites |
| 21 | Mondrian Grid | Art NFT platforms |
| 22 | Kinetic Typography | Launch events |
| 23 | Organic Shapes | Health/green crypto |
| 24 | Masked Image | NFT showcases |
| 25 | Infinite Scroll Gallery | NFT collections |

## Technology Stack

### Frontend (Default)
- **Framework**: Next.js 15 (App Router, RSC)
- **Language**: TypeScript 5
- **Styling**: Tailwind CSS 4 + CSS Modules
- **Animation**: GSAP + Framer Motion
- **State**: Zustand
- **Forms**: React Hook Form + Zod

### Web3 Integration
- **Wallet**: wagmi v2 + viem + RainbowKit (EVM)
- **Chain**: BNB Smart Chain (BSC) — BEP20 ecosystem
- **Contracts**: Hardhat + Solidity 0.8.x
- **Indexing**: The Graph / BSCScan API
- **Testing**: Hardhat test + Chai

### Infrastructure
- **Deployment**: Vercel (frontend) + BSC Mainnet/Testnet (contracts)
- **CI/CD**: GitHub Actions
- **Monitoring**: Sentry + Web3 event monitoring
- **Analytics**: Mixpanel / Google Analytics 4

## Project Structure

```
CLAUDE.md                           # This file — master configuration
.claude/
  settings.json                     # Hooks, permissions, safety rules
  agents/                           # 36 agent definitions
  skills/                           # 37 slash command workflows
  hooks/                            # 8 validation scripts
  rules/                            # 11 path-scoped coding standards
  docs/
    quick-start.md                  # Getting started guide
    agent-roster.md                 # Complete agent reference
    agent-coordination-map.md       # Coordination diagram
    setup-requirements.md           # Prerequisites
    templates/                      # Document templates

src/
  site/                             # Official website pages
  dapp/                             # DApp pages and features
  contracts/                        # Smart contracts (Solidity)
  components/                       # Shared React components
  hooks/                            # Custom React hooks
  lib/                              # Utilities, Web3 config, constants
  styles/                           # Global styles, design tokens
  assets/                           # Images, fonts, icons

design/                             # Design docs, wireframes, mockups
docs/                               # Technical docs, ADRs, API docs
tests/                              # Test suites
production/                         # Sprint plans, milestones, releases
```

## Path-Scoped Rules

| Path | Standards Enforced |
|------|-------------------|
| `src/site/**` | SEO-ready, accessible, Core Web Vitals optimized |
| `src/dapp/**` | Wallet-aware, error boundaries, loading states |
| `src/contracts/**` | Gas optimized, reentrancy safe, auditable |
| `src/components/**` | Reusable, typed props, Storybook-ready |
| `src/hooks/**` | Custom hooks pattern, proper cleanup |
| `src/lib/**` | Pure functions, no side effects, full type coverage |
| `src/styles/**` | Design tokens, responsive breakpoints, dark mode |
| `design/**` | Required sections, user flow diagrams |
| `tests/**` | Naming conventions, coverage requirements |

## Slash Commands

### Project Bootstrap
- `/start` — Guided project setup based on stage
- `/new-site` — Create official website project
- `/new-dapp` — Create DApp project
- `/new-token` — Create BEP20 token page
- `/new-nft` — Create NFT project
- `/setup-stack` — Configure technology stack
- `/pick-style` — Choose from 25 design styles

### Development
- `/brainstorm` — Creative ideation session
- `/prototype` — Quick throwaway prototype
- `/design-system` — Build/update design system
- `/connect-wallet` — Implement wallet connection
- `/deploy-contract` — Deploy smart contract

### Review & Analysis
- `/code-review` — Full code review
- `/contract-review` — Smart contract security review
- `/design-review` — UI/UX design review
- `/security-audit` — Security assessment
- `/perf-profile` — Performance profiling
- `/seo-check` — SEO analysis
- `/accessibility-check` — WCAG compliance check
- `/scope-check` — Scope creep detection
- `/tech-debt` — Technical debt assessment

### Production
- `/sprint-plan` — Plan sprint tasks
- `/milestone-review` — Review milestone progress
- `/estimate` — Effort estimation
- `/retrospective` — Sprint retrospective
- `/project-stage-detect` — Detect project stage

### Release
- `/release-checklist` — Pre-release verification
- `/launch-checklist` — Launch day checklist
- `/changelog` — Generate changelog
- `/hotfix` — Emergency fix workflow

### Team Orchestration
- `/team-frontend` — Assemble frontend team
- `/team-contract` — Assemble contract team
- `/team-design` — Assemble design team
- `/team-web3` — Assemble Web3 integration team
- `/team-release` — Assemble release team
- `/team-polish` — Assemble polish/QA team
- `/map-systems` — Map system dependencies

## Automated Hooks

| Hook | Trigger | What It Does |
|------|---------|-------------|
| `validate-commit.sh` | Pre-commit | Check for hardcoded values, private keys, TODO format, JSON validity |
| `validate-push.sh` | Pre-push | Warn on protected branch push |
| `validate-assets.sh` | Post-write | Validate asset naming, image optimization |
| `session-start.sh` | Session start | Load sprint context, recent git activity |
| `session-stop.sh` | Session end | Log accomplishments, save progress |
| `detect-gaps.sh` | Session start | Flag missing docs, uncovered code |
| `pre-compact.sh` | Pre-compact | Preserve session progress notes |
| `log-agent.sh` | Agent spawn | Create audit trail for subagent invocations |

## Getting Started

### Prerequisites
- Git
- Node.js 20+ and pnpm
- Claude Code (`npm install -g @anthropic-ai/claude-code`)
- Recommended: jq (hook validation)

### Quick Start
```bash
git clone <this-repo> my-web3-project
cd my-web3-project
claude
# Then run /start
```

## Customization

This template is modular:
- Add/remove agents for your specific needs
- Edit agent prompts with project-specific knowledge
- Modify skills to match your workflow
- Create new rules for your directory structure
- Adjust hook validation strictness
- Add new design styles to the style system

## License

MIT
