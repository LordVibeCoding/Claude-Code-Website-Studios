---
path:
  - "src/styles/**"
---

# Styles Code Standards

## Design Tokens in CSS Variables

All design values must be defined as CSS custom properties. No raw values in component styles.

```css
/* CORRECT: Design tokens as CSS variables */
:root {
  /* Colors — semantic naming */
  --color-bg-primary: #0a0a0b;
  --color-bg-secondary: #141416;
  --color-bg-tertiary: #1e1e22;
  --color-bg-elevated: #28282d;

  --color-text-primary: #fafafa;
  --color-text-secondary: #a1a1aa;
  --color-text-tertiary: #71717a;
  --color-text-disabled: #52525b;

  --color-accent-primary: #6366f1;
  --color-accent-primary-hover: #818cf8;
  --color-accent-secondary: #8b5cf6;

  --color-success: #22c55e;
  --color-warning: #f59e0b;
  --color-error: #ef4444;

  --color-border: #27272a;
  --color-border-hover: #3f3f46;

  /* Web3-specific colors */
  --color-wallet-connected: #22c55e;
  --color-wallet-disconnected: #71717a;
  --color-tx-pending: #f59e0b;
  --color-tx-success: #22c55e;
  --color-tx-failed: #ef4444;
}

/* WRONG: Hardcoded values scattered in components */
.card { background: #141416; } /* What token is this? */
```

## Responsive Breakpoints

Use the standard Tailwind breakpoint scale. Define breakpoints in order from mobile-first.

```css
/* Breakpoints (Tailwind defaults):
   sm:  640px   — Landscape phones
   md:  768px   — Tablets
   lg:  1024px  — Small laptops
   xl:  1280px  — Desktops
   2xl: 1536px  — Large desktops
*/

/* CORRECT: Mobile-first responsive design */
.hero-grid {
  display: grid;
  grid-template-columns: 1fr;             /* Mobile: single column */
  gap: var(--spacing-4);
}

@media (min-width: 768px) {               /* md: two columns */
  .hero-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-6);
  }
}

@media (min-width: 1280px) {              /* xl: three columns */
  .hero-grid {
    grid-template-columns: repeat(3, 1fr);
    gap: var(--spacing-8);
  }
}

/* WRONG: Desktop-first (max-width) */
.hero-grid {
  grid-template-columns: repeat(3, 1fr);
}
@media (max-width: 768px) {
  .hero-grid {
    grid-template-columns: 1fr;
  }
}

/* WRONG: Arbitrary breakpoint */
@media (min-width: 850px) { /* Not a standard breakpoint! */ }
```

## Dark Mode Support

Use CSS custom properties for theming. Support both light and dark modes with `prefers-color-scheme` and a class-based toggle.

```css
/* Light mode defaults */
:root {
  --color-bg-primary: #ffffff;
  --color-bg-secondary: #f4f4f5;
  --color-text-primary: #18181b;
  --color-text-secondary: #52525b;
  --color-border: #e4e4e7;
}

/* Dark mode — system preference */
@media (prefers-color-scheme: dark) {
  :root {
    --color-bg-primary: #0a0a0b;
    --color-bg-secondary: #141416;
    --color-text-primary: #fafafa;
    --color-text-secondary: #a1a1aa;
    --color-border: #27272a;
  }
}

/* Dark mode — class-based override (for manual toggle) */
.dark {
  --color-bg-primary: #0a0a0b;
  --color-bg-secondary: #141416;
  --color-text-primary: #fafafa;
  --color-text-secondary: #a1a1aa;
  --color-border: #27272a;
}

/* CORRECT: Use variables — auto-adapts */
.card {
  background: var(--color-bg-secondary);
  color: var(--color-text-primary);
  border: 1px solid var(--color-border);
}

/* WRONG: Hardcoded dark mode per component */
.card { background: white; }
.dark .card { background: #141416; }  /* Doesn't scale */
```

## No Magic Numbers

Every numeric value should map to a design token or be documented with a comment.

```css
/* CORRECT: Named spacing scale */
:root {
  --spacing-0: 0;
  --spacing-1: 0.25rem;   /* 4px */
  --spacing-2: 0.5rem;    /* 8px */
  --spacing-3: 0.75rem;   /* 12px */
  --spacing-4: 1rem;       /* 16px */
  --spacing-5: 1.25rem;   /* 20px */
  --spacing-6: 1.5rem;    /* 24px */
  --spacing-8: 2rem;       /* 32px */
  --spacing-10: 2.5rem;   /* 40px */
  --spacing-12: 3rem;     /* 48px */
  --spacing-16: 4rem;     /* 64px */
  --spacing-20: 5rem;     /* 80px */
  --spacing-24: 6rem;     /* 96px */

  --radius-sm: 0.25rem;   /* 4px */
  --radius-md: 0.5rem;    /* 8px */
  --radius-lg: 0.75rem;   /* 12px */
  --radius-xl: 1rem;       /* 16px */
  --radius-2xl: 1.5rem;   /* 24px */
  --radius-full: 9999px;
}

/* CORRECT: Using tokens */
.card {
  padding: var(--spacing-6);
  border-radius: var(--radius-xl);
  margin-bottom: var(--spacing-4);
}

/* WRONG: Magic numbers */
.card {
  padding: 23px;           /* Why 23? */
  border-radius: 11px;     /* Why 11? */
  margin-bottom: 17px;     /* Why 17? */
}
```

## Consistent Spacing Scale

Follow the Tailwind spacing scale (base 4px). Never use arbitrary spacing values.

```css
/* The scale: 0, 1(4px), 2(8px), 3(12px), 4(16px), 5(20px), 6(24px),
   8(32px), 10(40px), 12(48px), 16(64px), 20(80px), 24(96px) */

/* CORRECT */
.section { padding: var(--spacing-16) var(--spacing-6); }
.stack > * + * { margin-top: var(--spacing-4); }

/* WRONG: Off-scale values */
.section { padding: 50px 22px; }  /* Not on the 4px scale */
```

## Font Scale

Define a typographic scale with consistent sizing and line heights.

```css
:root {
  /* Font families */
  --font-sans: "Inter", system-ui, -apple-system, sans-serif;
  --font-mono: "JetBrains Mono", "Fira Code", monospace;
  --font-display: "Space Grotesk", var(--font-sans);

  /* Font sizes — modular scale */
  --text-xs: 0.75rem;     /* 12px */
  --text-sm: 0.875rem;    /* 14px */
  --text-base: 1rem;       /* 16px */
  --text-lg: 1.125rem;    /* 18px */
  --text-xl: 1.25rem;     /* 20px */
  --text-2xl: 1.5rem;     /* 24px */
  --text-3xl: 1.875rem;   /* 30px */
  --text-4xl: 2.25rem;    /* 36px */
  --text-5xl: 3rem;        /* 48px */
  --text-6xl: 3.75rem;    /* 60px */

  /* Line heights */
  --leading-none: 1;
  --leading-tight: 1.25;
  --leading-snug: 1.375;
  --leading-normal: 1.5;
  --leading-relaxed: 1.625;

  /* Font weights */
  --font-normal: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;
}

/* CORRECT: Using font tokens */
h1 {
  font-family: var(--font-display);
  font-size: var(--text-5xl);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: -0.02em;
}

.body-text {
  font-family: var(--font-sans);
  font-size: var(--text-base);
  line-height: var(--leading-relaxed);
}

.code-block {
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  line-height: var(--leading-normal);
}

/* WRONG: Arbitrary font sizes */
h1 { font-size: 47px; }  /* Not on the scale */
p { font-size: 15px; }    /* Not on the scale */
```
