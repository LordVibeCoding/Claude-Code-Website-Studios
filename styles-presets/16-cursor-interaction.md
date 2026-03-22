# Cursor Interaction

## CSS Variables

```css
:root {
  --ci-bg: #0a0a0a;
  --ci-bg-surface: #141414;
  --ci-text-primary: #f0f0f0;
  --ci-text-secondary: #808080;
  --ci-text-accent: #c8ff00;
  --ci-accent: #c8ff00;
  --ci-accent-hover: #d9ff4d;
  --ci-accent-dim: rgba(200, 255, 0, 0.15);
  --ci-border: #222222;
  --ci-border-hover: #444444;
  --ci-font-display: 'Space Grotesk', 'Inter', sans-serif;
  --ci-font-body: 'Inter', system-ui, sans-serif;
  --ci-font-size-hero: clamp(3rem, 8vw, 7rem);
  --ci-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --ci-font-size-body: 1rem;
  --ci-cursor-size: 20px;
  --ci-cursor-size-hover: 60px;
  --ci-cursor-border: 2px;
  --ci-radius: 12px;
  --ci-radius-sm: 8px;
  --ci-radius-full: 9999px;
  --ci-shadow: 0 0 20px rgba(200, 255, 0, 0.08);
  --ci-transition: 0.2s ease;
  --ci-transition-cursor: 0.15s ease;
  --ci-spacing-xs: 0.5rem;
  --ci-spacing-sm: 1rem;
  --ci-spacing-md: 2rem;
  --ci-spacing-lg: 3rem;
  --ci-spacing-xl: 5rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        ci: {
          bg: { DEFAULT: "#0a0a0a", surface: "#141414" },
          text: { primary: "#f0f0f0", secondary: "#808080", accent: "#c8ff00" },
          accent: { DEFAULT: "#c8ff00", hover: "#d9ff4d", dim: "rgba(200,255,0,0.15)" },
          border: { DEFAULT: "#222222", hover: "#444444" },
        },
      },
      fontFamily: {
        "ci-display": ["Space Grotesk", "Inter", "sans-serif"],
        "ci-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "ci-hero": "clamp(3rem, 8vw, 7rem)", "ci-heading": "clamp(1.5rem, 3vw, 2.5rem)" },
      cursor: { none: "none" },
      boxShadow: { ci: "0 0 20px rgba(200,255,0,0.08)" },
      keyframes: {
        "ci-expand": { "0%": { transform: "scale(1)" }, "100%": { transform: "scale(3)" } },
        "ci-magnetic-pull": { "0%": { transform: "translate(0, 0)" }, "100%": { transform: "translate(var(--mx), var(--my))" } },
      },
      animation: { "ci-expand": "ci-expand 0.3s ease forwards" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .ci-cursor {
    position: fixed;
    width: var(--ci-cursor-size);
    height: var(--ci-cursor-size);
    border: var(--ci-cursor-border) solid var(--ci-accent);
    border-radius: 50%;
    pointer-events: none;
    z-index: 9999;
    mix-blend-mode: difference;
    transition: width var(--ci-transition-cursor), height var(--ci-transition-cursor), background var(--ci-transition-cursor);
    transform: translate(-50%, -50%);
  }
  .ci-cursor--hover {
    width: var(--ci-cursor-size-hover);
    height: var(--ci-cursor-size-hover);
    background: var(--ci-accent-dim);
    border-color: transparent;
  }
  .ci-cursor--click {
    width: 12px;
    height: 12px;
    background: var(--ci-accent);
  }
  .ci-cursor-dot {
    position: fixed;
    width: 6px; height: 6px;
    background: var(--ci-accent);
    border-radius: 50%;
    pointer-events: none;
    z-index: 10000;
    transform: translate(-50%, -50%);
  }
  .ci-magnetic {
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    will-change: transform;
  }
  .ci-card {
    background: var(--ci-bg-surface);
    border: 1px solid var(--ci-border);
    border-radius: var(--ci-radius);
    padding: 24px;
    transition: all 0.3s ease;
    cursor: none;
  }
  .ci-card:hover {
    border-color: var(--ci-accent);
    box-shadow: var(--ci-shadow);
  }
  .ci-btn {
    padding: 14px 32px;
    background: var(--ci-accent);
    border: none;
    border-radius: var(--ci-radius-full);
    color: var(--ci-bg);
    font-family: var(--ci-font-display);
    font-size: 0.875rem; font-weight: 700;
    cursor: none;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .ci-btn:hover { transform: scale(1.05); }
  .ci-link {
    color: var(--ci-text-primary);
    text-decoration: none;
    position: relative;
    cursor: none;
  }
  .ci-link::after {
    content: "";
    position: absolute;
    bottom: -2px; left: 0;
    width: 0; height: 2px;
    background: var(--ci-accent);
    transition: width 0.3s ease;
  }
  .ci-link:hover::after { width: 100%; }
  .ci-wallet-btn {
    padding: 14px 32px;
    background: var(--ci-accent);
    border: none;
    border-radius: var(--ci-radius-full);
    color: var(--ci-bg);
    font-weight: 700;
    cursor: none;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .ci-wallet-btn:hover { transform: scale(1.05); box-shadow: 0 0 30px rgba(200, 255, 0, 0.2); }
}
```

## Component Patterns

```tsx
"use client";
import { useEffect, useRef, useState } from "react";

export function CustomCursor() {
  const cursorRef = useRef<HTMLDivElement>(null);
  const dotRef = useRef<HTMLDivElement>(null);
  const [isHover, setIsHover] = useState(false);

  useEffect(() => {
    const moveCursor = (e: MouseEvent) => {
      if (cursorRef.current) { cursorRef.current.style.left = `${e.clientX}px`; cursorRef.current.style.top = `${e.clientY}px`; }
      if (dotRef.current) { dotRef.current.style.left = `${e.clientX}px`; dotRef.current.style.top = `${e.clientY}px`; }
    };
    const addHover = () => setIsHover(true);
    const removeHover = () => setIsHover(false);
    document.addEventListener("mousemove", moveCursor);
    document.querySelectorAll("a, button, [data-cursor-hover]").forEach((el) => {
      el.addEventListener("mouseenter", addHover);
      el.addEventListener("mouseleave", removeHover);
    });
    return () => { document.removeEventListener("mousemove", moveCursor); };
  }, []);

  return (
    <>
      <div ref={cursorRef} className={`fixed pointer-events-none z-[9999] rounded-full -translate-x-1/2 -translate-y-1/2 mix-blend-difference transition-all duration-150 ${isHover ? "w-[60px] h-[60px] bg-ci-accent-dim border-transparent" : "w-5 h-5 border-2 border-ci-accent"}`} />
      <div ref={dotRef} className="fixed w-1.5 h-1.5 bg-ci-accent rounded-full pointer-events-none z-[10000] -translate-x-1/2 -translate-y-1/2" />
    </>
  );
}

export function CursorHero() {
  return (
    <section className="min-h-screen bg-ci-bg flex items-center justify-center px-6 cursor-none">
      <CustomCursor />
      <div className="text-center">
        <h1 className="font-ci-display text-ci-hero font-bold text-ci-text-primary tracking-tight leading-[0.9]">
          Move Your <span className="text-ci-text-accent">Cursor</span>
        </h1>
        <p className="font-ci-body text-ci-text-secondary text-lg mt-6 max-w-md mx-auto">
          Every interaction is an experience. Hover, click, explore.
        </p>
        <button className="mt-10 px-8 py-3.5 bg-ci-accent rounded-full text-ci-bg font-ci-display font-bold text-sm cursor-none hover:scale-105 hover:shadow-[0_0_30px_rgba(200,255,0,0.2)] transition-all" data-cursor-hover>
          Connect Wallet
        </button>
      </div>
    </section>
  );
}

export function CursorCard({ title, description }: { title: string; description: string }) {
  return (
    <div className="bg-ci-bg-surface border border-ci-border rounded-xl p-6 cursor-none hover:border-ci-accent hover:shadow-ci transition-all group" data-cursor-hover>
      <h3 className="font-ci-display text-xl font-bold text-ci-text-primary group-hover:text-ci-text-accent transition-colors">{title}</h3>
      <p className="font-ci-body text-sm text-ci-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}
```
