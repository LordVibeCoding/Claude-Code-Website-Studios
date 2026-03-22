---
name: design-review
description: "UI/UX design review — consistency, accessibility, responsiveness, style adherence report"
tools: Read, Glob, Grep
---

# Design Review — UI/UX Analysis

## Purpose
Review the frontend implementation for design consistency, accessibility, responsive behavior, animation quality, and adherence to the chosen design style.

## When to Use
- After building a new page or component set
- Before launch to verify visual quality
- When design feels inconsistent across pages
- After changing design tokens or style

## Step-by-Step Workflow

### 1. Read Design Context
- Load `src/styles/design-tokens.ts` for color/font/spacing values
- Check `CLAUDE.md` for design style selection
- Read `tailwind.config.ts` for custom theme
- Identify which of the 25 design styles is active

### 2. Style Adherence Check
Verify components match the chosen design style:
- **Glassmorphism**: backdrop-blur present, border opacity, glass layers
- **Dark+Neon**: glow effects, neon colors on dark bg, proper contrast
- **Bento Grid**: asymmetric grid, varied card sizes, proper gaps
- **Minimalism**: whitespace ratios, limited color palette, clean lines
- **Scroll Storytelling**: section transitions, scroll triggers, narrative flow
- (Check specific style characteristics from the 25 available)

### 3. Consistency Audit
- [ ] Colors match design tokens (no hardcoded hex values)
- [ ] Typography scale consistent (headings, body, captions)
- [ ] Spacing follows token scale (no arbitrary px values)
- [ ] Border radius consistent across similar elements
- [ ] Shadow usage consistent (elevation hierarchy)
- [ ] Icon style uniform (same library, same size conventions)
- [ ] Button styles consistent across pages

### 4. Responsive Check
- [ ] Mobile layout works (320px minimum)
- [ ] Tablet breakpoint handled (768px)
- [ ] Desktop optimized (1280px+)
- [ ] Navigation collapses to mobile menu
- [ ] Images resize appropriately
- [ ] Text doesn't overflow containers
- [ ] Touch targets minimum 44x44px on mobile
- [ ] Web3 components (wallet, transactions) usable on mobile

### 5. Animation Quality
- [ ] Animations serve a purpose (guide attention, provide feedback)
- [ ] Duration appropriate (150-500ms for micro, 500-1500ms for page)
- [ ] Easing curves feel natural (not linear)
- [ ] `prefers-reduced-motion` respected
- [ ] No animation on first paint (CLS risk)
- [ ] GSAP ScrollTrigger sections have fallbacks
- [ ] Framer Motion variants consistent across components

### 6. Web3 UX Patterns
- [ ] Wallet connection state clearly visible
- [ ] Connected address displayed with truncation
- [ ] Transaction pending states obvious
- [ ] Error messages human-readable (not raw revert strings)
- [ ] Loading states for on-chain data
- [ ] Empty states for zero balances/no data
- [ ] Chain wrong state handled gracefully

### 7. Visual Hierarchy
- [ ] Clear primary CTA on each page
- [ ] Information hierarchy guides eye flow
- [ ] Contrast ratios meet WCAG AA (4.5:1 text, 3:1 large)
- [ ] Focus states visible for keyboard navigation
- [ ] Hover states provide clear feedback

### 8. Generate Design Report
```markdown
## Design Review Report — {date}

### Style: {selected-style}

### Consistency Issues
- [D1] Severity — Description — File — Fix

### Responsive Issues
- [R1] Breakpoint — Description — File — Fix

### Animation Issues
- [A1] Description — File — Fix

### Web3 UX Issues
- [W1] Description — File — Fix

### Positive Highlights
- Well-executed elements

### Score: X/10
```

## Output Format
- Categorized design issues with severity
- Specific file references
- Fix suggestions
- Overall design quality score

## Related Skills
`pick-style`, `design-system`, `accessibility-check`, `code-review`
