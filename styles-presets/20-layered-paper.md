# Layered Paper

## CSS Variables

```css
:root {
  --lp-bg: #e8e0d4;
  --lp-bg-paper: #f8f4ee;
  --lp-bg-paper-alt: #f0ece4;
  --lp-text-primary: #2c261e;
  --lp-text-secondary: #6b614f;
  --lp-text-tertiary: #9a9080;
  --lp-accent: #c85a3e;
  --lp-accent-hover: #d96b50;
  --lp-accent-blue: #3a6ea5;
  --lp-border: #d6ccbc;
  --lp-border-light: #e8e0d4;
  --lp-font-display: 'DM Serif Display', Georgia, serif;
  --lp-font-body: 'Source Sans 3', 'Source Sans Pro', sans-serif;
  --lp-font-size-hero: clamp(2.5rem, 5vw, 4.5rem);
  --lp-font-size-heading: clamp(1.25rem, 2.5vw, 2rem);
  --lp-font-size-body: 1.0625rem;
  --lp-radius: 6px;
  --lp-radius-sm: 3px;
  --lp-shadow-paper-1: 0 1px 3px rgba(0, 0, 0, 0.08), 0 4px 12px rgba(0, 0, 0, 0.05);
  --lp-shadow-paper-2: 0 2px 6px rgba(0, 0, 0, 0.1), 0 8px 24px rgba(0, 0, 0, 0.07);
  --lp-shadow-paper-3: 0 4px 10px rgba(0, 0, 0, 0.12), 0 16px 40px rgba(0, 0, 0, 0.1);
  --lp-shadow-stack: 0 1px 3px rgba(0,0,0,0.08), 3px 3px 0 #f0ece4, 3px 3px 3px rgba(0,0,0,0.06), 6px 6px 0 #e8e0d4, 6px 6px 6px rgba(0,0,0,0.04);
  --lp-transition: 0.3s ease;
  --lp-texture-url: none;
  --lp-spacing-xs: 0.5rem;
  --lp-spacing-sm: 1rem;
  --lp-spacing-md: 1.5rem;
  --lp-spacing-lg: 2.5rem;
  --lp-spacing-xl: 4rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        lp: {
          bg: { DEFAULT: "#e8e0d4", paper: "#f8f4ee", "paper-alt": "#f0ece4" },
          text: { primary: "#2c261e", secondary: "#6b614f", tertiary: "#9a9080" },
          accent: { DEFAULT: "#c85a3e", hover: "#d96b50", blue: "#3a6ea5" },
          border: { DEFAULT: "#d6ccbc", light: "#e8e0d4" },
        },
      },
      fontFamily: {
        "lp-display": ["DM Serif Display", "Georgia", "serif"],
        "lp-body": ["Source Sans 3", "Source Sans Pro", "sans-serif"],
      },
      fontSize: { "lp-hero": "clamp(2.5rem, 5vw, 4.5rem)", "lp-heading": "clamp(1.25rem, 2.5vw, 2rem)" },
      boxShadow: {
        "lp-1": "0 1px 3px rgba(0,0,0,0.08), 0 4px 12px rgba(0,0,0,0.05)",
        "lp-2": "0 2px 6px rgba(0,0,0,0.1), 0 8px 24px rgba(0,0,0,0.07)",
        "lp-3": "0 4px 10px rgba(0,0,0,0.12), 0 16px 40px rgba(0,0,0,0.1)",
        "lp-stack": "0 1px 3px rgba(0,0,0,0.08), 3px 3px 0 #f0ece4, 3px 3px 3px rgba(0,0,0,0.06), 6px 6px 0 #e8e0d4, 6px 6px 6px rgba(0,0,0,0.04)",
      },
      keyframes: {
        "lp-lift": { "0%": { transform: "translateY(0)", boxShadow: "0 1px 3px rgba(0,0,0,0.08)" }, "100%": { transform: "translateY(-6px)", boxShadow: "0 4px 10px rgba(0,0,0,0.12), 0 16px 40px rgba(0,0,0,0.1)" } },
        "lp-fade": { "0%": { opacity: "0", transform: "translateY(15px)" }, "100%": { opacity: "1", transform: "translateY(0)" } },
      },
      animation: { "lp-lift": "lp-lift 0.3s ease forwards", "lp-fade": "lp-fade 0.6s ease forwards" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .lp-page { background: var(--lp-bg); min-height: 100vh; }
  .lp-paper {
    background: var(--lp-bg-paper);
    border-radius: var(--lp-radius);
    box-shadow: var(--lp-shadow-paper-1);
    padding: 32px;
    position: relative;
    transition: box-shadow var(--lp-transition), transform var(--lp-transition);
  }
  .lp-paper:hover {
    box-shadow: var(--lp-shadow-paper-2);
    transform: translateY(-3px);
  }
  .lp-paper-stack {
    background: var(--lp-bg-paper);
    border-radius: var(--lp-radius);
    padding: 32px;
    position: relative;
    box-shadow: var(--lp-shadow-stack);
  }
  .lp-paper-torn {
    position: relative;
  }
  .lp-paper-torn::after {
    content: "";
    position: absolute;
    bottom: -4px; left: 0; right: 0;
    height: 8px;
    background: linear-gradient(135deg, var(--lp-bg) 25%, transparent 25%) -10px 0,
                linear-gradient(225deg, var(--lp-bg) 25%, transparent 25%) -10px 0;
    background-size: 20px 8px;
  }
  .lp-heading {
    font-family: var(--lp-font-display);
    font-size: var(--lp-font-size-hero);
    color: var(--lp-text-primary);
    line-height: 1.15;
  }
  .lp-body {
    font-family: var(--lp-font-body);
    font-size: var(--lp-font-size-body);
    color: var(--lp-text-secondary);
    line-height: 1.7;
  }
  .lp-btn {
    padding: 12px 28px;
    background: var(--lp-accent);
    border: none;
    border-radius: var(--lp-radius);
    color: #fff;
    font-family: var(--lp-font-body);
    font-weight: 600;
    box-shadow: var(--lp-shadow-paper-1);
    cursor: pointer;
    transition: all var(--lp-transition);
  }
  .lp-btn:hover {
    background: var(--lp-accent-hover);
    box-shadow: var(--lp-shadow-paper-2);
    transform: translateY(-2px);
  }
  .lp-divider {
    height: 1px;
    background: var(--lp-border);
    margin: var(--lp-spacing-lg) 0;
  }
  .lp-note {
    background: #fdf6e3;
    border-left: 4px solid var(--lp-accent);
    padding: 16px 20px;
    border-radius: 0 var(--lp-radius) var(--lp-radius) 0;
    font-family: var(--lp-font-body);
    color: var(--lp-text-secondary);
  }
  .lp-wallet-btn {
    padding: 12px 28px;
    background: var(--lp-accent);
    border: none;
    border-radius: var(--lp-radius);
    color: #fff; font-weight: 600;
    box-shadow: var(--lp-shadow-paper-2);
    cursor: pointer;
    transition: all var(--lp-transition);
  }
  .lp-wallet-btn:hover { background: var(--lp-accent-hover); transform: translateY(-2px); box-shadow: var(--lp-shadow-paper-3); }
}
```

## Component Patterns

```tsx
export function PaperHero() {
  return (
    <section className="min-h-screen bg-lp-bg flex items-center justify-center px-6 py-20">
      <div className="bg-lp-bg-paper rounded-md shadow-lp-stack p-12 max-w-xl text-center animate-lp-fade relative">
        <h1 className="font-lp-display text-lp-hero text-lp-text-primary leading-[1.15]">
          Tangible & Warm
        </h1>
        <p className="font-lp-body text-[1.0625rem] text-lp-text-secondary mt-4 leading-[1.7]">
          Digital assets, real-world feel. Layers of paper create depth, warmth, and trust.
        </p>
        <div className="flex items-center gap-4 justify-center mt-8">
          <button className="px-7 py-3 bg-lp-accent rounded-md text-white font-lp-body font-semibold shadow-lp-1 hover:bg-lp-accent-hover hover:-translate-y-0.5 hover:shadow-lp-2 transition-all">
            Connect Wallet
          </button>
          <button className="px-7 py-3 bg-lp-bg-paper rounded-md text-lp-text-primary font-lp-body font-semibold shadow-lp-1 hover:shadow-lp-2 hover:-translate-y-0.5 transition-all border border-lp-border">
            Read More
          </button>
        </div>
        {/* Stacked paper edges visible via shadow */}
      </div>
    </section>
  );
}

export function PaperCard({ title, description, stacked = false }: { title: string; description: string; stacked?: boolean }) {
  return (
    <div className={`bg-lp-bg-paper rounded-md p-7 relative animate-lp-fade hover:-translate-y-1 transition-all ${stacked ? "shadow-lp-stack" : "shadow-lp-1 hover:shadow-lp-2"}`}>
      <h3 className="font-lp-display text-xl text-lp-text-primary">{title}</h3>
      <p className="font-lp-body text-sm text-lp-text-secondary mt-2 leading-[1.7]">{description}</p>
    </div>
  );
}

export function PaperButton({ children, variant = "default" }: { children: React.ReactNode; variant?: "default" | "outline" }) {
  const styles = variant === "outline"
    ? "bg-lp-bg-paper border border-lp-border text-lp-text-primary hover:shadow-lp-2"
    : "bg-lp-accent text-white hover:bg-lp-accent-hover hover:shadow-lp-2";
  return (
    <button className={`px-7 py-3 rounded-md font-lp-body font-semibold shadow-lp-1 hover:-translate-y-0.5 transition-all ${styles}`}>
      {children}
    </button>
  );
}
```
