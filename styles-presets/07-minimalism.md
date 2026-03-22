# Minimalism

## CSS Variables

```css
:root {
  --min-bg: #ffffff;
  --min-bg-alt: #fafafa;
  --min-bg-dark: #0a0a0a;
  --min-text-primary: #111111;
  --min-text-secondary: #666666;
  --min-text-tertiary: #999999;
  --min-text-inverse: #fafafa;
  --min-border: #e5e5e5;
  --min-border-hover: #cccccc;
  --min-accent: #111111;
  --min-accent-subtle: #f5f5f5;
  --min-font: 'Inter', 'Helvetica Neue', system-ui, sans-serif;
  --min-font-weight-light: 300;
  --min-font-weight-normal: 400;
  --min-font-weight-medium: 500;
  --min-font-size-xs: 0.75rem;
  --min-font-size-sm: 0.875rem;
  --min-font-size-base: 1rem;
  --min-font-size-lg: 1.125rem;
  --min-font-size-xl: 1.5rem;
  --min-font-size-2xl: 2.5rem;
  --min-font-size-hero: clamp(2.5rem, 5vw, 4.5rem);
  --min-line-height: 1.6;
  --min-letter-spacing: -0.02em;
  --min-radius: 6px;
  --min-radius-full: 9999px;
  --min-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  --min-shadow-hover: 0 2px 8px rgba(0, 0, 0, 0.08);
  --min-transition: 0.2s ease;
  --min-spacing-page: clamp(1.5rem, 5vw, 6rem);
  --min-max-width: 720px;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        min: {
          bg: { DEFAULT: "#ffffff", alt: "#fafafa", dark: "#0a0a0a" },
          text: { primary: "#111111", secondary: "#666666", tertiary: "#999999", inverse: "#fafafa" },
          border: { DEFAULT: "#e5e5e5", hover: "#cccccc" },
          accent: { DEFAULT: "#111111", subtle: "#f5f5f5" },
        },
      },
      fontFamily: { min: ["Inter", "Helvetica Neue", "system-ui", "sans-serif"] },
      fontSize: { "min-hero": "clamp(2.5rem, 5vw, 4.5rem)" },
      letterSpacing: { "min-tight": "-0.02em" },
      maxWidth: { min: "720px" },
      boxShadow: { min: "0 1px 2px rgba(0,0,0,0.05)", "min-hover": "0 2px 8px rgba(0,0,0,0.08)" },
      keyframes: {
        "min-fade": { "0%": { opacity: "0" }, "100%": { opacity: "1" } },
        "min-slide": { "0%": { opacity: "0", transform: "translateY(8px)" }, "100%": { opacity: "1", transform: "translateY(0)" } },
      },
      animation: { "min-fade": "min-fade 0.6s ease forwards", "min-slide": "min-slide 0.5s ease forwards" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .min-container {
    max-width: var(--min-max-width);
    margin: 0 auto;
    padding: 0 var(--min-spacing-page);
  }
  .min-heading {
    font-family: var(--min-font);
    font-size: var(--min-font-size-hero);
    font-weight: var(--min-font-weight-light);
    letter-spacing: var(--min-letter-spacing);
    color: var(--min-text-primary);
    line-height: 1.1;
  }
  .min-body {
    font-family: var(--min-font);
    font-size: var(--min-font-size-base);
    font-weight: var(--min-font-weight-normal);
    color: var(--min-text-secondary);
    line-height: var(--min-line-height);
  }
  .min-link {
    color: var(--min-text-primary);
    text-decoration: underline;
    text-underline-offset: 3px;
    text-decoration-color: var(--min-border);
    transition: text-decoration-color var(--min-transition);
  }
  .min-link:hover { text-decoration-color: var(--min-text-primary); }
  .min-btn {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 10px 20px;
    background: var(--min-accent);
    border: none;
    border-radius: var(--min-radius-full);
    color: var(--min-text-inverse);
    font-family: var(--min-font);
    font-size: var(--min-font-size-sm);
    font-weight: var(--min-font-weight-medium);
    cursor: pointer;
    transition: opacity var(--min-transition);
  }
  .min-btn:hover { opacity: 0.8; }
  .min-btn--outline {
    background: transparent;
    border: 1px solid var(--min-border);
    color: var(--min-text-primary);
  }
  .min-btn--outline:hover { border-color: var(--min-text-primary); opacity: 1; }
  .min-divider {
    height: 1px;
    background: var(--min-border);
    border: none;
    margin: 3rem 0;
  }
  .min-card {
    padding: 24px;
    border: 1px solid var(--min-border);
    border-radius: var(--min-radius);
    transition: border-color var(--min-transition), box-shadow var(--min-transition);
  }
  .min-card:hover { border-color: var(--min-border-hover); box-shadow: var(--min-shadow-hover); }
  .min-wallet-btn {
    padding: 10px 20px;
    background: var(--min-accent);
    border: none;
    border-radius: var(--min-radius-full);
    color: var(--min-text-inverse);
    font-family: var(--min-font);
    font-size: var(--min-font-size-sm);
    font-weight: var(--min-font-weight-medium);
    cursor: pointer;
    transition: opacity var(--min-transition);
  }
  .min-wallet-btn:hover { opacity: 0.8; }
}
```

## Component Patterns

```tsx
export function MinHero() {
  return (
    <section className="min-h-[90vh] flex items-center bg-min-bg">
      <div className="max-w-min mx-auto px-[clamp(1.5rem,5vw,6rem)] animate-min-slide">
        <p className="font-min text-sm text-min-text-tertiary tracking-min-tight">Decentralized Protocol</p>
        <h1 className="font-min text-min-hero font-light tracking-min-tight text-min-text-primary leading-[1.1] mt-4">
          Less is more.
        </h1>
        <p className="font-min text-base text-min-text-secondary leading-relaxed mt-6 max-w-md">
          A protocol that does one thing perfectly. No noise, no clutter, just clarity.
        </p>
        <div className="flex items-center gap-3 mt-10">
          <button className="px-5 py-2.5 bg-min-accent rounded-full text-min-text-inverse font-min text-sm font-medium hover:opacity-80 transition-opacity">
            Connect Wallet
          </button>
          <button className="px-5 py-2.5 bg-transparent border border-min-border rounded-full text-min-text-primary font-min text-sm font-medium hover:border-min-text-primary transition-colors">
            Documentation
          </button>
        </div>
      </div>
    </section>
  );
}

export function MinCard({ title, description }: { title: string; description: string }) {
  return (
    <div className="p-6 border border-min-border rounded-md hover:border-min-border-hover hover:shadow-min-hover transition-all animate-min-fade">
      <h3 className="font-min text-xl font-medium text-min-text-primary tracking-min-tight">{title}</h3>
      <p className="font-min text-sm text-min-text-secondary leading-relaxed mt-2">{description}</p>
    </div>
  );
}

export function MinButton({ children, variant = "default" }: { children: React.ReactNode; variant?: "default" | "outline" | "ghost" }) {
  const styles = {
    default: "bg-min-accent text-min-text-inverse hover:opacity-80",
    outline: "bg-transparent border border-min-border text-min-text-primary hover:border-min-text-primary",
    ghost: "bg-transparent text-min-text-secondary hover:text-min-text-primary",
  }[variant];
  return (
    <button className={`inline-flex items-center gap-2 px-5 py-2.5 rounded-full font-min text-sm font-medium transition-all ${styles}`}>
      {children}
    </button>
  );
}
```
