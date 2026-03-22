---
name: new-nft
description: "Create NFT project — minting page, gallery, metadata display, collection management"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion
---

# New NFT — NFT Collection Project Generator

## Purpose
Build a complete NFT project site on BNB Chain with minting page, gallery, rarity display, and secondary marketplace integration.

## When to Use
- User is launching an NFT collection (PFP, art, utility, gaming)
- Needs a mint page, gallery, or collection showcase
- Building an NFT-gated experience

## Step-by-Step Workflow

### 1. Gather Collection Details
Ask via `AskUserQuestion`:
- Collection name and description
- Total supply and mint price (BNB)
- Mint phases (whitelist, public, free mint)
- Art style and reveal mechanism (instant/delayed)
- Utility/perks for holders
- Royalty percentage for secondary sales

### 2. Setup NFT Contract
Generate or integrate ERC-721/ERC-1155 contract:
```
contracts/
  NFTCollection.sol  — ERC721A with:
    - Merkle proof whitelist
    - Max per wallet limits
    - Configurable mint phases
    - Reveal mechanism
    - Royalty support (EIP-2981)
    - Withdraw function with splits
```
Generate typed hooks:
- `useMint` — Mint with quantity selector
- `useMintPhase` — Current phase, price, remaining
- `useTokenURI` — Metadata fetch
- `useOwnerTokens` — User's owned NFTs

### 3. Generate NFT Pages
```
src/app/
  page.tsx           — Collection hero + mint countdown
  mint/page.tsx      — Minting interface
  gallery/page.tsx   — Full collection browser
  [tokenId]/page.tsx — Individual NFT detail
  my-nfts/page.tsx   — Connected wallet's NFTs
  rarity/page.tsx    — Rarity rankings
```

### 4. Build NFT Components
- `MintCard.tsx` — Quantity selector, price display, mint button
- `MintProgress.tsx` — Minted/total progress bar
- `CountdownTimer.tsx` — Mint phase countdown
- `NFTGrid.tsx` — Gallery grid with lazy loading
- `NFTCard.tsx` — Image, name, rarity rank, traits
- `TraitFilter.tsx` — Filter by trait type/value
- `RarityBadge.tsx` — Rarity tier indicator
- `WhitelistChecker.tsx` — Check if wallet is whitelisted

### 5. Metadata & Media
- Setup IPFS integration (Pinata/NFT.Storage)
- Generate metadata JSON template
- Image optimization pipeline (Next.js Image with IPFS gateway)
- Placeholder/unrevealed state handling
- Trait rarity calculation from metadata

### 6. Minting UX
- Wallet connection check before mint
- Insufficient balance warning
- Gas estimation for mint transaction
- Multi-mint (batch) support
- Mint success celebration animation
- Auto-refresh gallery after mint
- Transaction receipt with BSCScan link

### 7. Post-Mint Features
- Secondary marketplace links (tofuNFT, Element)
- Floor price display
- Holder count and unique holders percentage
- Collection stats dashboard
- NFT-gated content section (if applicable)

## Output Format
- NFT contract with mint phases
- Mint page with full UX flow
- Gallery with filtering and rarity
- Metadata integration configured

## Related Skills
`deploy-contract`, `contract-review`, `connect-wallet`, `pick-style`
