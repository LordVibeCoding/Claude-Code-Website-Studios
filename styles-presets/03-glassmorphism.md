# Glassmorphism

## CSS Variables

```css
:root {
  --glass-bg-primary: #0f0f23;
  --glass-bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  --glass-surface: rgba(255, 255, 255, 0.08);
  --glass-surface-hover: rgba(255, 255, 255, 0.12);
  --glass-surface-active: rgba(255, 255, 255, 0.15);
  --glass-border: rgba(255, 255, 255, 0.18);
  --glass-border-hover: rgba(255, 255, 255, 0.28);
  --glass-text-primary: #ffffff;
  --glass-text-secondary: rgba(255, 255, 255, 0.7);
  --glass-text-tertiary: rgba(255, 255, 255, 0.45);
  --glass-accent: #818cf8;
  --glass-accent-pink: #f472b6;
  --glass-blur: 20px;
  --glass-blur-heavy: 40px;
  --glass-radius: 20px;
  --glass-radius-sm: 12px;
  --glass-radius-full: 9999px;
  --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
  --glass-shadow-lg: 0 16px 48px rgba(0, 0, 0, 0.4);
  --glass-inner-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.1);
  --glass-font-sans: 'SF Pro Display', 'Inter', system-ui, sans-serif;
  --glass-transition: 0.3s ease;
  --glass-transition-slow: 0.5s ease;
  --glass-spacing-xs: 0.5rem;
  --glass-spacing-sm: 1rem;
  --glass-spacing-md: 1.5rem;
  --glass-spacing-lg: 2.5rem;
  --glass-spacing-xl: 4rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        glass: {
          bg: "#0f0f23",
          surface: "rgba(255,255,255,0.08)", "surface-hover": "rgba(255,255,255,0.12)",
          border: "rgba(255,255,255,0.18)", "border-hover": "rgba(255,255,255,0.28)",
          text: { primary: "#ffffff", secondary: "rgba(255,255,255,0.7)", tertiary: "rgba(255,255,255,0.45)" },
          accent: { DEFAULT: "#818cf8", pink: "#f472b6" },
        },
      },
      fontFamily: { glass: ["SF Pro Display", "Inter", "system-ui", "sans-serif"] },
      borderRadius: { glass: "20px", "glass-sm": "12px" },
      backdropBlur: { glass: "20px", "glass-heavy": "40px" },
      boxShadow: {
        glass: "0 8px 32px rgba(0,0,0,0.3)",
        "glass-lg": "0 16px 48px rgba(0,0,0,0.4)",
        "glass-inner": "inset 0 1px 0 rgba(255,255,255,0.1)",
      },
      backgroundImage: {
        "glass-gradient": "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
        "glass-mesh": "radial-gradient(at 40% 20%, #667eea 0, transparent 50%), radial-gradient(at 80% 80%, #764ba2 0, transparent 50%)",
      },
      keyframes: {
        "glass-float": { "0%, 100%": { transform: "translateY(0)" }, "50%": { transform: "translateY(-10px)" } },
        "glass-glow": { "0%, 100%": { opacity: "0.5" }, "50%": { opacity: "1" } },
      },
      animation: { "glass-float": "glass-float 6s ease-in-out infinite", "glass-glow": "glass-glow 3s ease-in-out infinite" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .glass-panel {
    background: var(--glass-surface);
    backdrop-filter: blur(var(--glass-blur));
    -webkit-backdrop-filter: blur(var(--glass-blur));
    border: 1px solid var(--glass-border);
    border-radius: var(--glass-radius);
    box-shadow: var(--glass-shadow), var(--glass-inner-shadow);
    transition: all var(--glass-transition);
  }
  .glass-panel:hover {
    background: var(--glass-surface-hover);
    border-color: var(--glass-border-hover);
    box-shadow: var(--glass-shadow-lg), var(--glass-inner-shadow);
  }
  .glass-panel--heavy {
    backdrop-filter: blur(var(--glass-blur-heavy));
    -webkit-backdrop-filter: blur(var(--glass-blur-heavy));
  }
  .glass-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 12px 24px;
    background: var(--glass-surface);
    backdrop-filter: blur(var(--glass-blur));
    border: 1px solid var(--glass-border);
    border-radius: var(--glass-radius-full);
    color: var(--glass-text-primary);
    font-family: var(--glass-font-sans);
    font-size: 0.875rem; font-weight: 500;
    cursor: pointer;
    transition: all var(--glass-transition);
  }
  .glass-btn:hover {
    background: var(--glass-surface-hover);
    border-color: var(--glass-border-hover);
    transform: translateY(-1px);
  }
  .glass-input {
    width: 100%;
    padding: 12px 16px;
    background: var(--glass-surface);
    backdrop-filter: blur(var(--glass-blur));
    border: 1px solid var(--glass-border);
    border-radius: var(--glass-radius-sm);
    color: var(--glass-text-primary);
    font-family: var(--glass-font-sans);
    outline: none;
    transition: border-color var(--glass-transition);
  }
  .glass-input:focus { border-color: var(--glass-accent); }
  .glass-wallet-btn {
    padding: 12px 28px;
    background: linear-gradient(135deg, var(--glass-accent), var(--glass-accent-pink));
    border: none;
    border-radius: var(--glass-radius-full);
    color: #fff; font-weight: 600; font-size: 0.875rem;
    cursor: pointer;
    box-shadow: 0 4px 20px rgba(129, 140, 248, 0.4);
    transition: all var(--glass-transition);
  }
  .glass-wallet-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(129, 140, 248, 0.5);
  }
}
```

## Component Patterns

```tsx
export function GlassHero() {
  return (
    <section className="relative min-h-screen flex items-center justify-center bg-glass-bg overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(at_40%_20%,#667eea_0,transparent_50%),radial-gradient(at_80%_80%,#764ba2_0,transparent_50%)] opacity-40" />
      <div className="absolute top-20 left-20 w-72 h-72 bg-glass-accent/20 rounded-full blur-[100px] animate-glass-float" />
      <div className="absolute bottom-20 right-20 w-96 h-96 bg-glass-accent-pink/15 rounded-full blur-[120px] animate-glass-float [animation-delay:2s]" />
      <div className="relative z-10 bg-glass-surface backdrop-blur-glass border border-glass-border rounded-glass p-12 max-w-lg text-center shadow-glass [box-shadow:0_8px_32px_rgba(0,0,0,0.3),inset_0_1px_0_rgba(255,255,255,0.1)]">
        <h1 className="font-glass text-5xl font-bold text-glass-text-primary tracking-tight">
          Crystal Clear
        </h1>
        <p className="text-glass-text-secondary mt-4 text-lg leading-relaxed">
          Experience DeFi through the glass. Transparent, beautiful, powerful.
        </p>
        <button className="mt-8 px-7 py-3 bg-gradient-to-r from-glass-accent to-glass-accent-pink rounded-full text-white font-semibold text-sm shadow-[0_4px_20px_rgba(129,140,248,0.4)] hover:-translate-y-0.5 hover:shadow-[0_8px_30px_rgba(129,140,248,0.5)] transition-all">
          Connect Wallet
        </button>
      </div>
    </section>
  );
}

export function GlassCard({ title, value, change }: { title: string; value: string; change: string }) {
  return (
    <div className="bg-glass-surface backdrop-blur-glass border border-glass-border rounded-glass p-6 shadow-glass hover:bg-glass-surface-hover hover:border-glass-border-hover hover:shadow-glass-lg transition-all group">
      <p className="text-glass-text-tertiary text-sm font-glass">{title}</p>
      <p className="text-glass-text-primary text-3xl font-bold font-glass mt-2">{value}</p>
      <p className="text-green-400 text-sm font-glass mt-1">{change}</p>
      <div className="absolute inset-0 rounded-glass bg-gradient-to-b from-white/[0.03] to-transparent pointer-events-none" />
    </div>
  );
}

export function GlassButton({ children, variant = "default" }: { children: React.ReactNode; variant?: "default" | "accent" }) {
  const base = "inline-flex items-center gap-2 px-6 py-3 rounded-full font-glass text-sm font-medium transition-all hover:-translate-y-0.5";
  const styles = variant === "accent"
    ? "bg-gradient-to-r from-glass-accent to-glass-accent-pink text-white shadow-[0_4px_20px_rgba(129,140,248,0.4)] hover:shadow-[0_8px_30px_rgba(129,140,248,0.5)]"
    : "bg-glass-surface backdrop-blur-glass border border-glass-border text-glass-text-primary hover:bg-glass-surface-hover hover:border-glass-border-hover";
  return <button className={`${base} ${styles}`}>{children}</button>;
}
```
