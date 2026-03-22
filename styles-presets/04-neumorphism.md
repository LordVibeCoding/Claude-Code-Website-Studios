# Neumorphism

## CSS Variables

```css
:root {
  --neu-bg: #e0e5ec;
  --neu-bg-dark: #2d2d3f;
  --neu-surface: #e0e5ec;
  --neu-text-primary: #3a3a4a;
  --neu-text-secondary: #6b6b7b;
  --neu-text-dark-primary: #e0e0e0;
  --neu-accent: #6c63ff;
  --neu-accent-light: #8b83ff;
  --neu-accent-green: #4ade80;
  --neu-shadow-light: #ffffff;
  --neu-shadow-dark: #a3b1c6;
  --neu-shadow-dark-light: #383850;
  --neu-shadow-dark-dark: #23233a;
  --neu-raised: 6px 6px 12px var(--neu-shadow-dark), -6px -6px 12px var(--neu-shadow-light);
  --neu-pressed: inset 4px 4px 8px var(--neu-shadow-dark), inset -4px -4px 8px var(--neu-shadow-light);
  --neu-flat: 3px 3px 6px var(--neu-shadow-dark), -3px -3px 6px var(--neu-shadow-light);
  --neu-radius: 16px;
  --neu-radius-sm: 10px;
  --neu-radius-full: 9999px;
  --neu-font: 'Inter', 'Nunito', system-ui, sans-serif;
  --neu-transition: 0.25s ease;
  --neu-spacing-xs: 0.5rem;
  --neu-spacing-sm: 1rem;
  --neu-spacing-md: 1.5rem;
  --neu-spacing-lg: 2rem;
  --neu-spacing-xl: 3rem;
  --neu-font-size-sm: 0.875rem;
  --neu-font-size-base: 1rem;
  --neu-font-size-lg: 1.25rem;
  --neu-font-size-xl: 1.75rem;
  --neu-font-size-2xl: 2.25rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        neu: {
          bg: "#e0e5ec", "bg-dark": "#2d2d3f",
          text: { primary: "#3a3a4a", secondary: "#6b6b7b" },
          accent: { DEFAULT: "#6c63ff", light: "#8b83ff", green: "#4ade80" },
          shadow: { light: "#ffffff", dark: "#a3b1c6" },
        },
      },
      fontFamily: { neu: ["Inter", "Nunito", "system-ui", "sans-serif"] },
      borderRadius: { neu: "16px", "neu-sm": "10px" },
      boxShadow: {
        "neu-raised": "6px 6px 12px #a3b1c6, -6px -6px 12px #ffffff",
        "neu-pressed": "inset 4px 4px 8px #a3b1c6, inset -4px -4px 8px #ffffff",
        "neu-flat": "3px 3px 6px #a3b1c6, -3px -3px 6px #ffffff",
        "neu-raised-lg": "10px 10px 20px #a3b1c6, -10px -10px 20px #ffffff",
      },
      keyframes: {
        "neu-pulse": { "0%, 100%": { boxShadow: "6px 6px 12px #a3b1c6, -6px -6px 12px #ffffff" }, "50%": { boxShadow: "3px 3px 6px #a3b1c6, -3px -3px 6px #ffffff" } },
      },
      animation: { "neu-pulse": "neu-pulse 2s ease-in-out infinite" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .neu-raised {
    background: var(--neu-bg);
    border-radius: var(--neu-radius);
    box-shadow: var(--neu-raised);
    border: none;
    transition: box-shadow var(--neu-transition);
  }
  .neu-raised:hover {
    box-shadow: 8px 8px 16px var(--neu-shadow-dark), -8px -8px 16px var(--neu-shadow-light);
  }
  .neu-pressed {
    background: var(--neu-bg);
    border-radius: var(--neu-radius);
    box-shadow: var(--neu-pressed);
    border: none;
  }
  .neu-flat {
    background: var(--neu-bg);
    border-radius: var(--neu-radius);
    box-shadow: var(--neu-flat);
    border: none;
  }
  .neu-btn {
    display: inline-flex; align-items: center; justify-content: center; gap: 8px;
    padding: 14px 28px;
    background: var(--neu-bg);
    border: none;
    border-radius: var(--neu-radius-full);
    box-shadow: var(--neu-raised);
    color: var(--neu-text-primary);
    font-family: var(--neu-font);
    font-size: var(--neu-font-size-sm);
    font-weight: 600;
    cursor: pointer;
    transition: box-shadow var(--neu-transition);
  }
  .neu-btn:active { box-shadow: var(--neu-pressed); }
  .neu-btn--accent {
    background: var(--neu-accent);
    color: #fff;
    box-shadow: 4px 4px 10px rgba(108, 99, 255, 0.3), -2px -2px 8px rgba(139, 131, 255, 0.2);
  }
  .neu-input {
    width: 100%; padding: 14px 18px;
    background: var(--neu-bg);
    border: none;
    border-radius: var(--neu-radius-sm);
    box-shadow: var(--neu-pressed);
    color: var(--neu-text-primary);
    font-family: var(--neu-font);
    outline: none;
  }
  .neu-toggle {
    width: 56px; height: 30px;
    background: var(--neu-bg);
    border-radius: var(--neu-radius-full);
    box-shadow: var(--neu-pressed);
    position: relative;
    cursor: pointer;
  }
  .neu-toggle::after {
    content: "";
    position: absolute; top: 3px; left: 3px;
    width: 24px; height: 24px;
    border-radius: 50%;
    background: var(--neu-bg);
    box-shadow: var(--neu-flat);
    transition: transform var(--neu-transition);
  }
  .neu-toggle.active::after { transform: translateX(26px); background: var(--neu-accent); }
  .neu-wallet-btn {
    padding: 14px 32px;
    background: var(--neu-accent);
    border: none;
    border-radius: var(--neu-radius-full);
    color: #fff; font-weight: 600;
    box-shadow: 4px 4px 10px rgba(108,99,255,0.35), -2px -2px 8px rgba(139,131,255,0.2);
    cursor: pointer;
    transition: all var(--neu-transition);
  }
  .neu-wallet-btn:active {
    box-shadow: inset 3px 3px 6px rgba(80,72,200,0.4), inset -3px -3px 6px rgba(139,131,255,0.3);
  }
}
```

## Component Patterns

```tsx
export function NeuHero() {
  return (
    <section className="min-h-screen bg-neu-bg flex items-center justify-center p-8">
      <div className="bg-neu-bg rounded-neu shadow-neu-raised-lg p-12 max-w-md text-center">
        <div className="w-20 h-20 mx-auto rounded-full bg-neu-bg shadow-neu-raised flex items-center justify-center">
          <span className="text-3xl text-neu-accent font-bold font-neu">N</span>
        </div>
        <h1 className="font-neu text-[2.25rem] font-bold text-neu-text-primary mt-6">
          Soft & Tactile
        </h1>
        <p className="font-neu text-neu-text-secondary mt-3 leading-relaxed">
          A touchable interface for decentralized finance.
        </p>
        <button className="mt-8 px-8 py-3.5 bg-neu-accent rounded-full text-white font-semibold font-neu shadow-[4px_4px_10px_rgba(108,99,255,0.35),-2px_-2px_8px_rgba(139,131,255,0.2)] active:shadow-[inset_3px_3px_6px_rgba(80,72,200,0.4),inset_-3px_-3px_6px_rgba(139,131,255,0.3)] transition-shadow">
          Connect Wallet
        </button>
      </div>
    </section>
  );
}

export function NeuCard({ title, value, icon }: { title: string; value: string; icon: string }) {
  return (
    <div className="bg-neu-bg rounded-neu shadow-neu-raised p-6 hover:shadow-[8px_8px_16px_#a3b1c6,-8px_-8px_16px_#ffffff] transition-shadow">
      <div className="w-12 h-12 rounded-neu-sm bg-neu-bg shadow-neu-pressed flex items-center justify-center text-xl">
        {icon}
      </div>
      <p className="font-neu text-neu-text-secondary text-sm mt-4">{title}</p>
      <p className="font-neu text-neu-text-primary text-2xl font-bold mt-1">{value}</p>
    </div>
  );
}

export function NeuButton({ children, pressed = false }: { children: React.ReactNode; pressed?: boolean }) {
  return (
    <button className={`inline-flex items-center gap-2 px-7 py-3.5 bg-neu-bg rounded-full font-neu text-sm font-semibold text-neu-text-primary transition-shadow ${pressed ? "shadow-neu-pressed" : "shadow-neu-raised active:shadow-neu-pressed"}`}>
      {children}
    </button>
  );
}
```
