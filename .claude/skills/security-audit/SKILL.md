---
name: security-audit
description: "Full security assessment — OWASP Top 10, dependencies, CSP, XSS, private key exposure"
tools: Read, Glob, Grep, Bash
---

# Security Audit — Full Security Assessment

## Purpose
Comprehensive security audit of the entire Web3 website project covering frontend vulnerabilities, dependency risks, secret exposure, and Web3-specific attack vectors.

## When to Use
- Before any production deployment
- After adding new dependencies or integrations
- Periodic security health check
- After a security incident

## Step-by-Step Workflow

### 1. Secret Exposure Scan
CRITICAL — Do first:
- [ ] Grep for private keys: `0x[a-fA-F0-9]{64}`
- [ ] Grep for API keys: `BSCSCAN_API_KEY`, `WALLETCONNECT`
- [ ] Grep for mnemonics: 12/24 word phrases
- [ ] Check `.env` is in `.gitignore`
- [ ] Scan git history for accidentally committed secrets
- [ ] Verify `NEXT_PUBLIC_` prefix only on safe-to-expose values
- [ ] Check `hardhat.config.ts` doesn't inline private keys

### 2. Dependency Vulnerability Scan
```bash
pnpm audit
npx better-npm-audit audit
```
- Check for known CVEs in dependencies
- Review `@openzeppelin/contracts` version (latest stable)
- Check wagmi/viem versions for known issues
- Flag deprecated packages

### 3. OWASP Top 10 for Web3
- [ ] **Injection**: No SQL/NoSQL injection, sanitized inputs
- [ ] **Broken Auth**: Wallet signature verification correct
- [ ] **Sensitive Data**: No private data in client bundle
- [ ] **XXE/XSS**: No `dangerouslySetInnerHTML`, CSP configured
- [ ] **Broken Access**: Server-side checks not just client-side
- [ ] **Misconfiguration**: Headers, CORS, CSP properly set
- [ ] **CSRF**: Anti-CSRF tokens where needed
- [ ] **Components**: No vulnerable dependencies (step 2)
- [ ] **Logging**: No sensitive data in client logs
- [ ] **SSRF**: No user-controlled URLs in server fetches

### 4. Next.js Security
- [ ] `next.config.ts` has security headers
- [ ] CSP header blocks inline scripts (or uses nonce)
- [ ] X-Frame-Options prevents clickjacking
- [ ] API routes validate input
- [ ] Server actions validate origin
- [ ] No sensitive data in client components
- [ ] Image domains whitelist configured

### 5. Web3-Specific Security
- [ ] Contract addresses validated before interaction
- [ ] Transaction parameters verified client-side
- [ ] No signing of arbitrary messages without user context
- [ ] Phishing protection: domain verification in wallet connect
- [ ] Token approval amounts are specific, not unlimited MAX_UINT256
- [ ] Price feeds from trusted oracles, not manipulable pools
- [ ] No storing user's private key or seed phrase anywhere

### 6. Client-Side Security
- [ ] No sensitive logic in client bundle
- [ ] Environment variables properly scoped
- [ ] Third-party scripts audited (analytics, widgets)
- [ ] Subresource integrity (SRI) for CDN resources
- [ ] No eval() or Function() constructor usage

### 7. Infrastructure
- [ ] HTTPS enforced
- [ ] DNS properly configured (no dangling records)
- [ ] CDN cache headers appropriate
- [ ] Rate limiting on API routes
- [ ] Error pages don't leak stack traces

### 8. Generate Security Report
```markdown
## Security Audit Report — {date}

### CRITICAL — Immediate action required
### HIGH — Fix before deployment
### MEDIUM — Fix soon
### LOW — Improve when possible

### Dependency Report
| Package | Current | Vulnerabilities | Action |

### Secret Scan Results
| Type | Found | Location | Status |

### Recommendations
1. Immediate fixes
2. Short-term improvements
3. Long-term security posture
```

## Output Format
- Security report with categorized findings
- Dependency vulnerability list
- Secret scan results
- Prioritized remediation steps

## Related Skills
`contract-review`, `code-review`, `release-checklist`, `launch-checklist`
