---
name: design-system
description: "Build/update design system — design tokens, component library, style guide"
tools: Read, Glob, Grep, Write, Edit, Bash
---

# Design System — Token & Component Library

## Purpose
Create or update a cohesive design system for Web3 websites: design tokens, base UI components, Web3-specific components, and documentation.

## When to Use
- Setting up a new project's visual foundation
- Adding new components to an existing system
- Ensuring consistency across pages
- Refactoring inconsistent styling

## Step-by-Step Workflow

### 1. Audit Current State
- Scan `src/styles/` for existing design tokens
- Scan `src/components/ui/` for existing base components
- Check `tailwind.config.ts` for custom theme values
- Identify inconsistencies: duplicate colors, varying spacing, mixed patterns

### 2. Define Design Tokens
Create/update `src/styles/design-tokens.ts`:
```typescript
export const tokens = {
  colors: {
    brand: { 50-950 scale },
    accent: { 50-950 scale },
    semantic: { success, warning, error, info },
    surface: { background, card, elevated, overlay },
    text: { primary, secondary, muted, inverse },
    web3: { connected, disconnected, pending, error },
  },
  typography: {
    fonts: { heading, body, mono },
    sizes: { xs through 6xl with line-heights },
    weights: { normal, medium, semibold, bold },
  },
  spacing: { 0-96 scale },
  radii: { none, sm, md, lg, xl, full },
  shadows: { sm, md, lg, xl, glow, neon },
  transitions: { fast: 150ms, normal: 300ms, slow: 500ms },
  breakpoints: { sm: 640, md: 768, lg: 1024, xl: 1280, '2xl': 1536 },
}
```

### 3. Build Base UI Components
Create in `src/components/ui/` using CVA for variants:

| Component | Variants |
|-----------|----------|
| `Button` | primary, secondary, ghost, danger, outline; sm, md, lg |
| `Card` | default, elevated, glass, neon (per design style) |
| `Input` | default, error, disabled; with icon, with addon |
| `Badge` | status colors, sizes |
| `Modal` | sizes, with/without overlay |
| `Tooltip` | positions, delay |
| `Tabs` | underline, pill, boxed |
| `Alert` | success, warning, error, info |
| `Skeleton` | text, card, avatar, chart shapes |
| `Avatar` | sizes, with status indicator |

### 4. Build Web3 Components
Create in `src/components/web3/`:
- `ConnectButton` — Styled RainbowKit button override
- `AddressDisplay` — Truncated address with ENS, copy, explorer link
- `TokenAmount` — Formatted token value with symbol and icon
- `TransactionStatus` — Pending spinner, success check, error X
- `ChainBadge` — Chain icon + name
- `GasEstimate` — Gas cost in BNB and USD
- `BlockExplorerLink` — Auto-link to BSCScan with icon
- `WalletBalance` — BNB + token balances display

### 5. Build Layout Components
Create in `src/components/layout/`:
- `Container` — Max-width wrapper with responsive padding
- `Section` — Page section with consistent vertical spacing
- `Grid` — Responsive grid with predefined column configs
- `Stack` — Vertical/horizontal flex with gap
- `Divider` — Horizontal/vertical separator

### 6. Animation Primitives
Create `src/components/motion/`:
- `FadeIn` — Opacity + translateY entrance
- `SlideIn` — Directional slide entrance
- `StaggerChildren` — Sequential child animations
- `ScrollReveal` — GSAP ScrollTrigger wrapper
- `CountUp` — Animated number counter (for stats)
- `TypeWriter` — Character-by-character text reveal

### 7. Sync with Tailwind
Ensure `tailwind.config.ts` extends with all design tokens:
- Map CSS custom properties to token values
- Generate utility classes for Web3 states
- Configure dark mode if applicable

## Output Format
- Design tokens file
- Base UI component library
- Web3-specific components
- Layout and motion primitives
- Tailwind theme synced

## Related Skills
`pick-style`, `design-review`, `new-site`, `accessibility-check`
