# Bento Grid

## CSS Variables

```css
:root {
  --bg-bg: #09090b;
  --bg-surface: #18181b;
  --bg-surface-hover: #27272a;
  --bg-border: #27272a;
  --bg-border-hover: #3f3f46;
  --bg-text-primary: #fafafa;
  --bg-text-secondary: #a1a1aa;
  --bg-text-tertiary: #71717a;
  --bg-accent: #818cf8;
  --bg-accent-secondary: #34d399;
  --bg-accent-tertiary: #f472b6;
  --bg-font-sans: 'Inter', system-ui, sans-serif;
  --bg-font-mono: 'JetBrains Mono', 'Fira Code', monospace;
  --bg-radius-sm: 12px;
  --bg-radius-md: 16px;
  --bg-radius-lg: 24px;
  --bg-gap: 12px;
  --bg-padding: 24px;
  --bg-shadow-card: 0 0 0 1px var(--bg-border), 0 8px 40px rgba(0, 0, 0, 0.4);
  --bg-shadow-hover: 0 0 0 1px var(--bg-border-hover), 0 16px 50px rgba(0, 0, 0, 0.5);
  --bg-transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  --bg-gradient-accent: linear-gradient(135deg, var(--bg-accent), var(--bg-accent-secondary));
  --bg-gradient-surface: linear-gradient(180deg, #1e1e22 0%, #18181b 100%);
  --bg-font-size-xs: 0.75rem;
  --bg-font-size-sm: 0.875rem;
  --bg-font-size-base: 1rem;
  --bg-font-size-lg: 1.25rem;
  --bg-font-size-xl: 1.5rem;
  --bg-font-size-2xl: 2rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        bento: {
          bg: "#09090b", surface: "#18181b", "surface-hover": "#27272a",
          border: "#27272a", "border-hover": "#3f3f46",
          text: { primary: "#fafafa", secondary: "#a1a1aa", tertiary: "#71717a" },
          accent: { DEFAULT: "#818cf8", green: "#34d399", pink: "#f472b6" },
        },
      },
      fontFamily: { sans: ["Inter", "system-ui", "sans-serif"], mono: ["JetBrains Mono", "Fira Code", "monospace"] },
      borderRadius: { bento: "16px", "bento-lg": "24px" },
      boxShadow: {
        bento: "0 0 0 1px #27272a, 0 8px 40px rgba(0,0,0,0.4)",
        "bento-hover": "0 0 0 1px #3f3f46, 0 16px 50px rgba(0,0,0,0.5)",
      },
      gridTemplateColumns: { bento: "repeat(4, 1fr)", "bento-sm": "repeat(2, 1fr)" },
      gridTemplateRows: { bento: "repeat(3, minmax(180px, auto))" },
      keyframes: {
        "bento-in": { "0%": { opacity: "0", transform: "scale(0.95) translateY(10px)" }, "100%": { opacity: "1", transform: "scale(1) translateY(0)" } },
        shimmer: { "0%": { backgroundPosition: "-200% 0" }, "100%": { backgroundPosition: "200% 0" } },
      },
      animation: { "bento-in": "bento-in 0.5s cubic-bezier(0.4,0,0.2,1) forwards", shimmer: "shimmer 2s linear infinite" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .bento-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    grid-template-rows: repeat(3, minmax(180px, auto));
    gap: var(--bg-gap);
    padding: var(--bg-gap);
    max-width: 1200px;
    margin: 0 auto;
  }
  .bento-card {
    background: var(--bg-gradient-surface);
    border-radius: var(--bg-radius-md);
    padding: var(--bg-padding);
    box-shadow: var(--bg-shadow-card);
    transition: box-shadow var(--bg-transition), transform var(--bg-transition);
    overflow: hidden;
    position: relative;
  }
  .bento-card:hover {
    box-shadow: var(--bg-shadow-hover);
    transform: translateY(-2px);
  }
  .bento-card--wide { grid-column: span 2; }
  .bento-card--tall { grid-row: span 2; }
  .bento-card--feature { grid-column: span 2; grid-row: span 2; }
  .bento-label {
    font-family: var(--bg-font-mono);
    font-size: var(--bg-font-size-xs);
    color: var(--bg-accent);
    text-transform: uppercase;
    letter-spacing: 0.1em;
  }
  .bento-title {
    font-family: var(--bg-font-sans);
    font-size: var(--bg-font-size-xl);
    font-weight: 600;
    color: var(--bg-text-primary);
    margin-top: 8px;
  }
  .bento-wallet-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 20px;
    background: var(--bg-gradient-accent);
    border: none;
    border-radius: var(--bg-radius-sm);
    color: #fff;
    font-family: var(--bg-font-sans);
    font-size: var(--bg-font-size-sm);
    font-weight: 500;
    cursor: pointer;
    transition: opacity var(--bg-transition), transform var(--bg-transition);
  }
  .bento-wallet-btn:hover { opacity: 0.9; transform: scale(1.02); }
}
```

## Component Patterns

```tsx
export function BentoHero() {
  return (
    <section className="min-h-screen bg-bento-bg flex flex-col items-center justify-center px-3 py-20">
      <h1 className="font-sans text-5xl font-bold text-bento-text-primary text-center tracking-tight">
        Build <span className="text-bento-accent">Faster</span>
      </h1>
      <p className="text-bento-text-secondary text-lg mt-4 max-w-md text-center">
        Next-gen DeFi tools, beautifully organized.
      </p>
      <button className="mt-8 inline-flex items-center gap-2 px-5 py-2.5 bg-gradient-to-r from-bento-accent to-bento-accent-green rounded-bento text-white text-sm font-medium hover:opacity-90 hover:scale-[1.02] transition-all">
        Connect Wallet
      </button>
      <div className="mt-16 grid grid-cols-4 grid-rows-[repeat(3,minmax(180px,auto))] gap-3 max-w-[1200px] w-full">
        <div className="col-span-2 row-span-2 bg-gradient-to-b from-[#1e1e22] to-bento-surface rounded-bento-lg p-6 shadow-bento hover:shadow-bento-hover hover:-translate-y-0.5 transition-all overflow-hidden">
          <span className="font-mono text-xs text-bento-accent uppercase tracking-widest">Featured</span>
          <h2 className="font-sans text-2xl font-semibold text-bento-text-primary mt-2">Analytics Dashboard</h2>
          <p className="text-bento-text-secondary text-sm mt-2">Real-time on-chain data visualized.</p>
        </div>
        <div className="col-span-1 bg-gradient-to-b from-[#1e1e22] to-bento-surface rounded-bento-lg p-6 shadow-bento hover:shadow-bento-hover hover:-translate-y-0.5 transition-all">
          <span className="font-mono text-xs text-bento-accent-green uppercase tracking-widest">Live</span>
          <h3 className="font-sans text-xl font-semibold text-bento-text-primary mt-2">Gas Tracker</h3>
        </div>
        <div className="col-span-1 row-span-2 bg-gradient-to-b from-[#1e1e22] to-bento-surface rounded-bento-lg p-6 shadow-bento hover:shadow-bento-hover hover:-translate-y-0.5 transition-all">
          <span className="font-mono text-xs text-bento-accent-pink uppercase tracking-widest">Portfolio</span>
          <h3 className="font-sans text-xl font-semibold text-bento-text-primary mt-2">Holdings</h3>
        </div>
        <div className="col-span-1 bg-gradient-to-b from-[#1e1e22] to-bento-surface rounded-bento-lg p-6 shadow-bento hover:shadow-bento-hover hover:-translate-y-0.5 transition-all">
          <span className="font-mono text-xs text-bento-accent uppercase tracking-widest">Swap</span>
          <h3 className="font-sans text-xl font-semibold text-bento-text-primary mt-2">DEX Aggregator</h3>
        </div>
      </div>
    </section>
  );
}

export function BentoCard({ label, title, description, className = "" }: { label: string; title: string; description: string; className?: string }) {
  return (
    <div className={`bg-gradient-to-b from-[#1e1e22] to-bento-surface rounded-bento-lg p-6 shadow-bento hover:shadow-bento-hover hover:-translate-y-0.5 transition-all overflow-hidden animate-bento-in ${className}`}>
      <span className="font-mono text-xs text-bento-accent uppercase tracking-widest">{label}</span>
      <h3 className="font-sans text-xl font-semibold text-bento-text-primary mt-2">{title}</h3>
      <p className="text-bento-text-secondary text-sm mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function BentoButton({ children }: { children: React.ReactNode }) {
  return (
    <button className="inline-flex items-center gap-2 px-5 py-2.5 rounded-bento bg-bento-surface border border-bento-border text-bento-text-primary text-sm font-medium hover:border-bento-border-hover hover:bg-bento-surface-hover transition-all">
      {children}
    </button>
  );
}
```
