---
name: changelog
description: "Generate changelog from git history — group by feature/fix/breaking"
tools: Read, Glob, Grep, Bash, Write
---

# Changelog — Changelog Generation

## Purpose
Generate a structured changelog from git history, grouping commits by category (features, fixes, breaking changes) and formatting for public release notes.

## When to Use
- Before a release to document changes
- When preparing release notes for community
- Periodic changelog updates
- When publishing a new version

## Step-by-Step Workflow

### 1. Determine Version Range
Find the range of commits to include:
```bash
# Get last tag (previous version)
git describe --tags --abbrev=0

# Get all commits since last tag
git log $(git describe --tags --abbrev=0)..HEAD --oneline
```
If no tags exist, use all commits or a specified date range.

### 2. Parse Commit Messages
Extract and categorize commits using conventional commit format:
```
feat: → Features (new functionality)
fix: → Bug Fixes
refactor: → Code Refactoring
perf: → Performance Improvements
docs: → Documentation
test: → Tests
chore: → Maintenance
ci: → CI/CD Changes
BREAKING CHANGE: → Breaking Changes
```

### 3. Enrich with Context
For significant changes, gather additional context:
- Read changed files to understand impact
- Check if change affects contracts (breaking for users)
- Identify UI changes vs backend changes
- Flag Web3-specific changes (chain, contract, wallet)

### 4. Group by Category
Organize into changelog sections:

**Breaking Changes** (top priority, highlighted)
- Contract interface changes
- Chain migration
- API endpoint changes
- Wallet connection flow changes

**Features**
- New pages or sections
- New contract interactions
- New design style implementations
- New wallet/chain support

**Bug Fixes**
- Transaction error handling fixes
- UI rendering fixes
- Contract interaction fixes
- Mobile responsiveness fixes

**Performance**
- Bundle size reductions
- RPC call optimizations
- Animation performance improvements

**Other**
- Dependency updates
- Refactoring
- Documentation

### 5. Format Changelog
Generate `CHANGELOG.md` entry:
```markdown
## [v{version}] — {date}

### Breaking Changes
- **Contract**: Updated staking contract ABI — re-approve required
- **Config**: Changed RPC endpoint format in env vars

### Features
- Add NFT gallery with rarity filter (#PR)
- Implement PancakeSwap swap integration (#PR)
- Add Dark+Neon design style with GSAP animations

### Bug Fixes
- Fix wallet disconnect not clearing state (#issue)
- Fix token decimal display for 8-decimal tokens
- Fix mobile navigation overlay z-index

### Performance
- Reduce initial bundle by 40KB via dynamic imports
- Batch RPC calls with multicall for dashboard

### Dependencies
- Upgrade wagmi to v2.x
- Upgrade Next.js to 15.x
```

### 6. Generate Community-Friendly Version
Create a shorter, non-technical version for social media:
```markdown
What's new in v{version}:
- NFT gallery is live! Browse and filter by rarity
- Swap tokens directly on the site via PancakeSwap
- Fresh Dark+Neon design with smooth animations
- Faster loading and better mobile experience
```

### 7. Update Files
- Prepend to `CHANGELOG.md`
- Update version in `package.json` if applicable
- Create git tag: `git tag v{version}`

## Output Format
- Full changelog entry in `CHANGELOG.md`
- Community-friendly summary for social
- Git tag created

## Related Skills
`release-checklist`, `milestone-review`, `retrospective`
