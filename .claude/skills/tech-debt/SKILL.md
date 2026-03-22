---
name: tech-debt
description: "Technical debt assessment — code smells, outdated deps, missing tests, documentation gaps"
tools: Read, Glob, Grep, Bash
---

# Tech Debt — Technical Debt Assessment

## Purpose
Identify and catalog technical debt across the Web3 website project: code smells, outdated dependencies, missing tests, documentation gaps, and architectural shortcuts.

## When to Use
- Before planning a new sprint (understand current debt load)
- When bugs seem to cluster in specific areas
- After rapid prototyping or deadline-driven development
- Quarterly codebase health assessment

## Step-by-Step Workflow

### 1. Code Smell Detection
Scan for common issues:
- **Large files**: Any file > 400 lines (`wc -l`)
- **God components**: Components with > 10 props or > 200 lines
- **Duplicate code**: Similar patterns across files
- **Magic numbers**: Hardcoded values without constants
- **TODO/FIXME/HACK**: Grep for deferred work markers
- **Any types**: TypeScript `any` usage outside prototypes
- **Console logs**: Leftover debug statements
- **Commented code**: Dead code left as comments

### 2. Dependency Health
```bash
pnpm outdated
pnpm audit
```
Check:
- [ ] wagmi/viem on latest stable (breaking changes common)
- [ ] Next.js on latest patch at minimum
- [ ] OpenZeppelin contracts updated
- [ ] No deprecated packages in use
- [ ] Lock file committed and up to date
- [ ] Peer dependency warnings resolved

### 3. Test Coverage Gaps
- Check test existence: Are there tests for critical paths?
- Contract tests: Do all public functions have tests?
- Hook tests: Are custom Web3 hooks tested?
- Component tests: Are interactive components tested?
- E2E: Are critical flows (connect, swap, mint) covered?
```bash
npx hardhat coverage  # Contract coverage
npx jest --coverage   # Frontend coverage
```

### 4. Architectural Debt
- [ ] Components properly separated (ui/layout/web3/feature)
- [ ] No circular imports
- [ ] Consistent data flow pattern (hooks → components → pages)
- [ ] Contract integration layer clean (ABIs → hooks → components)
- [ ] Environment config centralized
- [ ] Error boundaries at appropriate levels
- [ ] State management not leaking across features

### 5. Web3-Specific Debt
- [ ] Contract ABIs match deployed contracts
- [ ] Address configs for all supported chains
- [ ] Hardcoded RPC URLs → environment config
- [ ] Missing error handling for transaction failures
- [ ] No retry logic for RPC calls
- [ ] Token decimal handling inconsistent
- [ ] Missing gas estimation before transactions

### 6. Documentation Gaps
- [ ] CLAUDE.md up to date with current architecture
- [ ] Contract interfaces documented
- [ ] Environment variables documented
- [ ] Deploy process documented
- [ ] Component props documented (JSDoc or Storybook)

### 7. Performance Debt
- [ ] Unoptimized images (no next/image)
- [ ] Missing dynamic imports for heavy libraries
- [ ] Client components that could be server components
- [ ] Unbatched RPC calls
- [ ] Missing query caching configuration

### 8. Generate Debt Report
```markdown
## Technical Debt Report — {date}

### Debt Score: X/10 (10 = no debt)

### Critical Debt (blocks development)
| Item | Location | Impact | Effort to Fix |

### High Debt (causes friction)
| Item | Location | Impact | Effort to Fix |

### Medium Debt (slows progress)
| Item | Location | Impact | Effort to Fix |

### Low Debt (cosmetic)
| Item | Location | Impact | Effort to Fix |

### Dependency Status
| Package | Current | Latest | Risk |

### Test Coverage
| Area | Coverage | Target | Gap |

### Recommended Debt Sprint
1. High-impact, low-effort fixes
2. Medium-effort improvements
3. Major refactors to schedule
```

## Output Format
- Categorized debt inventory with severity
- Dependency health report
- Test coverage gaps
- Prioritized remediation plan
- Estimated effort for debt reduction

## Related Skills
`code-review`, `scope-check`, `sprint-plan`, `perf-profile`
