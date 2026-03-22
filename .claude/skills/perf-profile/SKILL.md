---
name: perf-profile
description: "Performance profiling — bundle size, Core Web Vitals, render performance, network requests"
tools: Read, Glob, Grep, Bash
---

# Perf Profile — Performance Analysis

## Purpose
Profile the Web3 website's performance: bundle size, Core Web Vitals, rendering efficiency, RPC call optimization, and animation frame rates.

## When to Use
- Site feels slow or janky
- Before production launch
- After adding large dependencies (Three.js, GSAP, chart libs)
- Periodic performance health check

## Step-by-Step Workflow

### 1. Bundle Size Analysis
```bash
npx next build
npx @next/bundle-analyzer
```
- Check total JS bundle size (target: <200KB first load)
- Identify largest chunks
- Check for duplicate dependencies
- Verify tree-shaking for wagmi/viem (only import what's used)
- Flag unnecessary client-side packages

### 2. Core Web Vitals Check
Analyze for key metrics:
- **LCP** (Largest Contentful Paint): <2.5s — Check hero images, fonts
- **FID/INP** (Interaction to Next Paint): <200ms — Check event handlers
- **CLS** (Cumulative Layout Shift): <0.1 — Check dynamic content, images

### 3. Next.js Optimization
- [ ] Images use `next/image` with proper `sizes` and `priority`
- [ ] Fonts use `next/font` (no FOUT/FOIT)
- [ ] Dynamic imports for heavy components: `dynamic(() => import(...))`
- [ ] Server Components used where possible (no unnecessary `'use client'`)
- [ ] API routes use edge runtime where applicable
- [ ] Static pages pre-rendered at build time
- [ ] Metadata generated server-side

### 4. Web3 Performance
- [ ] RPC calls batched with multicall where possible
- [ ] Contract reads use `useReadContracts` (batch) not individual calls
- [ ] Polling intervals appropriate (not too frequent)
- [ ] `@tanstack/react-query` cache configured (staleTime, gcTime)
- [ ] WebSocket connections pooled, not per-component
- [ ] ABI imports are tree-shakeable (named exports)
- [ ] No unnecessary chain data re-fetches on navigation

### 5. Animation Performance
- [ ] GSAP animations use `will-change` / `transform` (GPU-accelerated)
- [ ] No layout-triggering properties animated (width, height, top, left)
- [ ] Framer Motion `layout` animations don't cause reflows
- [ ] Scroll-triggered animations use IntersectionObserver
- [ ] Heavy animations paused when off-screen
- [ ] 60fps maintained during animations (no jank)
- [ ] Lottie/video assets optimized for file size

### 6. Network Optimization
- [ ] API requests deduplicated
- [ ] Images served in WebP/AVIF format
- [ ] Lazy loading for below-fold images
- [ ] Prefetch for likely next navigation
- [ ] Third-party scripts loaded with `async`/`defer`
- [ ] No render-blocking resources

### 7. Memory Profiling
- [ ] No memory leaks from event listeners
- [ ] WebSocket connections cleaned up on unmount
- [ ] Intervals/timeouts cleared in cleanup
- [ ] Large data structures released when not needed
- [ ] GSAP ScrollTrigger instances killed on route change

### 8. Generate Performance Report
```markdown
## Performance Report — {date}

### Bundle Analysis
| Chunk | Size | Recommendation |

### Core Web Vitals
| Metric | Value | Target | Status |

### Web3 Performance
| Issue | Impact | Fix |

### Animation Performance
| Issue | FPS Impact | Fix |

### Action Items (prioritized)
1. Quick wins (< 1 hour)
2. Medium effort (1-4 hours)
3. Major refactors (> 4 hours)
```

## Output Format
- Bundle size breakdown
- Core Web Vitals assessment
- Web3-specific optimizations
- Animation performance notes
- Prioritized action items

## Related Skills
`code-review`, `release-checklist`, `design-review`
