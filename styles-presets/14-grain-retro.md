# Grain Retro

## CSS Variables

```css
:root {
  --gr-bg: #f5f0e8;
  --gr-bg-warm: #ede6d8;
  --gr-bg-card: #faf7f2;
  --gr-text-primary: #2c2416;
  --gr-text-secondary: #6b5d4d;
  --gr-text-tertiary: #9b8b78;
  --gr-accent: #8b4513;
  --gr-accent-hover: #a0522d;
  --gr-accent-green: #3d5a3a;
  --gr-accent-red: #8b3a3a;
  --gr-border: #d4c8b4;
  --gr-border-dark: #b8a994;
  --gr-font-serif: 'Playfair Display', 'Georgia', serif;
  --gr-font-body: 'Lora', 'Times New Roman', serif;
  --gr-font-mono: 'IBM Plex Mono', monospace;
  --gr-font-size-hero: clamp(3rem, 6vw, 5rem);
  --gr-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --gr-font-size-body: 1.0625rem;
  --gr-radius: 4px;
  --gr-radius-sm: 2px;
  --gr-shadow: 0 2px 8px rgba(44, 36, 22, 0.1);
  --gr-shadow-lg: 0 8px 30px rgba(44, 36, 22, 0.15);
  --gr-transition: 0.3s ease;
  --gr-grain-opacity: 0.04;
  --gr-spacing-xs: 0.5rem;
  --gr-spacing-sm: 1rem;
  --gr-spacing-md: 2rem;
  --gr-spacing-lg: 3rem;
  --gr-spacing-xl: 5rem;
  --gr-line-height: 1.75;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        gr: {
          bg: { DEFAULT: "#f5f0e8", warm: "#ede6d8", card: "#faf7f2" },
          text: { primary: "#2c2416", secondary: "#6b5d4d", tertiary: "#9b8b78" },
          accent: { DEFAULT: "#8b4513", hover: "#a0522d", green: "#3d5a3a", red: "#8b3a3a" },
          border: { DEFAULT: "#d4c8b4", dark: "#b8a994" },
        },
      },
      fontFamily: {
        "gr-serif": ["Playfair Display", "Georgia", "serif"],
        "gr-body": ["Lora", "Times New Roman", "serif"],
        "gr-mono": ["IBM Plex Mono", "monospace"],
      },
      fontSize: { "gr-hero": "clamp(3rem, 6vw, 5rem)", "gr-heading": "clamp(1.5rem, 3vw, 2.5rem)" },
      boxShadow: { gr: "0 2px 8px rgba(44,36,22,0.1)", "gr-lg": "0 8px 30px rgba(44,36,22,0.15)" },
      keyframes: {
        "gr-fade": { "0%": { opacity: "0", transform: "translateY(20px)" }, "100%": { opacity: "1", transform: "translateY(0)" } },
      },
      animation: { "gr-fade": "gr-fade 0.8s ease forwards" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .gr-grain {
    position: fixed;
    inset: 0;
    pointer-events: none;
    z-index: 9999;
    opacity: var(--gr-grain-opacity);
  }
  .gr-grain svg {
    width: 100%;
    height: 100%;
  }
  .gr-page {
    background: var(--gr-bg);
    color: var(--gr-text-primary);
    font-family: var(--gr-font-body);
    line-height: var(--gr-line-height);
  }
  .gr-heading {
    font-family: var(--gr-font-serif);
    font-size: var(--gr-font-size-hero);
    font-weight: 700;
    color: var(--gr-text-primary);
    line-height: 1.15;
    font-style: italic;
  }
  .gr-card {
    background: var(--gr-bg-card);
    border: 1px solid var(--gr-border);
    border-radius: var(--gr-radius);
    padding: 28px;
    box-shadow: var(--gr-shadow);
    transition: box-shadow var(--gr-transition);
  }
  .gr-card:hover { box-shadow: var(--gr-shadow-lg); }
  .gr-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 12px 28px;
    background: var(--gr-accent);
    border: none;
    border-radius: var(--gr-radius);
    color: var(--gr-bg);
    font-family: var(--gr-font-body);
    font-size: 0.9375rem; font-weight: 600;
    cursor: pointer;
    transition: background var(--gr-transition);
  }
  .gr-btn:hover { background: var(--gr-accent-hover); }
  .gr-btn--outline {
    background: transparent;
    border: 1px solid var(--gr-border-dark);
    color: var(--gr-text-primary);
  }
  .gr-btn--outline:hover { border-color: var(--gr-accent); color: var(--gr-accent); background: transparent; }
  .gr-divider {
    height: 1px;
    background: var(--gr-border);
    margin: var(--gr-spacing-lg) 0;
    position: relative;
  }
  .gr-divider::after {
    content: "\2767";
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: var(--gr-bg);
    padding: 0 12px;
    color: var(--gr-text-tertiary);
    font-size: 1.25rem;
  }
  .gr-label {
    font-family: var(--gr-font-mono);
    font-size: 0.75rem;
    color: var(--gr-text-tertiary);
    text-transform: uppercase;
    letter-spacing: 0.1em;
  }
  .gr-wallet-btn {
    padding: 12px 28px;
    background: var(--gr-accent-green);
    border: none;
    border-radius: var(--gr-radius);
    color: var(--gr-bg);
    font-family: var(--gr-font-body);
    font-size: 0.9375rem; font-weight: 600;
    cursor: pointer;
    transition: all var(--gr-transition);
  }
  .gr-wallet-btn:hover { background: #4a6e47; }
}
```

## Component Patterns

```tsx
// Grain overlay — SVG noise
const GrainOverlay = () => (
  <div className="fixed inset-0 pointer-events-none z-[9999] opacity-[0.04]">
    <svg width="100%" height="100%">
      <filter id="grain"><feTurbulence baseFrequency="0.65" numOctaves="3" stitchTiles="stitch" /></filter>
      <rect width="100%" height="100%" filter="url(#grain)" />
    </svg>
  </div>
);

export function RetroHero() {
  return (
    <section className="min-h-screen bg-gr-bg flex items-center justify-center px-6 relative">
      <GrainOverlay />
      <div className="max-w-2xl text-center animate-gr-fade">
        <span className="font-gr-mono text-xs text-gr-text-tertiary uppercase tracking-[0.15em]">Est. MMXXIV</span>
        <h1 className="font-gr-serif text-gr-hero font-bold text-gr-text-primary leading-[1.15] italic mt-4">
          A Return to Substance
        </h1>
        <p className="font-gr-body text-gr-text-secondary text-[1.0625rem] mt-6 leading-[1.75] max-w-md mx-auto">
          Decentralized finance, crafted with the care and attention of a bygone era. Authentic, warm, enduring.
        </p>
        <div className="flex items-center gap-4 justify-center mt-10">
          <button className="px-7 py-3 bg-gr-accent-green rounded text-gr-bg font-gr-body font-semibold hover:bg-[#4a6e47] transition-colors">
            Connect Wallet
          </button>
          <button className="px-7 py-3 bg-transparent border border-gr-border-dark rounded text-gr-text-primary font-gr-body font-semibold hover:border-gr-accent hover:text-gr-accent transition-colors">
            Read Manifesto
          </button>
        </div>
        {/* Ornamental divider */}
        <div className="mt-16 relative">
          <div className="h-px bg-gr-border" />
          <span className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-gr-bg px-3 text-gr-text-tertiary text-xl">{"\u2767"}</span>
        </div>
      </div>
    </section>
  );
}

export function RetroCard({ title, description, date }: { title: string; description: string; date: string }) {
  return (
    <div className="bg-gr-bg-card border border-gr-border rounded p-7 shadow-gr hover:shadow-gr-lg transition-shadow">
      <span className="font-gr-mono text-xs text-gr-text-tertiary uppercase tracking-[0.1em]">{date}</span>
      <h3 className="font-gr-serif text-xl font-bold text-gr-text-primary mt-3 italic">{title}</h3>
      <p className="font-gr-body text-[0.9375rem] text-gr-text-secondary mt-2 leading-[1.75]">{description}</p>
    </div>
  );
}

export function RetroButton({ children, variant = "default" }: { children: React.ReactNode; variant?: "default" | "outline" }) {
  const styles = variant === "outline"
    ? "bg-transparent border border-gr-border-dark text-gr-text-primary hover:border-gr-accent hover:text-gr-accent"
    : "bg-gr-accent text-gr-bg hover:bg-gr-accent-hover";
  return (
    <button className={`inline-flex items-center gap-2 px-7 py-3 rounded font-gr-body font-semibold transition-colors ${styles}`}>
      {children}
    </button>
  );
}
```
