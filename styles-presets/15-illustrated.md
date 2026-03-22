# Illustrated

## CSS Variables

```css
:root {
  --il-bg: #fef9f0;
  --il-bg-card: #ffffff;
  --il-bg-accent: #fff4e6;
  --il-text-primary: #2d2a26;
  --il-text-secondary: #6e6860;
  --il-text-tertiary: #a09888;
  --il-accent: #ff6b35;
  --il-accent-hover: #ff8555;
  --il-accent-blue: #4e8cff;
  --il-accent-green: #38c97c;
  --il-accent-purple: #9b6dff;
  --il-accent-pink: #ff6ba6;
  --il-border: #f0e8dc;
  --il-border-hover: #e0d5c5;
  --il-font-display: 'Nunito', 'Quicksand', sans-serif;
  --il-font-body: 'Nunito', system-ui, sans-serif;
  --il-font-size-hero: clamp(2.5rem, 5vw, 4rem);
  --il-font-size-heading: clamp(1.25rem, 2.5vw, 2rem);
  --il-font-size-body: 1rem;
  --il-radius: 20px;
  --il-radius-sm: 12px;
  --il-radius-full: 9999px;
  --il-shadow: 0 4px 20px rgba(45, 42, 38, 0.06);
  --il-shadow-lg: 0 10px 40px rgba(45, 42, 38, 0.1);
  --il-transition: 0.35s cubic-bezier(0.4, 0, 0.2, 1);
  --il-spacing-xs: 0.5rem;
  --il-spacing-sm: 1rem;
  --il-spacing-md: 1.5rem;
  --il-spacing-lg: 2.5rem;
  --il-spacing-xl: 4rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        il: {
          bg: { DEFAULT: "#fef9f0", card: "#ffffff", accent: "#fff4e6" },
          text: { primary: "#2d2a26", secondary: "#6e6860", tertiary: "#a09888" },
          accent: { DEFAULT: "#ff6b35", hover: "#ff8555", blue: "#4e8cff", green: "#38c97c", purple: "#9b6dff", pink: "#ff6ba6" },
          border: { DEFAULT: "#f0e8dc", hover: "#e0d5c5" },
        },
      },
      fontFamily: { il: ["Nunito", "Quicksand", "sans-serif"] },
      fontSize: { "il-hero": "clamp(2.5rem, 5vw, 4rem)", "il-heading": "clamp(1.25rem, 2.5vw, 2rem)" },
      borderRadius: { il: "20px", "il-sm": "12px" },
      boxShadow: { il: "0 4px 20px rgba(45,42,38,0.06)", "il-lg": "0 10px 40px rgba(45,42,38,0.1)" },
      keyframes: {
        "il-bounce": { "0%, 100%": { transform: "translateY(0)" }, "50%": { transform: "translateY(-12px)" } },
        "il-wiggle": { "0%, 100%": { transform: "rotate(0)" }, "25%": { transform: "rotate(-3deg)" }, "75%": { transform: "rotate(3deg)" } },
        "il-pop": { "0%": { transform: "scale(0.8)", opacity: "0" }, "60%": { transform: "scale(1.05)" }, "100%": { transform: "scale(1)", opacity: "1" } },
      },
      animation: {
        "il-bounce": "il-bounce 2s ease-in-out infinite",
        "il-wiggle": "il-wiggle 1s ease-in-out infinite",
        "il-pop": "il-pop 0.5s cubic-bezier(0.16,1,0.3,1) forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .il-card {
    background: var(--il-bg-card);
    border: 2px solid var(--il-border);
    border-radius: var(--il-radius);
    padding: 24px;
    box-shadow: var(--il-shadow);
    transition: all var(--il-transition);
  }
  .il-card:hover {
    border-color: var(--il-border-hover);
    box-shadow: var(--il-shadow-lg);
    transform: translateY(-4px);
  }
  .il-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 14px 28px;
    background: var(--il-accent);
    border: none;
    border-radius: var(--il-radius-full);
    color: #fff;
    font-family: var(--il-font-display);
    font-size: 0.9375rem; font-weight: 800;
    cursor: pointer;
    transition: all var(--il-transition);
    box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
  }
  .il-btn:hover {
    background: var(--il-accent-hover);
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
  }
  .il-btn--outline {
    background: transparent;
    border: 2px solid var(--il-border);
    color: var(--il-text-primary);
    box-shadow: none;
  }
  .il-btn--outline:hover { border-color: var(--il-accent); color: var(--il-accent); background: transparent; box-shadow: none; }
  .il-icon-circle {
    width: 64px; height: 64px;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.75rem;
  }
  .il-badge {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 6px 14px;
    background: var(--il-bg-accent);
    border-radius: var(--il-radius-full);
    color: var(--il-accent);
    font-family: var(--il-font-body);
    font-size: 0.8125rem; font-weight: 700;
  }
  .il-heading {
    font-family: var(--il-font-display);
    font-size: var(--il-font-size-hero);
    font-weight: 800;
    color: var(--il-text-primary);
    line-height: 1.2;
  }
  .il-wallet-btn {
    padding: 14px 32px;
    background: var(--il-accent);
    border: none;
    border-radius: var(--il-radius-full);
    color: #fff; font-weight: 800;
    font-family: var(--il-font-display);
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
    transition: all var(--il-transition);
  }
  .il-wallet-btn:hover {
    background: var(--il-accent-hover);
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
  }
}
```

## Component Patterns

```tsx
export function IllustratedHero() {
  return (
    <section className="min-h-screen bg-il-bg flex items-center justify-center px-6 py-20 relative overflow-hidden">
      {/* Floating illustration blobs */}
      <div className="absolute top-20 left-10 w-20 h-20 bg-il-accent-blue/10 rounded-full animate-il-bounce" />
      <div className="absolute top-40 right-20 w-16 h-16 bg-il-accent-green/10 rounded-full animate-il-bounce [animation-delay:0.5s]" />
      <div className="absolute bottom-32 left-1/4 w-24 h-24 bg-il-accent-purple/10 rounded-full animate-il-bounce [animation-delay:1s]" />
      <div className="relative z-10 text-center max-w-2xl animate-il-pop">
        <div className="inline-flex items-center gap-2 px-4 py-1.5 bg-il-bg-accent rounded-full mb-6">
          <span className="text-il-accent font-il text-sm font-bold">New!</span>
          <span className="font-il text-sm text-il-text-secondary">v2.0 is here</span>
        </div>
        <h1 className="font-il text-il-hero font-extrabold text-il-text-primary leading-[1.2]">
          DeFi Made <span className="text-il-accent">Delightful</span>
        </h1>
        <p className="font-il text-il-text-secondary text-lg mt-4 leading-relaxed max-w-md mx-auto">
          Friendly, approachable, and beautifully illustrated. Finance for everyone.
        </p>
        <div className="flex items-center gap-4 justify-center mt-8">
          <button className="px-7 py-3.5 bg-il-accent rounded-full text-white font-il font-extrabold shadow-[0_4px_12px_rgba(255,107,53,0.3)] hover:bg-il-accent-hover hover:-translate-y-0.5 hover:scale-[1.02] hover:shadow-[0_6px_20px_rgba(255,107,53,0.4)] transition-all">
            Connect Wallet
          </button>
          <button className="px-7 py-3.5 bg-transparent border-2 border-il-border rounded-full text-il-text-primary font-il font-extrabold hover:border-il-accent hover:text-il-accent transition-all">
            Watch Demo
          </button>
        </div>
      </div>
    </section>
  );
}

export function IllustratedCard({ icon, color, title, description }: { icon: string; color: string; title: string; description: string }) {
  return (
    <div className="bg-il-bg-card border-2 border-il-border rounded-il p-6 shadow-il hover:border-il-border-hover hover:shadow-il-lg hover:-translate-y-1 transition-all group">
      <div className={`w-16 h-16 rounded-full flex items-center justify-center text-3xl ${color} group-hover:animate-il-wiggle`}>
        {icon}
      </div>
      <h3 className="font-il text-xl font-extrabold text-il-text-primary mt-4">{title}</h3>
      <p className="font-il text-sm text-il-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function IllustratedButton({ children, color = "orange" }: { children: React.ReactNode; color?: "orange" | "blue" | "green" }) {
  const colors = {
    orange: "bg-il-accent hover:bg-il-accent-hover shadow-[0_4px_12px_rgba(255,107,53,0.3)]",
    blue: "bg-il-accent-blue hover:bg-il-accent-blue/90 shadow-[0_4px_12px_rgba(78,140,255,0.3)]",
    green: "bg-il-accent-green hover:bg-il-accent-green/90 shadow-[0_4px_12px_rgba(56,201,124,0.3)]",
  }[color];
  return (
    <button className={`px-7 py-3.5 rounded-full text-white font-il font-extrabold hover:-translate-y-0.5 hover:scale-[1.02] transition-all ${colors}`}>
      {children}
    </button>
  );
}
```
