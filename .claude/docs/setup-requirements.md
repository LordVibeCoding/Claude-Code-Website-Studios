# Setup Requirements

## Required Tools

### Git
- **Version:** 2.40+
- **Install:** `brew install git` (macOS) | `apt install git` (Linux)
- **Verify:** `git --version`
- **Purpose:** Version control, hook scripts, branch workflow

### Node.js
- **Version:** 20+ (LTS recommended)
- **Install:** `brew install node` or [nvm](https://github.com/nvm-sh/nvm)
- **Verify:** `node --version`
- **Purpose:** Runtime for Next.js, Hardhat, build tools
- **Note:** nvm recommended for managing multiple Node versions

### pnpm
- **Version:** 9+
- **Install:** `npm install -g pnpm`
- **Verify:** `pnpm --version`
- **Purpose:** Package manager (faster, stricter than npm/yarn)
- **Note:** This project uses pnpm exclusively. Do NOT use npm or yarn for dependency management.

### Claude Code
- **Version:** Latest
- **Install:** `npm install -g @anthropic-ai/claude-code`
- **Verify:** `claude --version`
- **Purpose:** AI-powered development environment that loads the studio configuration
- **Requirement:** Valid Anthropic API key with access to Claude Opus and Sonnet

## Recommended Tools

### jq
- **Version:** 1.7+
- **Install:** `brew install jq` (macOS) | `apt install jq` (Linux)
- **Purpose:** JSON validation in commit hooks, ABI parsing, config manipulation
- **Used by:** `validate-commit.sh` hook for JSON file validation

### Python 3
- **Version:** 3.10+
- **Install:** `brew install python3` (macOS) | `apt install python3` (Linux)
- **Purpose:** JSON validation fallback in hooks, utility scripts
- **Used by:** `validate-commit.sh` as fallback when jq is unavailable

### Hardhat
- **Install:** Bundled via pnpm (project dependency), but global install useful for standalone tasks
- **Purpose:** Smart contract compilation, testing, deployment
- **Note:** Installed as project dev dependency via `/setup-stack`

## Optional Tools

### Docker
- **Version:** 24+
- **Install:** [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- **Purpose:** Containerized development, local BSC node, reproducible builds
- **When needed:** Custom deployment pipelines, isolated testing environments

### Playwright
- **Install:** `pnpm add -D @playwright/test && npx playwright install`
- **Purpose:** End-to-end testing with browser automation
- **When needed:** E2E testing, visual regression, wallet flow testing
- **Note:** Requires browser binaries installed via `npx playwright install`

### Foundry (forge/cast/anvil)
- **Install:** `curl -L https://foundry.paradigm.xyz | bash && foundryup`
- **Purpose:** Alternative contract testing (fuzz testing, gas snapshots)
- **Note:** Studio defaults to Hardhat. Foundry requires an ADR to adopt.

## BSC Testnet Setup

### 1. Add BSC Testnet to MetaMask

| Field | Value |
|-------|-------|
| Network Name | BNB Smart Chain Testnet |
| RPC URL | `https://data-seed-prebsc-1-s1.bnbchain.org:8545` |
| Chain ID | 97 |
| Symbol | tBNB |
| Block Explorer | `https://testnet.bscscan.com` |

Alternative RPC endpoints (use as fallback):
- `https://data-seed-prebsc-2-s1.bnbchain.org:8545`
- `https://data-seed-prebsc-1-s2.bnbchain.org:8545`
- `https://data-seed-prebsc-2-s2.bnbchain.org:8545`

### 2. Get Testnet BNB

| Faucet | URL | Amount |
|--------|-----|--------|
| BNB Faucet (official) | https://www.bnbchain.org/en/testnet-faucet | 0.1 tBNB/day |
| QuickNode | https://faucet.quicknode.com/binance-smart-chain/bnb-testnet | 0.1 tBNB |

### 3. BSC Mainnet Configuration (for production)

| Field | Value |
|-------|-------|
| Network Name | BNB Smart Chain |
| RPC URL | `https://bsc-dataseed.bnbchain.org` |
| Chain ID | 56 |
| Symbol | BNB |
| Block Explorer | `https://bscscan.com` |

Premium RPC providers (recommended for production):
- [QuickNode](https://www.quicknode.com/)
- [Ankr](https://www.ankr.com/)
- [NodeReal](https://nodereal.io/)

## Environment Variable Template

Create a `.env.local` file in the project root (never commit this file):

```bash
# ─── BSC Network ───────────────────────────────────────────
NEXT_PUBLIC_CHAIN_ID=97                          # 97=testnet, 56=mainnet
NEXT_PUBLIC_RPC_URL=https://data-seed-prebsc-1-s1.bnbchain.org:8545

# ─── Contract Addresses ───────────────────────────────────
NEXT_PUBLIC_TOKEN_ADDRESS=0x...                  # BEP20 token contract
NEXT_PUBLIC_STAKING_ADDRESS=0x...                # Staking contract (if applicable)
NEXT_PUBLIC_NFT_ADDRESS=0x...                    # NFT contract (if applicable)

# ─── API Keys (server-side only — no NEXT_PUBLIC_ prefix) ─
BSCSCAN_API_KEY=                                 # BSCScan API for verification
DEPLOYER_PRIVATE_KEY=                            # Contract deployer (NEVER expose)

# ─── Third Party ───────────────────────────────────────────
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=            # WalletConnect Cloud project ID
NEXT_PUBLIC_ALCHEMY_ID=                          # Alchemy API (optional)
PINATA_API_KEY=                                  # IPFS pinning for NFT metadata
PINATA_SECRET_KEY=                               # IPFS pinning secret

# ─── Analytics & Monitoring ───────────────────────────────
NEXT_PUBLIC_GA_ID=                               # Google Analytics 4
SENTRY_DSN=                                      # Sentry error tracking
NEXT_PUBLIC_MIXPANEL_TOKEN=                      # Mixpanel (optional)

# ─── Deployment ───────────────────────────────────────────
VERCEL_TOKEN=                                    # Vercel deploy token
VERCEL_ORG_ID=                                   # Vercel organization
VERCEL_PROJECT_ID=                               # Vercel project
```

### Environment Variable Rules

1. **`NEXT_PUBLIC_` prefix** = exposed to the browser. Only use for non-sensitive values.
2. **No prefix** = server-side only. Use for API keys, private keys, secrets.
3. **NEVER commit** `.env`, `.env.local`, `.env.production` to git.
4. **validate-commit.sh** hook will BLOCK commits containing hardcoded private keys or mnemonics.
5. **Hardhat config** reads `DEPLOYER_PRIVATE_KEY` and `BSCSCAN_API_KEY` from env.

## Verification Checklist

Run these commands to verify your setup is complete:

```bash
# Required
git --version          # 2.40+
node --version         # 20+
pnpm --version         # 9+
claude --version       # Latest

# Recommended
jq --version           # 1.7+
python3 --version      # 3.10+

# Optional
docker --version       # 24+
npx playwright --version  # Latest
forge --version        # Latest (Foundry)
```
