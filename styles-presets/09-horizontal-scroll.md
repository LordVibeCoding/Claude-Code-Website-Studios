# Horizontal Scroll

## CSS Variables

```css
:root {
  --hs-bg: #0e0e10;
  --hs-bg-panel: #161618;
  --hs-text-primary: #f0f0f0;
  --hs-text-secondary: #808080;
  --hs-text-accent: #ffd700;
  --hs-accent: #ffd700;
  --hs-accent-hover: #ffe44d;
  --hs-border: #2a2a2e;
  --hs-font-display: 'Syne', 'Inter', sans-serif;
  --hs-font-body: 'Inter', system-ui, sans-serif;
  --hs-font-size-hero: clamp(3rem, 8vw, 7rem);
  --hs-font-size-panel-title: clamp(1.5rem, 3vw, 2.5rem);
  --hs-font-size-body: 1rem;
  --hs-font-size-caption: 0.75rem;
  --hs-panel-width: 80vw;
  --hs-panel-gap: 40px;
  --hs-snap-type: x mandatory;
  --hs-snap-align: start;
  --hs-radius: 12px;
  --hs-radius-lg: 20px;
  --hs-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
  --hs-transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  --hs-spacing-xs: 0.5rem;
  --hs-spacing-sm: 1rem;
  --hs-spacing-md: 2rem;
  --hs-spacing-lg: 3rem;
  --hs-spacing-xl: 5rem;
  --hs-img-height: 60vh;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        hs: {
          bg: { DEFAULT: "#0e0e10", panel: "#161618" },
          text: { primary: "#f0f0f0", secondary: "#808080", accent: "#ffd700" },
          accent: { DEFAULT: "#ffd700", hover: "#ffe44d" },
          border: "#2a2a2e",
        },
      },
      fontFamily: {
        "hs-display": ["Syne", "Inter", "sans-serif"],
        "hs-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "hs-hero": "clamp(3rem, 8vw, 7rem)", "hs-panel": "clamp(1.5rem, 3vw, 2.5rem)" },
      width: { "hs-panel": "80vw" },
      boxShadow: { hs: "0 10px 40px rgba(0,0,0,0.5)" },
      keyframes: {
        "hs-fade-in": { "0%": { opacity: "0", transform: "translateX(40px)" }, "100%": { opacity: "1", transform: "translateX(0)" } },
        "hs-counter": { "0%": { "--num": "0" }, "100%": { "--num": "100" } },
      },
      animation: { "hs-fade-in": "hs-fade-in 0.8s cubic-bezier(0.4,0,0.2,1) forwards" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .hs-container {
    display: flex;
    overflow-x: auto;
    overflow-y: hidden;
    scroll-snap-type: var(--hs-snap-type);
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
    gap: var(--hs-panel-gap);
    padding: var(--hs-spacing-lg);
    height: 100vh;
    align-items: center;
  }
  .hs-container::-webkit-scrollbar { display: none; }
  .hs-panel {
    flex: 0 0 var(--hs-panel-width);
    scroll-snap-align: var(--hs-snap-align);
    background: var(--hs-bg-panel);
    border-radius: var(--hs-radius-lg);
    overflow: hidden;
    box-shadow: var(--hs-shadow);
    height: 75vh;
    display: flex;
    flex-direction: column;
    position: relative;
  }
  .hs-panel--full {
    flex: 0 0 100vw;
    height: 100vh;
    border-radius: 0;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .hs-panel-image {
    width: 100%;
    height: var(--hs-img-height);
    object-fit: cover;
  }
  .hs-panel-content {
    padding: var(--hs-spacing-md);
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }
  .hs-progress {
    position: fixed;
    bottom: 40px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 8px;
    z-index: 50;
  }
  .hs-progress-dot {
    width: 8px; height: 8px;
    border-radius: 50%;
    background: var(--hs-border);
    transition: all var(--hs-transition);
  }
  .hs-progress-dot.active {
    background: var(--hs-accent);
    width: 24px;
    border-radius: 4px;
  }
  .hs-wallet-btn {
    padding: 12px 28px;
    background: var(--hs-accent);
    border: none;
    border-radius: 9999px;
    color: var(--hs-bg);
    font-family: var(--hs-font-display);
    font-weight: 700;
    font-size: 0.875rem;
    cursor: pointer;
    transition: all var(--hs-transition);
  }
  .hs-wallet-btn:hover { background: var(--hs-accent-hover); transform: scale(1.03); }
  .hs-nav-arrow {
    width: 48px; height: 48px;
    border-radius: 50%;
    border: 1px solid var(--hs-border);
    background: var(--hs-bg-panel);
    color: var(--hs-text-primary);
    display: flex; align-items: center; justify-content: center;
    cursor: pointer;
    transition: all var(--hs-transition);
  }
  .hs-nav-arrow:hover { border-color: var(--hs-accent); color: var(--hs-accent); }
}
```

## Component Patterns

```tsx
export function HScrollHero() {
  return (
    <section className="h-screen bg-hs-bg flex items-center justify-center relative overflow-hidden">
      <div className="text-center px-6">
        <h1 className="font-hs-display text-hs-hero font-bold text-hs-text-primary tracking-tight leading-[0.9]">
          Scroll <span className="text-hs-accent">Sideways</span>
        </h1>
        <p className="font-hs-body text-hs-text-secondary text-lg mt-6 max-w-md mx-auto">
          Navigate through our DeFi ecosystem. Swipe or scroll horizontally.
        </p>
        <div className="flex items-center gap-4 justify-center mt-10">
          <button className="px-7 py-3 bg-hs-accent rounded-full text-hs-bg font-hs-display font-bold text-sm hover:bg-hs-accent-hover hover:scale-[1.03] transition-all">
            Connect Wallet
          </button>
          <div className="flex items-center gap-2 text-hs-text-secondary text-sm font-hs-body">
            <span>Scroll</span>
            <span className="inline-block w-8 h-px bg-hs-text-secondary animate-pulse" />
          </div>
        </div>
      </div>
      {/* Scroll indicator */}
      <div className="absolute bottom-10 left-1/2 -translate-x-1/2 flex gap-2">
        {[0, 1, 2, 3, 4].map((i) => (
          <div key={i} className={`h-2 rounded-sm transition-all ${i === 0 ? "w-6 bg-hs-accent" : "w-2 bg-hs-border"}`} />
        ))}
      </div>
    </section>
  );
}

export function HScrollPanel({ image, title, description, index }: { image: string; title: string; description: string; index: number }) {
  return (
    <div className="flex-shrink-0 w-[80vw] h-[75vh] bg-hs-bg-panel rounded-[20px] overflow-hidden shadow-hs snap-start flex flex-col animate-hs-fade-in" style={{ animationDelay: `${index * 0.1}s` }}>
      <img src={image} alt={title} className="w-full h-[60vh] object-cover" />
      <div className="p-8 flex-1 flex flex-col justify-between">
        <div>
          <span className="font-hs-body text-xs text-hs-accent uppercase tracking-widest">0{index + 1}</span>
          <h2 className="font-hs-display text-hs-panel font-bold text-hs-text-primary mt-2">{title}</h2>
          <p className="font-hs-body text-hs-text-secondary text-sm mt-2 leading-relaxed">{description}</p>
        </div>
      </div>
    </div>
  );
}

export function HScrollButton({ children, direction = "right" }: { children: React.ReactNode; direction?: "left" | "right" }) {
  return (
    <button className="w-12 h-12 rounded-full border border-hs-border bg-hs-bg-panel text-hs-text-primary flex items-center justify-center hover:border-hs-accent hover:text-hs-accent transition-all">
      {direction === "left" ? "\u2190" : "\u2192"}
      <span className="sr-only">{children}</span>
    </button>
  );
}
```
