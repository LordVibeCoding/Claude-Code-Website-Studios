# Quick Start Guide

## Prerequisites

| Tool | Version | Required | Install |
|------|---------|----------|---------|
| Git | 2.40+ | Yes | `brew install git` |
| Node.js | 20+ | Yes | `brew install node` or [nvm](https://github.com/nvm-sh/nvm) |
| pnpm | 9+ | Yes | `npm install -g pnpm` |
| Claude Code | Latest | Yes | `npm install -g @anthropic-ai/claude-code` |
| jq | 1.7+ | Recommended | `brew install jq` |
| Python 3 | 3.10+ | Recommended | `brew install python3` |

## Setup Steps

### 1. Clone the Project

```bash
git clone <repo-url> my-web3-project
cd my-web3-project
```

### 2. Launch Claude Code

```bash
claude
```

Claude Code will auto-load the studio configuration from `CLAUDE.md` and `.claude/` directory. Session hooks (`session-start.sh`, `detect-gaps.sh`) run automatically to load context and flag missing files.

### 3. Run /start

```
/start
```

This is the entry point for all new projects. The `start` skill will:

1. **Detect project stage** — scans for `package.json`, `next.config.*`, `hardhat.config.*`, existing source directories, and git history
2. **Classify stage** — `empty` | `scaffolded` | `in-progress` | `mature`
3. **Ask what you're building** — presents project type options
4. **Route to the correct bootstrap skill**

### 4. Project Type Selection

| Choice | Skill Invoked | What Gets Generated |
|--------|---------------|---------------------|
| **Official Website** | `/new-site` | Brand pages, design system, SEO config, component library |
| **DApp** | `/new-dapp` | Wallet connection, contract hooks, DApp-specific pages, transaction UX |
| **Token Page** | `/new-token` | BEP20 token info, live price, swap widget, tokenomics charts |
| **NFT Project** | `/new-nft` | Mint page, gallery, rarity display, metadata integration |
| **Continue existing** | `/project-stage-detect` | Analyzes current state and suggests next steps |

### 5. Stack & Style Setup

After project type selection, two more skills are invoked automatically:

- **`/setup-stack`** — installs Next.js 15, TypeScript, Tailwind CSS 4, wagmi v2, viem, RainbowKit, and other dependencies via pnpm
- **`/pick-style`** — presents 25 design styles with recommendations based on your project type

### 6. Project Brief

A `project-brief.md` is generated at `.claude/project-brief.md` containing:
- Project type and description
- Target chain (BSC mainnet / testnet)
- Selected design style
- Key pages and features
- Contract requirements

## Technology Stack Overview

### Frontend
- **Next.js 15** — App Router, React Server Components, file-based routing
- **TypeScript 5** — strict mode, full type safety
- **Tailwind CSS 4** — utility-first styling with design tokens
- **GSAP + Framer Motion** — animation (scroll, page transitions, micro-interactions)
- **Zustand** — lightweight state management
- **React Hook Form + Zod** — form handling with schema validation

### Web3
- **wagmi v2 + viem** — type-safe Ethereum interactions (NOT ethers.js)
- **RainbowKit** — wallet connection UI (MetaMask, WalletConnect, Trust Wallet)
- **Hardhat + Solidity 0.8.x** — smart contract development and testing
- **The Graph / BSCScan API** — on-chain data indexing

### Infrastructure
- **Vercel** — frontend deployment with edge functions
- **BSC Mainnet (56) / Testnet (97)** — smart contract deployment
- **GitHub Actions** — CI/CD pipelines
- **Sentry** — error monitoring
- **Vitest** — unit/integration testing
- **Playwright** — E2E testing with wallet simulation

## Directory Structure

```
CLAUDE.md                    # Studio configuration
.claude/
  agents/                    # 36 agent definitions
  skills/                    # 37 slash command workflows
  hooks/                     # Validation scripts
  rules/                     # Path-scoped coding standards
  docs/                      # This documentation

src/
  site/                      # Official website pages
  dapp/                      # DApp pages and features
  contracts/                 # Smart contracts (Solidity)
  components/                # Shared React components
  hooks/                     # Custom React hooks
  lib/                       # Utilities, Web3 config, constants
  styles/                    # Global styles, design tokens
  assets/                    # Images, fonts, icons

design/                      # Design docs, wireframes
docs/                        # Technical docs, ADRs
tests/                       # Test suites
production/                  # Sprint plans, milestones
```

## Next Steps After Setup

1. **Design System** — Run `/design-system` to generate tokens, colors, typography, spacing
2. **Wallet Connection** — Run `/connect-wallet` for BSC wallet integration
3. **Contract Development** — Run `/deploy-contract` to scaffold and deploy smart contracts
4. **Code Review** — Run `/code-review` after implementing features
5. **Security Audit** — Run `/security-audit` before any deployment
6. **Launch** — Run `/launch-checklist` for pre-launch verification
