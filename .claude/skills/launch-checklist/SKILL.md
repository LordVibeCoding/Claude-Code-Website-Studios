---
name: launch-checklist
description: "Launch day checklist — DNS, CDN, contract mainnet, monitoring, analytics, social links"
tools: Read, Glob, Grep, Bash, AskUserQuestion
---

# Launch Checklist — Launch Day Operations

## Purpose
Day-of-launch operational checklist for a Web3 website: DNS configuration, CDN setup, mainnet contract activation, monitoring, analytics, and community communication.

## When to Use
- Launch day or day before launch
- When migrating from staging to production
- When going live with mainnet contracts
- Domain transfer or hosting migration

## Step-by-Step Workflow

### 1. Pre-Launch Verification
Confirm `release-checklist` has passed:
- [ ] All release checks PASSED
- [ ] Production build verified
- [ ] Mainnet contracts deployed and verified

### 2. DNS & Domain
- [ ] Domain purchased and verified
- [ ] DNS records configured:
  - A record or CNAME pointing to hosting
  - AAAA record for IPv6 (if applicable)
  - TXT record for domain verification
- [ ] SSL/TLS certificate provisioned (auto via Vercel/Cloudflare)
- [ ] WWW redirect configured
- [ ] DNS propagation verified (`dig` or `nslookup`)
- [ ] Old domain redirects (if migration)

### 3. Hosting & CDN
- [ ] Production deployment live (Vercel, Cloudflare Pages, etc.)
- [ ] CDN cache headers configured
- [ ] Edge functions working (if used)
- [ ] Custom error pages (404, 500) deployed
- [ ] Rate limiting active
- [ ] DDoS protection enabled
- [ ] Geo-restrictions if needed (compliance)

### 4. Mainnet Contract Activation
- [ ] Contracts on BSC mainnet verified on BSCScan
- [ ] Frontend pointing to mainnet contract addresses
- [ ] `NEXT_PUBLIC_CHAIN_ID=56` set
- [ ] Mainnet RPC endpoints configured (not public defaults)
- [ ] Contract parameters finalized (fees, limits, etc.)
- [ ] Liquidity added (if DEX/token)
- [ ] LP tokens locked (if applicable)
- [ ] Multisig ownership transferred (if applicable)

### 5. Monitoring Setup
- [ ] Error tracking live (Sentry, LogRocket)
- [ ] Uptime monitoring configured (Uptime Robot, Pingdom)
- [ ] Contract event monitoring (if applicable)
- [ ] Alert channels configured (Discord webhook, email, PagerDuty)
- [ ] RPC endpoint monitoring
- [ ] Performance monitoring (Core Web Vitals)

### 6. Analytics
- [ ] Google Analytics / Plausible / Fathom installed
- [ ] Conversion tracking configured (connect wallet, mint, swap)
- [ ] UTM parameters handling for marketing campaigns
- [ ] Event tracking for key user actions
- [ ] Privacy policy updated for analytics

### 7. Social & Community
- [ ] Website URL updated on:
  - [ ] Twitter/X bio and pinned tweet
  - [ ] Telegram group description
  - [ ] Discord server
  - [ ] GitHub repository
  - [ ] CoinGecko / CoinMarketCap (if listed)
  - [ ] DappRadar listing
- [ ] Open Graph preview tested (share on Twitter, Discord)
- [ ] Social share buttons working on site

### 8. Legal & Compliance
- [ ] Terms of Service page live
- [ ] Privacy Policy page live
- [ ] Cookie consent banner (if required)
- [ ] Disclaimer for financial content
- [ ] Region-restricted access (if required)

### 9. Launch Communication
- [ ] Announcement tweet/post drafted
- [ ] Community announcement in Telegram/Discord
- [ ] Launch blog post or Medium article
- [ ] Partner cross-promotion scheduled

### 10. Post-Launch Monitoring (first 24h)
- [ ] Watch error rates in monitoring dashboard
- [ ] Monitor contract interactions on BSCScan
- [ ] Track wallet connections and transactions
- [ ] Watch social media for user reports
- [ ] Be ready for hotfix deployment (`hotfix` skill)

## Output Format
- Comprehensive launch checklist
- Status tracking per item
- Immediate action items
- Post-launch monitoring plan

## Related Skills
`release-checklist`, `hotfix`, `deploy-contract`, `security-audit`
