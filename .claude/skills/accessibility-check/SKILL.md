---
name: accessibility-check
description: "WCAG 2.1 compliance check — ARIA, keyboard nav, color contrast, screen reader support"
tools: Read, Glob, Grep, Bash
---

# Accessibility Check — WCAG 2.1 Compliance

## Purpose
Audit the Web3 website for accessibility compliance: ARIA attributes, keyboard navigation, color contrast, screen reader support, and Web3-specific accessibility concerns.

## When to Use
- Before production launch
- After building new components or pages
- When adding interactive Web3 features
- Periodic accessibility review

## Step-by-Step Workflow

### 1. Automated Scan
```bash
npx axe-cli http://localhost:3000 --exit
```
Or check for `eslint-plugin-jsx-a11y` rules in ESLint config. Verify it's enabled and no rules are disabled.

### 2. Semantic HTML
- [ ] Proper heading hierarchy (single H1, sequential H2-H6)
- [ ] `<nav>`, `<main>`, `<aside>`, `<footer>` landmarks used
- [ ] `<button>` for actions, `<a>` for navigation (not div/span)
- [ ] Lists use `<ul>`/`<ol>`, tables use `<table>`
- [ ] Form inputs have associated `<label>` elements
- [ ] `<dialog>` for modals (or proper ARIA)

### 3. ARIA Attributes
- [ ] Dynamic content has `aria-live` regions
- [ ] Loading states announce with `aria-busy`
- [ ] Modals have `role="dialog"`, `aria-modal="true"`
- [ ] Expandable sections have `aria-expanded`
- [ ] Tabs use `role="tablist"`, `role="tab"`, `role="tabpanel"`
- [ ] Icons have `aria-label` or `aria-hidden="true"`
- [ ] No redundant ARIA (don't add role to semantic elements)

### 4. Keyboard Navigation
- [ ] All interactive elements focusable via Tab
- [ ] Focus order logical (follows visual flow)
- [ ] Focus visible (outline or custom focus ring)
- [ ] Modal traps focus within (no Tab escape)
- [ ] Escape closes modals/dropdowns
- [ ] Skip to main content link present
- [ ] No keyboard traps (can always navigate away)
- [ ] Custom components support Enter/Space activation

### 5. Color & Visual
- [ ] Text contrast ratio ≥ 4.5:1 (AA standard)
- [ ] Large text contrast ratio ≥ 3:1
- [ ] UI component contrast ≥ 3:1
- [ ] Information not conveyed by color alone
- [ ] Error states have icon + text (not just red color)
- [ ] Focus indicators visible in all themes
- [ ] `prefers-reduced-motion` media query respected
- [ ] `prefers-color-scheme` supported (if dark/light modes)

### 6. Web3-Specific Accessibility
- [ ] Wallet connect button keyboard accessible
- [ ] Transaction status announced to screen readers
- [ ] Token amounts readable (not just numbers, include symbol)
- [ ] Address truncation has full address in `aria-label`
- [ ] Chain switch prompts are accessible
- [ ] Error messages from failed transactions descriptive
- [ ] Countdown timers (mint) have ARIA live updates
- [ ] NFT gallery images have meaningful alt text
- [ ] Chart/graph data has text alternative

### 7. Content Accessibility
- [ ] All images have `alt` text (decorative: `alt=""`)
- [ ] Videos have captions/transcripts
- [ ] Links have descriptive text (not "click here")
- [ ] Language declared on `<html>`
- [ ] Reading level appropriate for audience
- [ ] Abbreviations expanded on first use

### 8. Generate Accessibility Report
```markdown
## Accessibility Audit Report — {date}

### WCAG 2.1 Level AA Compliance

### Critical (prevents access)
- [A1] Issue — WCAG criterion — File — Fix

### Major (difficult to use)
- [A2] Issue — WCAG criterion — File — Fix

### Minor (inconvenient)
- [A3] Issue — WCAG criterion — File — Fix

### Web3 Accessibility
| Component | Keyboard | Screen Reader | Contrast | Status |

### Compliance Score: X% AA criteria met
```

## Output Format
- WCAG 2.1 compliance checklist results
- Categorized issues with specific WCAG criteria
- Web3 component accessibility status
- Remediation steps with code examples

## Related Skills
`design-review`, `code-review`, `seo-check`, `release-checklist`
