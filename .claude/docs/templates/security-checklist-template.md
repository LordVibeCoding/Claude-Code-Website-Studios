# Security Checklist

**Project:** [Project Name]
**Date:** YYYY-MM-DD
**Reviewer:** [Security Lead / Security Auditor]
**Status:** Not Started | In Progress | Complete

---

## 1. Smart Contract Security

### 1.1 Common Vulnerabilities

- [ ] **Reentrancy** — All external calls use `nonReentrant` modifier (OpenZeppelin ReentrancyGuard)
- [ ] **Integer overflow/underflow** — Using Solidity 0.8.x (built-in checks) or SafeMath for 0.7.x
- [ ] **Front-running** — Price-sensitive operations use commit-reveal or minimum output amounts
- [ ] **Flash loan attacks** — Price oracles use TWAP (time-weighted average), not spot price
- [ ] **Sandwich attacks** — Swap functions enforce slippage protection
- [ ] **Access control** — All admin functions restricted with `onlyOwner` or `AccessControl`
- [ ] **tx.origin** — Never used for authentication (only `msg.sender`)
- [ ] **Unchecked return values** — All external call return values checked
- [ ] **Denial of Service** — No unbounded loops, no operations that can be blocked by a single address
- [ ] **Timestamp dependence** — `block.timestamp` only used for rough time periods (not exact timing)
- [ ] **Delegatecall** — No delegatecall to untrusted contracts
- [ ] **Self-destruct** — No selfdestruct or delegatecall that could trigger selfdestruct

### 1.2 BEP20-Specific Checks

- [ ] **Approve race condition** — Using `increaseAllowance` / `decreaseAllowance` instead of direct `approve`
- [ ] **Transfer hooks** — Custom transfer logic (tax, reflection) tested for edge cases
- [ ] **Max transaction limits** — Anti-whale limits cannot be set to 0 (would freeze trading)
- [ ] **Fee caps** — Tax rates have a hardcoded maximum (e.g., cannot exceed 15%)
- [ ] **Blacklist function** — If present, cannot blacklist LP pair or contract itself
- [ ] **Mint function** — If exists, has proper access control and cap; if not needed, does not exist
- [ ] **Renounce ownership** — Plan documented (renounce after setup, or multi-sig + timelock)
- [ ] **LP lock** — Liquidity locked for documented duration, proof on-chain

### 1.3 Contract Architecture

- [ ] **Upgrade pattern** — If upgradeable, uses TransparentProxy or UUPS with timelock
- [ ] **Emergency pause** — Pausable mechanism with multi-sig control
- [ ] **Timelock** — Admin operations have time delay (minimum 24 hours recommended)
- [ ] **Multi-sig** — Treasury and admin wallets use multi-sig (3-of-5 minimum)
- [ ] **Withdrawal** — Owner can withdraw stuck tokens/BNB with proper access control

### 1.4 Audit Status

- [ ] Internal code review completed
- [ ] Static analysis (Slither) run with no critical findings
- [ ] Symbolic execution (Mythril) run
- [ ] External audit contracted / completed
- [ ] All critical and high audit findings resolved
- [ ] Audit report published

---

## 2. Frontend Security

### 2.1 Cross-Site Scripting (XSS)

- [ ] **React escaping** — No use of `dangerouslySetInnerHTML` (or sanitized with DOMPurify if required)
- [ ] **User input** — All user-provided data sanitized before rendering
- [ ] **URL validation** — External URLs validated before rendering as links
- [ ] **Contract data** — On-chain data (token names, symbols) sanitized before display
- [ ] **Markdown rendering** — If rendering user markdown, using a sanitizing renderer
- [ ] **SVG uploads** — If accepting SVGs, stripped of script tags and event handlers

### 2.2 Cross-Site Request Forgery (CSRF)

- [ ] **API routes** — All state-changing API routes verify origin
- [ ] **CSRF tokens** — Server-rendered forms include CSRF tokens (if applicable)
- [ ] **SameSite cookies** — All cookies set with `SameSite=Strict` or `SameSite=Lax`
- [ ] **Custom headers** — API requests include custom headers (e.g., `X-Requested-With`)

### 2.3 Content Security Policy (CSP)

- [ ] **CSP header** — Content-Security-Policy header configured in `next.config.ts`
- [ ] **Script sources** — `script-src 'self'` (no `unsafe-inline` or `unsafe-eval` if possible)
- [ ] **Style sources** — `style-src 'self' 'unsafe-inline'` (Tailwind requires inline styles)
- [ ] **Connect sources** — Restricted to known RPC endpoints, APIs, and WebSocket URLs
- [ ] **Frame ancestors** — `frame-ancestors 'none'` (prevent clickjacking)
- [ ] **Report URI** — CSP violations reported to monitoring endpoint

```typescript
// next.config.ts CSP example
const csp = [
  "default-src 'self'",
  "script-src 'self'",
  "style-src 'self' 'unsafe-inline'",
  `connect-src 'self' https://bsc-dataseed.bnbchain.org https://*.bnbchain.org wss://*.bnbchain.org`,
  "img-src 'self' data: https: ipfs:",
  "font-src 'self'",
  "frame-ancestors 'none'",
].join('; ')
```

### 2.4 Other Frontend Security

- [ ] **HTTPS only** — All resources loaded over HTTPS
- [ ] **Referrer policy** — `Referrer-Policy: strict-origin-when-cross-origin`
- [ ] **X-Content-Type-Options** — `nosniff` header set
- [ ] **X-Frame-Options** — `DENY` or `SAMEORIGIN`
- [ ] **Permissions-Policy** — Camera, microphone, geolocation disabled unless needed

---

## 3. API Security

### 3.1 API Routes (Next.js API / Server Actions)

- [ ] **Input validation** — All request parameters validated with Zod schema
- [ ] **Rate limiting** — Rate limiting implemented on all public API routes
- [ ] **Error messages** — No stack traces or internal details leaked in error responses
- [ ] **CORS** — Configured to allow only known origins
- [ ] **Authentication** — Protected routes require valid authentication
- [ ] **Authorization** — Users can only access their own data

### 3.2 External API Calls

- [ ] **API keys** — All API keys stored in server-side environment variables (no `NEXT_PUBLIC_` prefix)
- [ ] **Timeout** — All external API calls have timeout configured
- [ ] **Retry** — Retry logic with exponential backoff for transient failures
- [ ] **Response validation** — External API responses validated before use

---

## 4. Key Management

### 4.1 Private Keys

- [ ] **Deployer key** — Stored in environment variable, never in code
- [ ] **No hardcoded keys** — Verified by `validate-commit.sh` hook
- [ ] **Key rotation** — Process documented for rotating compromised keys
- [ ] **Hardware wallet** — Production admin keys on hardware wallet (Ledger/Trezor)
- [ ] **Testnet keys** — Separate keys for testnet and mainnet

### 4.2 Wallet Connect & Sessions

- [ ] **Session data** — Only public address stored in browser (localStorage)
- [ ] **No private keys** — Application NEVER requests or stores private keys
- [ ] **Message signing** — Sign messages only for authentication, show clear message content
- [ ] **Transaction preview** — Users can review full transaction details before signing
- [ ] **Phishing protection** — Domain verification in wallet connect flow

### 4.3 Environment Variables

- [ ] **`.env` files** — Listed in `.gitignore`, never committed
- [ ] **Required vars** — Validated at startup (fail fast if missing)
- [ ] **Vercel env** — Production secrets set in Vercel dashboard, not in code
- [ ] **No secrets in logs** — Console output and error tracking do not log secrets

---

## 5. Dependency Audit

### 5.1 npm Dependencies

- [ ] **Audit clean** — `pnpm audit` shows no critical or high vulnerabilities
- [ ] **Lock file** — `pnpm-lock.yaml` committed and up to date
- [ ] **No deprecated packages** — All dependencies actively maintained
- [ ] **Minimal dependencies** — No unnecessary packages
- [ ] **Known vulnerability check** — Run against Snyk or npm audit database

### 5.2 Contract Dependencies

- [ ] **OpenZeppelin** — Using latest stable version of OpenZeppelin Contracts
- [ ] **Pinned versions** — All Solidity imports use exact version (not `latest`)
- [ ] **Verified sources** — All imported contracts from trusted sources

### 5.3 Supply Chain

- [ ] **Lock file integrity** — Lock file SHA verified before install
- [ ] **No typosquatting** — Package names verified against official repositories
- [ ] **Postinstall scripts** — Reviewed for malicious code

---

## 6. Access Control Review

### 6.1 Smart Contract Access

| Function | Who Can Call | Access Control | Timelock |
|----------|-------------|---------------|----------|
| `setTaxRate()` | Owner (multi-sig) | `onlyOwner` | Yes ([X]h) |
| `pause()` | Owner (multi-sig) | `onlyOwner` | No (emergency) |
| `mint()` | [N/A or Owner] | `onlyOwner` | Yes |
| `transferOwnership()` | Owner | `onlyOwner` | Yes |
| `withdraw()` | Owner (multi-sig) | `onlyOwner` | Yes |

### 6.2 Infrastructure Access

| System | Who Has Access | MFA Required |
|--------|---------------|-------------|
| Vercel Dashboard | [Names/Roles] | Yes |
| GitHub Repository | [Names/Roles] | Yes |
| BSCScan API | [Names/Roles] | N/A |
| Sentry | [Names/Roles] | Yes |
| Domain Registrar | [Names/Roles] | Yes |
| Multi-sig Wallet | [Signer addresses] | N/A (hardware wallet) |

---

## 7. Incident Response

### 7.1 Severity Classification

| Level | Definition | Response Time |
|-------|-----------|--------------|
| **P0 Critical** | Active exploit, funds at risk | Immediate (< 1 hour) |
| **P1 High** | Vulnerability found, not yet exploited | < 4 hours |
| **P2 Medium** | Security issue with limited impact | < 24 hours |
| **P3 Low** | Best practice violation, no immediate risk | Next sprint |

### 7.2 Response Actions

**P0 Critical — Active Exploit:**
1. [ ] Pause contract (if pausable)
2. [ ] Notify multi-sig signers
3. [ ] Assess damage and attack vector
4. [ ] Communicate with community (Twitter, Telegram)
5. [ ] Engage security firm for incident response
6. [ ] Deploy fix after review
7. [ ] Post-mortem and audit

**P1 High — Vulnerability Found:**
1. [ ] Assess exploitability and impact
2. [ ] Prepare fix in private repository
3. [ ] Review fix with security auditor
4. [ ] Deploy fix with minimal downtime
5. [ ] Disclose after fix deployed

---

## Summary

| Category | Items | Passed | Failed | N/A |
|----------|-------|--------|--------|-----|
| Smart Contract | [X] | [X] | [X] | [X] |
| Frontend | [X] | [X] | [X] | [X] |
| API | [X] | [X] | [X] | [X] |
| Key Management | [X] | [X] | [X] | [X] |
| Dependencies | [X] | [X] | [X] | [X] |
| Access Control | [X] | [X] | [X] | [X] |
| **Total** | **[X]** | **[X]** | **[X]** | **[X]** |

**Overall Status:** PASS / CONDITIONAL PASS / FAIL

---

_Checklist completed by: [Security Lead]_
_Reviewed by: [Technical Director]_
_Date: YYYY-MM-DD_
