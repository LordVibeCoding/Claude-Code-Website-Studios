# Launch Day Checklist

**Project:** [Project Name]
**Launch Date:** YYYY-MM-DD
**Launch Time:** HH:MM UTC
**Status:** Pre-Launch | Go / No-Go | Launched

---

## 1. Smart Contract Deployment

- [ ] Contract deployed to BSC Mainnet (Chain ID: 56)
- [ ] Contract address recorded: `0x...`
- [ ] Constructor arguments verified correct (supply, addresses, fees)
- [ ] BSCScan verification completed — source code verified and published
- [ ] Contract owner set to correct multi-sig wallet
- [ ] Timelock activated on admin functions
- [ ] LP tokens locked (proof link: [URL])
- [ ] LP lock duration: [X] months
- [ ] Vesting contracts deployed and funded
- [ ] Initial token distribution executed per tokenomics plan
- [ ] All contract tests passing on mainnet fork
- [ ] Contract audit report published (link: [URL])

---

## 2. Frontend Deployment

- [ ] Frontend deployed to production (Vercel)
- [ ] Production URL live and accessible: [URL]
- [ ] Build completed without errors or warnings
- [ ] All environment variables set in Vercel dashboard
- [ ] `NEXT_PUBLIC_CHAIN_ID` set to `56` (mainnet)
- [ ] `NEXT_PUBLIC_TOKEN_ADDRESS` set to mainnet contract
- [ ] `NEXT_PUBLIC_RPC_URL` set to production RPC endpoint
- [ ] No testnet references in production code
- [ ] No `.env` or secrets exposed in build output

---

## 3. DNS & SSL

- [ ] Custom domain configured: [domain.com]
- [ ] DNS A/CNAME records pointing to Vercel
- [ ] SSL/HTTPS certificate active and valid
- [ ] HTTPS redirect enabled (HTTP → HTTPS)
- [ ] www redirect configured (www → root or root → www)
- [ ] DNS propagation verified (check from multiple regions)

---

## 4. Wallet Connection

- [ ] Wallet connection tested on BSC Mainnet
- [ ] MetaMask connection works
- [ ] WalletConnect connection works
- [ ] Trust Wallet connection works (mobile)
- [ ] Chain switching from other networks works
- [ ] Disconnect and reconnect works
- [ ] Auto-connect on page refresh works
- [ ] Wallet connection works on mobile browsers

---

## 5. Core Functionality

- [ ] Token balance displays correctly
- [ ] Token price fetches from DEX pair
- [ ] Swap/buy widget functions correctly
- [ ] Transaction submission works
- [ ] Transaction confirmation displays correctly
- [ ] Transaction error handling shows user-friendly messages
- [ ] Staking flow works end-to-end (if applicable)
- [ ] NFT minting flow works end-to-end (if applicable)
- [ ] All contract read operations return correct data
- [ ] All contract write operations execute successfully

---

## 6. Mobile & Responsive

- [ ] Mobile responsive on iPhone (Safari)
- [ ] Mobile responsive on Android (Chrome)
- [ ] Tablet responsive on iPad
- [ ] Touch interactions work (swipe, tap, scroll)
- [ ] Mobile wallet deep links work
- [ ] No horizontal overflow on any screen size
- [ ] Font sizes readable on mobile (minimum 16px body text)
- [ ] Buttons have adequate touch targets (minimum 44x44px)

---

## 7. SEO & Meta Tags

- [ ] Page titles set for all pages
- [ ] Meta descriptions set for all pages
- [ ] Open Graph title, description, image set
- [ ] Twitter Card meta tags set
- [ ] OG image renders correctly when shared on Twitter/Telegram
- [ ] `sitemap.xml` generated and accessible
- [ ] `robots.txt` configured (allow indexing)
- [ ] Canonical URLs set
- [ ] Structured data (JSON-LD) validated
- [ ] Favicon and Apple touch icon set

---

## 8. Analytics & Monitoring

- [ ] Google Analytics 4 (or Mixpanel) tracking active
- [ ] Page view tracking verified
- [ ] Event tracking for key actions (wallet connect, swap, stake)
- [ ] Sentry error monitoring configured
- [ ] Sentry DSN set in production environment
- [ ] Test error sent and received in Sentry dashboard
- [ ] Uptime monitoring configured (e.g., UptimeRobot, Vercel)
- [ ] Performance monitoring baseline captured

---

## 9. Security

- [ ] No hardcoded private keys or mnemonics in codebase
- [ ] No API keys exposed in client-side JavaScript
- [ ] CSP (Content Security Policy) headers configured
- [ ] CORS configured — only allow known origins
- [ ] Rate limiting on API routes (if any)
- [ ] Input validation on all user inputs
- [ ] XSS protection verified
- [ ] No sensitive data in local storage (only addresses, not keys)
- [ ] Dependency audit clean (`pnpm audit`)
- [ ] All critical and high npm vulnerabilities resolved

---

## 10. Performance

- [ ] Lighthouse score > 90 (Performance)
- [ ] LCP (Largest Contentful Paint) < 2.5s
- [ ] FID (First Input Delay) < 100ms
- [ ] CLS (Cumulative Layout Shift) < 0.1
- [ ] Total bundle size < [X] KB (gzipped)
- [ ] Images optimized (WebP, appropriate sizes)
- [ ] Fonts subset and preloaded
- [ ] Third-party scripts lazy loaded
- [ ] No render-blocking resources

---

## 11. Social & Community Links

- [ ] Twitter/X link works: [URL]
- [ ] Telegram link works: [URL]
- [ ] Discord link works: [URL]
- [ ] GitHub link works (if open source): [URL]
- [ ] BSCScan token link: [URL]
- [ ] CoinGecko / CoinMarketCap listing submitted (if applicable)
- [ ] DexScreener / DexTools listing verified
- [ ] PancakeSwap trading link works
- [ ] Medium/blog link works (if applicable)

---

## 12. Legal & Compliance

- [ ] Terms of Service published: [URL]
- [ ] Privacy Policy published: [URL]
- [ ] Cookie consent banner (if required by jurisdiction)
- [ ] Disclaimer on token pages (not financial advice)
- [ ] Restricted jurisdictions handled (geo-blocking if required)

---

## 13. Backup & Recovery

- [ ] Database backup (if applicable)
- [ ] Deployment rollback procedure documented
- [ ] Previous production build tagged in git
- [ ] Contract admin keys stored securely (hardware wallet recommended)
- [ ] Multi-sig wallet signers confirmed and reachable
- [ ] Incident response plan documented

---

## Go / No-Go Decision

| Area | Status | Sign-off |
|------|--------|----------|
| Smart Contracts | PASS / FAIL | Smart Contract Lead |
| Frontend | PASS / FAIL | Frontend Lead |
| Security | PASS / FAIL | Security Lead |
| Performance | PASS / FAIL | Frontend Lead |
| Mobile | PASS / FAIL | QA Lead |
| Analytics | PASS / FAIL | DevOps Lead |

**Final Decision:** GO / NO-GO
**Decision Maker:** [Producer + Technical Director]
**Decision Time:** YYYY-MM-DD HH:MM UTC

---

## Post-Launch Monitoring (First 24 Hours)

| Time | Check | Owner |
|------|-------|-------|
| +0h | Verify all systems live | DevOps Lead |
| +1h | Check error rates in Sentry | QA Lead |
| +2h | Verify trading volume on DEX | Web3 Lead |
| +4h | Review user feedback (Telegram/Discord) | Content Lead |
| +8h | Performance review | Frontend Lead |
| +12h | Security scan | Security Lead |
| +24h | Full status report | Producer |

---

_Checklist completed by: [Name]_
_Reviewed by: [Producer]_
