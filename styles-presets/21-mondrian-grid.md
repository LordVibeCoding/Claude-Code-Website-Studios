# Mondrian Grid

## CSS Variables

```css
:root {
  --mon-bg: #f5f2e8;
  --mon-white: #faf8f0;
  --mon-black: #1a1a1a;
  --mon-red: #d42029;
  --mon-blue: #1b4aa0;
  --mon-yellow: #f5c518;
  --mon-border-width: 6px;
  --mon-border: 6px solid #1a1a1a;
  --mon-text-primary: #1a1a1a;
  --mon-text-secondary: #555555;
  --mon-text-inverse: #faf8f0;
  --mon-font-display: 'Space Grotesk', 'Helvetica Neue', sans-serif;
  --mon-font-body: 'Inter', system-ui, sans-serif;
  --mon-font-size-hero: clamp(2.5rem, 6vw, 5rem);
  --mon-font-size-heading: clamp(1.25rem, 2.5vw, 2rem);
  --mon-font-size-body: 1rem;
  --mon-radius: 0px;
  --mon-transition: 0.3s ease;
  --mon-spacing-xs: 0.5rem;
  --mon-spacing-sm: 1rem;
  --mon-spacing-md: 1.5rem;
  --mon-spacing-lg: 2.5rem;
  --mon-spacing-xl: 4rem;
  --mon-gap: 6px;
  --mon-shadow: none;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        mon: {
          bg: "#f5f2e8", white: "#faf8f0", black: "#1a1a1a",
          red: "#d42029", blue: "#1b4aa0", yellow: "#f5c518",
          text: { primary: "#1a1a1a", secondary: "#555555", inverse: "#faf8f0" },
        },
      },
      fontFamily: {
        "mon-display": ["Space Grotesk", "Helvetica Neue", "sans-serif"],
        "mon-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "mon-hero": "clamp(2.5rem, 6vw, 5rem)", "mon-heading": "clamp(1.25rem, 2.5vw, 2rem)" },
      borderWidth: { mon: "6px" },
      gap: { mon: "6px" },
      gridTemplateColumns: {
        "mon-hero": "2fr 1fr 1fr",
        "mon-feature": "1fr 1fr 2fr",
      },
      gridTemplateRows: {
        "mon-hero": "2fr 1fr",
      },
      keyframes: {
        "mon-slide": { "0%": { transform: "scaleX(0)" }, "100%": { transform: "scaleX(1)" } },
        "mon-fade": { "0%": { opacity: "0" }, "100%": { opacity: "1" } },
      },
      animation: {
        "mon-slide": "mon-slide 0.6s ease forwards",
        "mon-fade": "mon-fade 0.5s ease forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .mon-grid {
    display: grid;
    gap: var(--mon-gap);
    border: var(--mon-border);
    background: var(--mon-black);
  }
  .mon-cell {
    background: var(--mon-white);
    padding: 24px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    overflow: hidden;
  }
  .mon-cell--red { background: var(--mon-red); color: var(--mon-text-inverse); }
  .mon-cell--blue { background: var(--mon-blue); color: var(--mon-text-inverse); }
  .mon-cell--yellow { background: var(--mon-yellow); color: var(--mon-text-primary); }
  .mon-cell--black { background: var(--mon-black); color: var(--mon-text-inverse); }
  .mon-heading {
    font-family: var(--mon-font-display);
    font-size: var(--mon-font-size-hero);
    font-weight: 700;
    line-height: 1.1;
    letter-spacing: -0.02em;
  }
  .mon-body {
    font-family: var(--mon-font-body);
    font-size: var(--mon-font-size-body);
    line-height: 1.6;
  }
  .mon-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 14px 28px;
    background: var(--mon-black);
    border: none;
    color: var(--mon-text-inverse);
    font-family: var(--mon-font-display);
    font-size: 0.875rem; font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    cursor: pointer;
    transition: background var(--mon-transition);
  }
  .mon-btn:hover { background: var(--mon-red); }
  .mon-btn--red { background: var(--mon-red); }
  .mon-btn--red:hover { background: #b81c24; }
  .mon-btn--blue { background: var(--mon-blue); }
  .mon-btn--blue:hover { background: #143a80; }
  .mon-btn--outline {
    background: transparent;
    border: var(--mon-border-width) solid var(--mon-black);
    color: var(--mon-text-primary);
  }
  .mon-btn--outline:hover { background: var(--mon-black); color: var(--mon-text-inverse); }
  .mon-divider {
    width: 100%;
    height: var(--mon-border-width);
    background: var(--mon-black);
  }
  .mon-wallet-btn {
    padding: 14px 32px;
    background: var(--mon-red);
    border: none;
    color: var(--mon-text-inverse);
    font-family: var(--mon-font-display);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    cursor: pointer;
    transition: background var(--mon-transition);
  }
  .mon-wallet-btn:hover { background: #b81c24; }
}
```

## Component Patterns

```tsx
export function MondrianHero() {
  return (
    <section className="min-h-screen bg-mon-bg p-4 flex items-center justify-center">
      <div className="grid grid-cols-[2fr_1fr_1fr] grid-rows-[2fr_1fr] gap-[6px] border-mon border-mon-black bg-mon-black w-full max-w-5xl h-[80vh]">
        {/* Main white cell */}
        <div className="bg-mon-white p-10 flex flex-col justify-end row-span-1 animate-mon-fade">
          <h1 className="font-mon-display text-mon-hero font-bold text-mon-text-primary tracking-tight leading-[1.1]">
            Art Meets<br />Protocol
          </h1>
          <p className="font-mon-body text-mon-text-secondary mt-4 max-w-sm">
            Geometric precision. Primary colors. Decentralized beauty.
          </p>
          <button className="mt-6 self-start px-7 py-3.5 bg-mon-red text-mon-text-inverse font-mon-display font-bold uppercase tracking-wider hover:bg-[#b81c24] transition-colors">
            Connect Wallet
          </button>
        </div>
        {/* Red cell */}
        <div className="bg-mon-red p-6 flex items-center justify-center animate-mon-fade [animation-delay:0.1s]">
          <span className="font-mon-display text-4xl font-bold text-mon-text-inverse">TVL</span>
        </div>
        {/* Yellow cell */}
        <div className="bg-mon-yellow p-6 flex flex-col justify-center animate-mon-fade [animation-delay:0.2s]">
          <span className="font-mon-display text-3xl font-bold text-mon-text-primary">$2.4B</span>
          <span className="font-mon-body text-sm text-mon-text-primary/70 mt-1">Locked Value</span>
        </div>
        {/* Blue cell */}
        <div className="bg-mon-blue p-6 flex items-center justify-center animate-mon-fade [animation-delay:0.3s]">
          <span className="font-mon-display text-5xl font-bold text-mon-text-inverse">42</span>
        </div>
        {/* White bottom cell */}
        <div className="bg-mon-white p-6 flex items-center col-span-2 animate-mon-fade [animation-delay:0.4s]">
          <p className="font-mon-body text-sm text-mon-text-secondary">
            Inspired by Piet Mondrian. Built for Web3. Composition with Red, Blue, and Yellow.
          </p>
        </div>
      </div>
    </section>
  );
}

export function MondrianCard({ title, value, color = "white" }: { title: string; value: string; color?: "white" | "red" | "blue" | "yellow" }) {
  const bg = { white: "bg-mon-white text-mon-text-primary", red: "bg-mon-red text-mon-text-inverse", blue: "bg-mon-blue text-mon-text-inverse", yellow: "bg-mon-yellow text-mon-text-primary" }[color];
  return (
    <div className={`p-6 flex flex-col justify-between animate-mon-fade ${bg}`}>
      <span className="font-mon-body text-sm opacity-70 uppercase tracking-wider">{title}</span>
      <span className="font-mon-display text-3xl font-bold mt-4">{value}</span>
    </div>
  );
}

export function MondrianButton({ children, color = "black" }: { children: React.ReactNode; color?: "black" | "red" | "blue" | "outline" }) {
  const styles = {
    black: "bg-mon-black text-mon-text-inverse hover:bg-mon-red",
    red: "bg-mon-red text-mon-text-inverse hover:bg-[#b81c24]",
    blue: "bg-mon-blue text-mon-text-inverse hover:bg-[#143a80]",
    outline: "bg-transparent border-mon border-mon-black text-mon-text-primary hover:bg-mon-black hover:text-mon-text-inverse",
  }[color];
  return (
    <button className={`px-7 py-3.5 font-mon-display font-bold uppercase tracking-wider transition-colors ${styles}`}>
      {children}
    </button>
  );
}
```
