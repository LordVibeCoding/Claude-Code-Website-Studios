# Split Screen

## CSS Variables

```css
:root {
  --sp-bg-left: #0d0d0d;
  --sp-bg-right: #f5f5f0;
  --sp-text-light: #ffffff;
  --sp-text-light-secondary: #999999;
  --sp-text-dark: #111111;
  --sp-text-dark-secondary: #666666;
  --sp-accent: #4f46e5;
  --sp-accent-hover: #6366f1;
  --sp-accent-contrast: #f59e0b;
  --sp-border-light: #2a2a2a;
  --sp-border-dark: #e0e0e0;
  --sp-font-display: 'Clash Display', 'Inter', sans-serif;
  --sp-font-body: 'Inter', system-ui, sans-serif;
  --sp-font-size-hero: clamp(2.5rem, 5vw, 4.5rem);
  --sp-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --sp-font-size-body: 1rem;
  --sp-font-size-sm: 0.875rem;
  --sp-radius: 12px;
  --sp-radius-sm: 8px;
  --sp-shadow-left: 0 10px 40px rgba(0, 0, 0, 0.5);
  --sp-shadow-right: 0 10px 40px rgba(0, 0, 0, 0.08);
  --sp-transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  --sp-divider-width: 4px;
  --sp-spacing-xs: 0.5rem;
  --sp-spacing-sm: 1rem;
  --sp-spacing-md: 2rem;
  --sp-spacing-lg: 3rem;
  --sp-spacing-xl: 5rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        sp: {
          "bg-left": "#0d0d0d", "bg-right": "#f5f5f0",
          "text-light": { DEFAULT: "#ffffff", secondary: "#999999" },
          "text-dark": { DEFAULT: "#111111", secondary: "#666666" },
          accent: { DEFAULT: "#4f46e5", hover: "#6366f1", contrast: "#f59e0b" },
          "border-light": "#2a2a2a", "border-dark": "#e0e0e0",
        },
      },
      fontFamily: {
        "sp-display": ["Clash Display", "Inter", "sans-serif"],
        "sp-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "sp-hero": "clamp(2.5rem, 5vw, 4.5rem)", "sp-heading": "clamp(1.5rem, 3vw, 2.5rem)" },
      gridTemplateColumns: { split: "1fr 1fr" },
      keyframes: {
        "sp-slide-left": { "0%": { transform: "translateX(-40px)", opacity: "0" }, "100%": { transform: "translateX(0)", opacity: "1" } },
        "sp-slide-right": { "0%": { transform: "translateX(40px)", opacity: "0" }, "100%": { transform: "translateX(0)", opacity: "1" } },
      },
      animation: {
        "sp-slide-left": "sp-slide-left 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
        "sp-slide-right": "sp-slide-right 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .sp-layout {
    display: grid;
    grid-template-columns: 1fr 1fr;
    min-height: 100vh;
  }
  .sp-left {
    background: var(--sp-bg-left);
    color: var(--sp-text-light);
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: var(--sp-spacing-xl);
    position: relative;
    overflow: hidden;
  }
  .sp-right {
    background: var(--sp-bg-right);
    color: var(--sp-text-dark);
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: var(--sp-spacing-xl);
    position: relative;
    overflow: hidden;
  }
  .sp-left--sticky { position: sticky; top: 0; height: 100vh; }
  .sp-divider {
    position: absolute;
    right: 0; top: 0; bottom: 0;
    width: var(--sp-divider-width);
    background: linear-gradient(180deg, var(--sp-accent), var(--sp-accent-contrast));
    z-index: 10;
  }
  .sp-heading-light {
    font-family: var(--sp-font-display);
    font-size: var(--sp-font-size-hero);
    font-weight: 700;
    color: var(--sp-text-light);
    line-height: 1.1;
  }
  .sp-heading-dark {
    font-family: var(--sp-font-display);
    font-size: var(--sp-font-size-heading);
    font-weight: 700;
    color: var(--sp-text-dark);
    line-height: 1.2;
  }
  .sp-btn-light {
    padding: 12px 28px;
    background: var(--sp-accent);
    border: none;
    border-radius: var(--sp-radius-sm);
    color: #fff;
    font-family: var(--sp-font-body);
    font-weight: 600; font-size: var(--sp-font-size-sm);
    cursor: pointer;
    transition: all var(--sp-transition);
  }
  .sp-btn-light:hover { background: var(--sp-accent-hover); transform: translateY(-1px); }
  .sp-btn-dark {
    padding: 12px 28px;
    background: var(--sp-text-dark);
    border: none;
    border-radius: var(--sp-radius-sm);
    color: var(--sp-bg-right);
    font-family: var(--sp-font-body);
    font-weight: 600; font-size: var(--sp-font-size-sm);
    cursor: pointer;
    transition: all var(--sp-transition);
  }
  .sp-btn-dark:hover { opacity: 0.85; transform: translateY(-1px); }
  .sp-wallet-btn {
    padding: 12px 28px;
    background: var(--sp-accent);
    border: none;
    border-radius: var(--sp-radius-sm);
    color: #fff; font-weight: 600;
    cursor: pointer;
    transition: all var(--sp-transition);
    box-shadow: 0 4px 15px rgba(79, 70, 229, 0.4);
  }
  .sp-wallet-btn:hover { background: var(--sp-accent-hover); transform: translateY(-2px); box-shadow: 0 6px 20px rgba(79, 70, 229, 0.5); }
  .sp-card-dark {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid var(--sp-border-light);
    border-radius: var(--sp-radius);
    padding: 24px;
    transition: border-color var(--sp-transition);
  }
  .sp-card-dark:hover { border-color: var(--sp-accent); }
}
```

## Component Patterns

```tsx
export function SplitHero() {
  return (
    <section className="grid grid-cols-2 min-h-screen">
      <div className="bg-sp-bg-left text-sp-text-light flex flex-col justify-center px-20 relative animate-sp-slide-left">
        <div className="absolute right-0 top-0 bottom-0 w-1 bg-gradient-to-b from-sp-accent to-sp-accent-contrast" />
        <span className="text-sp-accent font-sp-body text-sm font-medium uppercase tracking-widest">DeFi Protocol</span>
        <h1 className="font-sp-display text-sp-hero font-bold leading-[1.1] mt-4">
          Two Sides.<br />One Vision.
        </h1>
        <p className="text-sp-text-light-secondary mt-6 max-w-sm leading-relaxed font-sp-body">
          Where traditional finance meets decentralized innovation.
        </p>
        <button className="mt-8 self-start px-7 py-3 bg-sp-accent rounded-lg text-white font-sp-body font-semibold text-sm shadow-[0_4px_15px_rgba(79,70,229,0.4)] hover:bg-sp-accent-hover hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(79,70,229,0.5)] transition-all">
          Connect Wallet
        </button>
      </div>
      <div className="bg-sp-bg-right text-sp-text-dark flex flex-col justify-center px-20 animate-sp-slide-right">
        <h2 className="font-sp-display text-sp-heading font-bold text-sp-text-dark leading-tight">
          Built for Everyone
        </h2>
        <p className="text-sp-text-dark-secondary mt-4 max-w-sm leading-relaxed font-sp-body">
          Intuitive tools that bridge the gap between complexity and simplicity.
        </p>
        <div className="mt-8 grid grid-cols-2 gap-4">
          <div className="p-5 bg-white rounded-xl border border-sp-border-dark hover:shadow-[0_10px_40px_rgba(0,0,0,0.08)] transition-shadow">
            <p className="font-sp-display font-bold text-2xl text-sp-text-dark">$2.4B</p>
            <p className="text-sp-text-dark-secondary text-sm mt-1">Total Value Locked</p>
          </div>
          <div className="p-5 bg-white rounded-xl border border-sp-border-dark hover:shadow-[0_10px_40px_rgba(0,0,0,0.08)] transition-shadow">
            <p className="font-sp-display font-bold text-2xl text-sp-text-dark">150K+</p>
            <p className="text-sp-text-dark-secondary text-sm mt-1">Active Wallets</p>
          </div>
        </div>
      </div>
    </section>
  );
}

export function SplitCard({ side, title, description }: { side: "dark" | "light"; title: string; description: string }) {
  const isDark = side === "dark";
  return (
    <div className={`p-6 rounded-xl border transition-all ${isDark ? "bg-white/5 border-sp-border-light hover:border-sp-accent" : "bg-white border-sp-border-dark hover:shadow-[0_10px_40px_rgba(0,0,0,0.08)]"}`}>
      <h3 className={`font-sp-display text-xl font-bold ${isDark ? "text-sp-text-light" : "text-sp-text-dark"}`}>{title}</h3>
      <p className={`text-sm mt-2 leading-relaxed ${isDark ? "text-sp-text-light-secondary" : "text-sp-text-dark-secondary"}`}>{description}</p>
    </div>
  );
}

export function SplitButton({ children, variant = "accent" }: { children: React.ReactNode; variant?: "accent" | "dark" | "outline" }) {
  const styles = {
    accent: "bg-sp-accent text-white hover:bg-sp-accent-hover shadow-[0_4px_15px_rgba(79,70,229,0.4)]",
    dark: "bg-sp-text-dark text-sp-bg-right hover:opacity-85",
    outline: "bg-transparent border border-sp-border-dark text-sp-text-dark hover:border-sp-text-dark",
  }[variant];
  return (
    <button className={`inline-flex items-center gap-2 px-6 py-3 rounded-lg font-sp-body text-sm font-semibold hover:-translate-y-0.5 transition-all ${styles}`}>
      {children}
    </button>
  );
}
```
