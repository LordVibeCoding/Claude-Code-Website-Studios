---
name: team-release
description: "Assemble release team — producer, devops-engineer, qa-lead, security-lead"
tools: Read, Glob, Grep, Bash, Write, Agent
---

# Team Release — Release Management Team

## Purpose
Orchestrate a multi-agent team for release management: production deployment, quality assurance, security verification, and launch coordination for Web3 websites.

## When to Use
- Preparing for a production deployment
- Launch day operations
- Mainnet contract deployment
- Post-launch monitoring setup

## Team Composition

### producer
**Role**: Release coordination, timeline management, stakeholder communication.
**Responsibilities**:
- Define release schedule and milestones
- Coordinate between all team roles
- Manage release communication plan
- Track and resolve blockers
- Create release notes for community
- Run `release-checklist` and `launch-checklist`
- Decision maker for go/no-go

### devops-engineer
**Role**: Deployment infrastructure and CI/CD.
**Responsibilities**:
- Configure production deployment pipeline
- Setup hosting (Vercel, Cloudflare Pages)
- Configure CDN and caching strategy
- Setup DNS and SSL
- Configure environment variables for production
- Implement rollback procedures
- Setup monitoring dashboards
- Configure alerting (uptime, errors, performance)

### qa-lead
**Role**: Final quality verification before release.
**Responsibilities**:
- Run full test suite and verify all pass
- Execute manual testing checklist:
  - All pages load without errors
  - Wallet connect works on supported wallets
  - All contract interactions work on target chain
  - Responsive on mobile/tablet/desktop
  - Cross-browser testing (Chrome, Firefox, Safari)
- Verify content (no lorem ipsum, correct links)
- Run `perf-profile` for performance validation
- Run `accessibility-check` for compliance
- Sign off on quality

### security-lead
**Role**: Final security verification.
**Responsibilities**:
- Run `security-audit` skill
- Verify no secrets in codebase or git history
- Check CSP and security headers
- Verify contract audit status
- Confirm mainnet contract parameters are correct
- Check for known vulnerabilities in dependencies
- Verify wallet interaction security
- Confirm rate limiting and DDoS protection
- Sign off on security

## Workflow

### 1. Release Planning (producer)
Define release scope:
```markdown
## Release v{version}

### Included Features
- Feature 1: Description
- Feature 2: Description

### Contract Changes
- New deployment: ContractName on BSC mainnet
- Parameter update: StakingPool APY change

### Timeline
- T-3 days: Code freeze
- T-2 days: QA + Security review
- T-1 day: Staging deployment + final testing
- T-0: Production deployment + monitoring
```

### 2. Code Freeze (producer)
- No new features merged after freeze
- Only bug fixes and critical patches
- Lock dependency versions

### 3. Parallel Verification
Launch agents simultaneously:
- **qa-lead**: Full test suite + manual testing
- **security-lead**: Security audit + dependency scan
- **devops-engineer**: Staging deployment + infra verification

### 4. Issue Resolution
For any blockers found:
- P0: Fix immediately, re-verify
- P1: Fix or defer with documented workaround
- P2: Document and fix post-launch
- P3: Add to next sprint backlog

### 5. Go/No-Go Decision (producer)
Based on team sign-offs:
- [ ] QA sign-off
- [ ] Security sign-off
- [ ] DevOps sign-off
- [ ] Contract deployment verified
- Decision: **GO** or **NO-GO** with reasons

### 6. Production Deployment (devops-engineer)
- Deploy to production
- Verify deployment successful
- Run smoke tests
- Enable monitoring

### 7. Post-Launch (producer)
- Monitor for first 24 hours
- Communicate launch to community
- Track error rates and user reports
- Have `hotfix` skill ready

## Output Format
- Release plan with timeline
- QA report with test results
- Security clearance document
- Deployment confirmation
- Go/No-Go decision record

## Related Skills
`release-checklist`, `launch-checklist`, `hotfix`, `changelog`, `security-audit`
