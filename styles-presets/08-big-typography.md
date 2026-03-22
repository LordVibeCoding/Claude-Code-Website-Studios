# Big Typography

## CSS Variables

```css
:root {
  --bt-bg: #0c0c0c;
  --bt-bg-alt: #141414;
  --bt-text-primary: #ffffff;
  --bt-text-secondary: #8a8a8a;
  --bt-text-accent: #ff4d00;
  --bt-accent: #ff4d00;
  --bt-accent-hover: #ff6a2a;
  --bt-border: #222222;
  --bt-font-display: 'ClashDisplay', 'Bebas Neue', 'Impact', sans-serif;
  --bt-font-body: 'Inter', system-ui, sans-serif;
  --bt-font-size-mega: clamp(4rem, 18vw, 18rem);
  --bt-font-size-hero: clamp(3rem, 15vw, 15rem);
  --bt-font-size-display: clamp(2rem, 8vw, 6rem);
  --bt-font-size-heading: clamp(1.5rem, 4vw, 3rem);
  --bt-font-size-body: clamp(1rem, 1.2vw, 1.25rem);
  --bt-font-weight-black: 900;
  --bt-font-weight-bold: 700;
  --bt-letter-spacing-tight: -0.06em;
  --bt-letter-spacing-ultra: -0.08em;
  --bt-line-height-display: 0.85;
  --bt-line-height-body: 1.6;
  --bt-radius: 4px;
  --bt-transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  --bt-shadow: none;
  --bt-spacing-xs: 0.5rem;
  --bt-spacing-sm: 1rem;
  --bt-spacing-md: 2rem;
  --bt-spacing-lg: 4rem;
  --bt-spacing-xl: 8rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        bt: {
          bg: { DEFAULT: "#0c0c0c", alt: "#141414" },
          text: { primary: "#ffffff", secondary: "#8a8a8a", accent: "#ff4d00" },
          accent: { DEFAULT: "#ff4d00", hover: "#ff6a2a" },
          border: "#222222",
        },
      },
      fontFamily: {
        "bt-display": ["ClashDisplay", "Bebas Neue", "Impact", "sans-serif"],
        "bt-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: {
        "bt-mega": "clamp(4rem, 18vw, 18rem)",
        "bt-hero": "clamp(3rem, 15vw, 15rem)",
        "bt-display": "clamp(2rem, 8vw, 6rem)",
        "bt-heading": "clamp(1.5rem, 4vw, 3rem)",
      },
      letterSpacing: { "bt-tight": "-0.06em", "bt-ultra": "-0.08em" },
      lineHeight: { "bt-display": "0.85", "bt-body": "1.6" },
      keyframes: {
        "bt-reveal": { "0%": { transform: "translateY(100%)", opacity: "0" }, "100%": { transform: "translateY(0)", opacity: "1" } },
        "bt-slide-left": { "0%": { transform: "translateX(100px)", opacity: "0" }, "100%": { transform: "translateX(0)", opacity: "1" } },
        "bt-stroke": { "0%": { "-webkit-text-stroke-color": "#ff4d00" }, "50%": { "-webkit-text-stroke-color": "#ffffff" }, "100%": { "-webkit-text-stroke-color": "#ff4d00" } },
      },
      animation: {
        "bt-reveal": "bt-reveal 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
        "bt-slide-left": "bt-slide-left 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .bt-mega {
    font-family: var(--bt-font-display);
    font-size: var(--bt-font-size-mega);
    font-weight: var(--bt-font-weight-black);
    letter-spacing: var(--bt-letter-spacing-ultra);
    line-height: var(--bt-line-height-display);
    color: var(--bt-text-primary);
    text-transform: uppercase;
  }
  .bt-hero-text {
    font-family: var(--bt-font-display);
    font-size: var(--bt-font-size-hero);
    font-weight: var(--bt-font-weight-black);
    letter-spacing: var(--bt-letter-spacing-tight);
    line-height: var(--bt-line-height-display);
    color: var(--bt-text-primary);
    text-transform: uppercase;
  }
  .bt-outline-text {
    -webkit-text-stroke: 2px var(--bt-text-primary);
    color: transparent;
  }
  .bt-outline-text:hover {
    -webkit-text-stroke: 2px var(--bt-accent);
    color: var(--bt-accent);
    transition: color var(--bt-transition);
  }
  .bt-body {
    font-family: var(--bt-font-body);
    font-size: var(--bt-font-size-body);
    color: var(--bt-text-secondary);
    line-height: var(--bt-line-height-body);
  }
  .bt-reveal-wrap {
    overflow: hidden;
    display: inline-block;
  }
  .bt-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 16px 36px;
    background: var(--bt-accent);
    border: none;
    border-radius: var(--bt-radius);
    color: #fff;
    font-family: var(--bt-font-display);
    font-size: 1rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    cursor: pointer;
    transition: background var(--bt-transition);
  }
  .bt-btn:hover { background: var(--bt-accent-hover); }
  .bt-divider {
    width: 100%; height: 1px;
    background: var(--bt-border);
    margin: var(--bt-spacing-lg) 0;
  }
  .bt-wallet-btn {
    padding: 16px 36px;
    background: var(--bt-accent);
    border: none;
    border-radius: var(--bt-radius);
    color: #fff;
    font-family: var(--bt-font-display);
    font-size: 1rem; font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    cursor: pointer;
    transition: background var(--bt-transition), transform var(--bt-transition);
  }
  .bt-wallet-btn:hover { background: var(--bt-accent-hover); transform: scale(1.02); }
}
```

## Component Patterns

```tsx
export function TypoHero() {
  return (
    <section className="min-h-screen bg-bt-bg flex flex-col justify-end pb-16 px-6 overflow-hidden">
      <div className="overflow-hidden">
        <h1 className="font-bt-display text-bt-hero font-black uppercase tracking-bt-ultra leading-bt-display text-bt-text-primary animate-bt-reveal">
          TRADE
        </h1>
      </div>
      <div className="overflow-hidden">
        <h1 className="font-bt-display text-bt-hero font-black uppercase tracking-bt-ultra leading-bt-display [-webkit-text-stroke:2px_#fff] text-transparent hover:text-bt-accent hover:[-webkit-text-stroke:2px_#ff4d00] transition-colors animate-bt-reveal [animation-delay:0.1s]">
          WITHOUT
        </h1>
      </div>
      <div className="overflow-hidden">
        <h1 className="font-bt-display text-bt-hero font-black uppercase tracking-bt-ultra leading-bt-display text-bt-text-accent animate-bt-reveal [animation-delay:0.2s]">
          LIMITS
        </h1>
      </div>
      <div className="flex items-center justify-between mt-12 border-t border-bt-border pt-8">
        <p className="font-bt-body text-bt-text-secondary max-w-sm leading-bt-body">
          The most powerful decentralized exchange. Zero limits, zero compromise.
        </p>
        <button className="px-9 py-4 bg-bt-accent rounded text-white font-bt-display font-bold uppercase tracking-wider hover:bg-bt-accent-hover hover:scale-[1.02] transition-all">
          Connect Wallet
        </button>
      </div>
    </section>
  );
}

export function TypoCard({ number, title, description }: { number: string; title: string; description: string }) {
  return (
    <div className="border-t border-bt-border py-8 group">
      <div className="flex items-start gap-8">
        <span className="font-bt-display text-bt-display font-black tracking-bt-tight leading-bt-display text-bt-border group-hover:text-bt-accent transition-colors">{number}</span>
        <div>
          <h3 className="font-bt-display text-bt-heading font-bold uppercase tracking-bt-tight text-bt-text-primary">{title}</h3>
          <p className="font-bt-body text-bt-text-secondary mt-2 leading-bt-body max-w-md">{description}</p>
        </div>
      </div>
    </div>
  );
}

export function TypoButton({ children }: { children: React.ReactNode }) {
  return (
    <button className="group inline-flex items-center gap-4 font-bt-display text-bt-heading font-bold uppercase tracking-bt-tight text-bt-text-primary hover:text-bt-accent transition-colors">
      {children}
      <span className="w-12 h-px bg-bt-text-primary group-hover:bg-bt-accent group-hover:w-20 transition-all" />
    </button>
  );
}
```
