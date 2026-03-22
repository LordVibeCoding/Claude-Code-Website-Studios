# Claymorphism

## CSS Variables

```css
:root {
  --clay-bg: #e8eff5;
  --clay-bg-warm: #f0e8f5;
  --clay-surface: #e4ecf4;
  --clay-text-primary: #2e3a4d;
  --clay-text-secondary: #6b7a8d;
  --clay-text-tertiary: #9ba8b8;
  --clay-accent: #6c5ce7;
  --clay-accent-hover: #7f70f0;
  --clay-accent-pink: #fd79a8;
  --clay-accent-blue: #0984e3;
  --clay-accent-green: #00b894;
  --clay-accent-orange: #fdcb6e;
  --clay-shadow-outer-dark: rgba(0, 0, 0, 0.12);
  --clay-shadow-outer-light: rgba(255, 255, 255, 0.8);
  --clay-shadow-inner: rgba(255, 255, 255, 0.6);
  --clay-shadow: 8px 8px 16px var(--clay-shadow-outer-dark), -4px -4px 12px var(--clay-shadow-outer-light), inset 0 2px 4px var(--clay-shadow-inner);
  --clay-shadow-hover: 12px 12px 24px var(--clay-shadow-outer-dark), -6px -6px 16px var(--clay-shadow-outer-light), inset 0 2px 4px var(--clay-shadow-inner);
  --clay-radius: 30px;
  --clay-radius-sm: 18px;
  --clay-radius-full: 9999px;
  --clay-font: 'Nunito', 'Quicksand', sans-serif;
  --clay-transition: 0.3s ease;
  --clay-spacing-xs: 0.5rem;
  --clay-spacing-sm: 1rem;
  --clay-spacing-md: 1.5rem;
  --clay-spacing-lg: 2.5rem;
  --clay-spacing-xl: 4rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        clay: {
          bg: { DEFAULT: "#e8eff5", warm: "#f0e8f5", surface: "#e4ecf4" },
          text: { primary: "#2e3a4d", secondary: "#6b7a8d", tertiary: "#9ba8b8" },
          accent: { DEFAULT: "#6c5ce7", hover: "#7f70f0", pink: "#fd79a8", blue: "#0984e3", green: "#00b894", orange: "#fdcb6e" },
        },
      },
      fontFamily: { clay: ["Nunito", "Quicksand", "sans-serif"] },
      borderRadius: { clay: "30px", "clay-sm": "18px" },
      boxShadow: {
        clay: "8px 8px 16px rgba(0,0,0,0.12), -4px -4px 12px rgba(255,255,255,0.8), inset 0 2px 4px rgba(255,255,255,0.6)",
        "clay-hover": "12px 12px 24px rgba(0,0,0,0.12), -6px -6px 16px rgba(255,255,255,0.8), inset 0 2px 4px rgba(255,255,255,0.6)",
        "clay-pressed": "inset 4px 4px 8px rgba(0,0,0,0.1), inset -2px -2px 6px rgba(255,255,255,0.7)",
        "clay-accent": "8px 8px 16px rgba(108,92,231,0.25), -4px -4px 12px rgba(255,255,255,0.4), inset 0 2px 4px rgba(255,255,255,0.3)",
      },
      keyframes: {
        "clay-bounce": { "0%, 100%": { transform: "translateY(0) scale(1)" }, "50%": { transform: "translateY(-8px) scale(1.02)" } },
        "clay-squish": { "0%": { transform: "scale(1)" }, "50%": { transform: "scale(0.95, 1.05)" }, "100%": { transform: "scale(1)" } },
        "clay-pop": { "0%": { transform: "scale(0.8)", opacity: "0" }, "70%": { transform: "scale(1.05)" }, "100%": { transform: "scale(1)", opacity: "1" } },
      },
      animation: {
        "clay-bounce": "clay-bounce 3s ease-in-out infinite",
        "clay-squish": "clay-squish 0.4s ease",
        "clay-pop": "clay-pop 0.5s cubic-bezier(0.16,1,0.3,1) forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .clay-card {
    background: var(--clay-surface);
    border-radius: var(--clay-radius);
    padding: 28px;
    box-shadow: var(--clay-shadow);
    transition: all var(--clay-transition);
  }
  .clay-card:hover {
    box-shadow: var(--clay-shadow-hover);
    transform: translateY(-3px);
  }
  .clay-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 14px 32px;
    background: var(--clay-accent);
    border: none;
    border-radius: var(--clay-radius-full);
    color: #fff;
    font-family: var(--clay-font);
    font-size: 0.9375rem; font-weight: 800;
    cursor: pointer;
    box-shadow: var(--clay-shadow);
    transition: all var(--clay-transition);
  }
  .clay-btn:hover {
    background: var(--clay-accent-hover);
    box-shadow: var(--clay-shadow-hover);
    transform: translateY(-2px);
  }
  .clay-btn:active {
    box-shadow: var(--clay-pressed);
    transform: translateY(1px);
  }
  .clay-btn--pink { background: var(--clay-accent-pink); }
  .clay-btn--blue { background: var(--clay-accent-blue); }
  .clay-btn--green { background: var(--clay-accent-green); }
  .clay-icon-blob {
    width: 72px; height: 72px;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    box-shadow: var(--clay-shadow);
    font-size: 2rem;
  }
  .clay-input {
    width: 100%; padding: 14px 20px;
    background: var(--clay-surface);
    border: none;
    border-radius: var(--clay-radius-sm);
    box-shadow: inset 4px 4px 8px rgba(0,0,0,0.1), inset -2px -2px 6px rgba(255,255,255,0.7);
    color: var(--clay-text-primary);
    font-family: var(--clay-font);
    outline: none;
  }
  .clay-wallet-btn {
    padding: 16px 36px;
    background: var(--clay-accent);
    border: none;
    border-radius: var(--clay-radius-full);
    color: #fff; font-weight: 800;
    font-family: var(--clay-font);
    cursor: pointer;
    box-shadow: 8px 8px 16px rgba(108,92,231,0.25), -4px -4px 12px rgba(255,255,255,0.4), inset 0 2px 4px rgba(255,255,255,0.3);
    transition: all var(--clay-transition);
  }
  .clay-wallet-btn:hover { background: var(--clay-accent-hover); transform: translateY(-2px) scale(1.02); }
  .clay-wallet-btn:active { transform: translateY(1px); box-shadow: inset 4px 4px 8px rgba(0,0,0,0.15); }
}
```

## Component Patterns

```tsx
export function ClayHero() {
  return (
    <section className="min-h-screen bg-clay-bg flex items-center justify-center px-6 py-20">
      <div className="text-center animate-clay-pop">
        <div className="w-24 h-24 mx-auto rounded-full bg-clay-accent flex items-center justify-center shadow-clay text-4xl animate-clay-bounce">
          <span className="text-white">&#x1F48E;</span>
        </div>
        <h1 className="font-clay text-[clamp(2.5rem,5vw,4rem)] font-extrabold text-clay-text-primary mt-8 leading-[1.2]">
          Soft & <span className="text-clay-accent">Playful</span>
        </h1>
        <p className="font-clay text-clay-text-secondary text-lg mt-4 max-w-md mx-auto leading-relaxed">
          DeFi feels like clay — moldable, fun, and endlessly creative.
        </p>
        <div className="flex items-center gap-4 justify-center mt-10">
          <button className="px-8 py-4 bg-clay-accent rounded-full text-white font-clay font-extrabold shadow-[8px_8px_16px_rgba(108,92,231,0.25),-4px_-4px_12px_rgba(255,255,255,0.4),inset_0_2px_4px_rgba(255,255,255,0.3)] hover:bg-clay-accent-hover hover:-translate-y-0.5 hover:scale-[1.02] active:translate-y-px active:shadow-[inset_4px_4px_8px_rgba(0,0,0,0.15)] transition-all">
            Connect Wallet
          </button>
          <button className="px-8 py-4 bg-clay-bg-surface rounded-full text-clay-text-primary font-clay font-extrabold shadow-clay hover:shadow-clay-hover hover:-translate-y-0.5 active:shadow-clay-pressed active:translate-y-px transition-all">
            Learn More
          </button>
        </div>
      </div>
    </section>
  );
}

export function ClayCard({ icon, color, title, description }: { icon: string; color: string; title: string; description: string }) {
  return (
    <div className="bg-clay-bg-surface rounded-clay p-7 shadow-clay hover:shadow-clay-hover hover:-translate-y-1 transition-all animate-clay-pop">
      <div className={`w-[72px] h-[72px] rounded-full flex items-center justify-center text-3xl shadow-clay ${color}`}>
        {icon}
      </div>
      <h3 className="font-clay text-xl font-extrabold text-clay-text-primary mt-5">{title}</h3>
      <p className="font-clay text-sm text-clay-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function ClayButton({ children, color = "purple" }: { children: React.ReactNode; color?: "purple" | "pink" | "blue" | "green" }) {
  const bg = { purple: "bg-clay-accent", pink: "bg-clay-accent-pink", blue: "bg-clay-accent-blue", green: "bg-clay-accent-green" }[color];
  return (
    <button className={`px-7 py-3.5 rounded-full text-white font-clay font-extrabold shadow-clay hover:shadow-clay-hover hover:-translate-y-0.5 active:shadow-clay-pressed active:translate-y-px transition-all ${bg}`}>
      {children}
    </button>
  );
}
```
