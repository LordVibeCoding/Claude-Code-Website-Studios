# Card Stacking

## CSS Variables

```css
:root {
  --cs-bg: #f4f1eb;
  --cs-bg-dark: #1a1a2e;
  --cs-card-1: #1a1a2e;
  --cs-card-2: #16213e;
  --cs-card-3: #0f3460;
  --cs-card-4: #533483;
  --cs-card-5: #e94560;
  --cs-text-primary: #ffffff;
  --cs-text-secondary: rgba(255, 255, 255, 0.7);
  --cs-text-dark: #1a1a2e;
  --cs-accent: #e94560;
  --cs-accent-hover: #ff6b81;
  --cs-font-display: 'Cabinet Grotesk', 'Inter', sans-serif;
  --cs-font-body: 'Inter', system-ui, sans-serif;
  --cs-font-size-hero: clamp(2.5rem, 6vw, 5rem);
  --cs-font-size-card-title: clamp(1.5rem, 3vw, 2.5rem);
  --cs-font-size-body: 1rem;
  --cs-radius: 24px;
  --cs-radius-sm: 12px;
  --cs-card-height: 85vh;
  --cs-card-offset: 20px;
  --cs-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  --cs-shadow-lg: 0 30px 80px rgba(0, 0, 0, 0.4);
  --cs-transition: 0.6s cubic-bezier(0.16, 1, 0.3, 1);
  --cs-spacing-xs: 0.5rem;
  --cs-spacing-sm: 1rem;
  --cs-spacing-md: 2rem;
  --cs-spacing-lg: 3rem;
  --cs-spacing-xl: 5rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        cs: {
          bg: { DEFAULT: "#f4f1eb", dark: "#1a1a2e" },
          card: { 1: "#1a1a2e", 2: "#16213e", 3: "#0f3460", 4: "#533483", 5: "#e94560" },
          text: { primary: "#ffffff", secondary: "rgba(255,255,255,0.7)", dark: "#1a1a2e" },
          accent: { DEFAULT: "#e94560", hover: "#ff6b81" },
        },
      },
      fontFamily: {
        "cs-display": ["Cabinet Grotesk", "Inter", "sans-serif"],
        "cs-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "cs-hero": "clamp(2.5rem, 6vw, 5rem)", "cs-card": "clamp(1.5rem, 3vw, 2.5rem)" },
      borderRadius: { cs: "24px", "cs-sm": "12px" },
      boxShadow: {
        cs: "0 20px 60px rgba(0,0,0,0.3)",
        "cs-lg": "0 30px 80px rgba(0,0,0,0.4)",
      },
      keyframes: {
        "cs-scale-in": { "0%": { transform: "scale(0.9)", opacity: "0" }, "100%": { transform: "scale(1)", opacity: "1" } },
      },
      animation: { "cs-scale-in": "cs-scale-in 0.6s cubic-bezier(0.16,1,0.3,1) forwards" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .cs-stack-container {
    position: relative;
    padding-bottom: 50vh;
  }
  .cs-sticky-card {
    position: sticky;
    top: 40px;
    height: var(--cs-card-height);
    border-radius: var(--cs-radius);
    padding: var(--cs-spacing-lg);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    box-shadow: var(--cs-shadow);
    overflow: hidden;
    transform-origin: top center;
    transition: transform var(--cs-transition);
  }
  .cs-sticky-card:nth-child(1) { background: var(--cs-card-1); z-index: 1; }
  .cs-sticky-card:nth-child(2) { background: var(--cs-card-2); z-index: 2; top: 60px; }
  .cs-sticky-card:nth-child(3) { background: var(--cs-card-3); z-index: 3; top: 80px; }
  .cs-sticky-card:nth-child(4) { background: var(--cs-card-4); z-index: 4; top: 100px; }
  .cs-sticky-card:nth-child(5) { background: var(--cs-card-5); z-index: 5; top: 120px; }
  .cs-card-number {
    font-family: var(--cs-font-display);
    font-size: 8rem;
    font-weight: 800;
    color: rgba(255, 255, 255, 0.06);
    position: absolute;
    top: -20px;
    right: 40px;
    line-height: 1;
  }
  .cs-card-title {
    font-family: var(--cs-font-display);
    font-size: var(--cs-font-size-card-title);
    font-weight: 700;
    color: var(--cs-text-primary);
  }
  .cs-card-body {
    font-family: var(--cs-font-body);
    font-size: var(--cs-font-size-body);
    color: var(--cs-text-secondary);
    line-height: 1.6;
    max-width: 500px;
  }
  .cs-wallet-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 14px 32px;
    background: var(--cs-accent);
    border: none;
    border-radius: var(--cs-radius-sm);
    color: #fff; font-weight: 600;
    font-family: var(--cs-font-body);
    cursor: pointer;
    box-shadow: 0 4px 20px rgba(233, 69, 96, 0.4);
    transition: all var(--cs-transition);
  }
  .cs-wallet-btn:hover {
    background: var(--cs-accent-hover);
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(233, 69, 96, 0.5);
  }
  .cs-indicator {
    position: fixed;
    right: 30px;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    flex-direction: column;
    gap: 12px;
    z-index: 100;
  }
  .cs-indicator-dot {
    width: 10px; height: 10px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.3);
    transition: all 0.3s ease;
  }
  .cs-indicator-dot.active {
    background: var(--cs-accent);
    height: 30px;
    border-radius: 5px;
  }
}
```

## Component Patterns

```tsx
export function StackHero() {
  return (
    <section className="min-h-screen bg-cs-bg flex items-center justify-center px-6">
      <div className="text-center">
        <h1 className="font-cs-display text-cs-hero font-bold text-cs-text-dark tracking-tight leading-[1.1]">
          Layers of <span className="text-cs-accent">Innovation</span>
        </h1>
        <p className="font-cs-body text-lg text-cs-text-dark/60 mt-4 max-w-md mx-auto">
          Scroll to reveal each layer of our decentralized protocol.
        </p>
        <button className="mt-8 px-8 py-3.5 bg-cs-accent rounded-cs-sm text-white font-semibold font-cs-body shadow-[0_4px_20px_rgba(233,69,96,0.4)] hover:bg-cs-accent-hover hover:-translate-y-0.5 hover:shadow-[0_8px_30px_rgba(233,69,96,0.5)] transition-all">
          Connect Wallet
        </button>
        <div className="mt-16 animate-bounce text-cs-text-dark/40">Scroll Down</div>
      </div>
    </section>
  );
}

export function StackCard({ index, title, description, color }: { index: number; title: string; description: string; color: string }) {
  const topOffset = 40 + index * 20;
  return (
    <div
      className={`sticky h-[85vh] rounded-cs p-12 flex flex-col justify-between shadow-cs overflow-hidden ${color}`}
      style={{ top: `${topOffset}px`, zIndex: index + 1 }}
    >
      <span className="absolute -top-5 right-10 font-cs-display text-[8rem] font-extrabold text-white/[0.06] leading-none select-none">
        {String(index + 1).padStart(2, "0")}
      </span>
      <div>
        <h2 className="font-cs-display text-cs-card font-bold text-white">{title}</h2>
        <p className="font-cs-body text-base text-white/70 mt-4 leading-relaxed max-w-lg">{description}</p>
      </div>
      <div className="flex items-center gap-4">
        <button className="px-6 py-3 bg-white/10 backdrop-blur-sm rounded-cs-sm text-white text-sm font-medium hover:bg-white/20 transition-colors">
          Learn More
        </button>
      </div>
    </div>
  );
}

export function StackButton({ children }: { children: React.ReactNode }) {
  return (
    <button className="inline-flex items-center gap-2 px-6 py-3 bg-cs-accent rounded-cs-sm text-white font-cs-body font-semibold text-sm shadow-[0_4px_20px_rgba(233,69,96,0.4)] hover:bg-cs-accent-hover hover:-translate-y-0.5 transition-all">
      {children}
    </button>
  );
}
```
