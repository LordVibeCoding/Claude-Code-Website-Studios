# Aurora

## CSS Variables

```css
:root {
  --au-bg: #070b14;
  --au-bg-surface: rgba(10, 18, 36, 0.7);
  --au-text-primary: #e8edf5;
  --au-text-secondary: #7b8faa;
  --au-text-tertiary: #4a5a72;
  --au-aurora-1: #00ff87;
  --au-aurora-2: #60efff;
  --au-aurora-3: #7b61ff;
  --au-aurora-4: #ff61d8;
  --au-aurora-5: #00c9ff;
  --au-accent: #60efff;
  --au-accent-hover: #8af4ff;
  --au-border: rgba(96, 239, 255, 0.1);
  --au-border-hover: rgba(96, 239, 255, 0.25);
  --au-font-display: 'Outfit', 'Inter', sans-serif;
  --au-font-body: 'Inter', system-ui, sans-serif;
  --au-font-size-hero: clamp(3rem, 7vw, 6rem);
  --au-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --au-font-size-body: 1rem;
  --au-radius: 16px;
  --au-radius-sm: 10px;
  --au-radius-full: 9999px;
  --au-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
  --au-glow: 0 0 30px rgba(96, 239, 255, 0.15);
  --au-transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  --au-spacing-xs: 0.5rem;
  --au-spacing-sm: 1rem;
  --au-spacing-md: 2rem;
  --au-spacing-lg: 3rem;
  --au-spacing-xl: 5rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        au: {
          bg: { DEFAULT: "#070b14", surface: "rgba(10,18,36,0.7)" },
          text: { primary: "#e8edf5", secondary: "#7b8faa", tertiary: "#4a5a72" },
          aurora: { 1: "#00ff87", 2: "#60efff", 3: "#7b61ff", 4: "#ff61d8", 5: "#00c9ff" },
          accent: { DEFAULT: "#60efff", hover: "#8af4ff" },
          border: { DEFAULT: "rgba(96,239,255,0.1)", hover: "rgba(96,239,255,0.25)" },
        },
      },
      fontFamily: {
        "au-display": ["Outfit", "Inter", "sans-serif"],
        "au-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "au-hero": "clamp(3rem, 7vw, 6rem)", "au-heading": "clamp(1.5rem, 3vw, 2.5rem)" },
      boxShadow: {
        au: "0 20px 60px rgba(0,0,0,0.5)",
        "au-glow": "0 0 30px rgba(96,239,255,0.15)",
        "au-glow-green": "0 0 30px rgba(0,255,135,0.15)",
      },
      keyframes: {
        aurora: {
          "0%": { backgroundPosition: "50% 50%", transform: "rotate(-5deg) scale(1.5)" },
          "25%": { backgroundPosition: "0% 50%", transform: "rotate(0deg) scale(1.8)" },
          "50%": { backgroundPosition: "100% 50%", transform: "rotate(5deg) scale(1.5)" },
          "75%": { backgroundPosition: "50% 100%", transform: "rotate(-3deg) scale(1.7)" },
          "100%": { backgroundPosition: "50% 50%", transform: "rotate(-5deg) scale(1.5)" },
        },
        "au-shimmer": {
          "0%": { opacity: "0.3" }, "50%": { opacity: "0.6" }, "100%": { opacity: "0.3" },
        },
        "au-fade-up": { "0%": { opacity: "0", transform: "translateY(30px)" }, "100%": { opacity: "1", transform: "translateY(0)" } },
      },
      animation: {
        aurora: "aurora 20s ease infinite",
        "au-shimmer": "au-shimmer 4s ease-in-out infinite",
        "au-fade-up": "au-fade-up 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .au-aurora-bg {
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: conic-gradient(from 0deg at 50% 50%,
      var(--au-aurora-1) 0deg,
      var(--au-aurora-2) 72deg,
      var(--au-aurora-3) 144deg,
      var(--au-aurora-4) 216deg,
      var(--au-aurora-5) 288deg,
      var(--au-aurora-1) 360deg);
    filter: blur(80px);
    opacity: 0.15;
    animation: aurora 20s ease infinite;
  }
  .au-aurora-band {
    position: absolute;
    width: 120%;
    height: 300px;
    left: -10%;
    background: linear-gradient(90deg, transparent, var(--au-aurora-1), var(--au-aurora-2), var(--au-aurora-3), transparent);
    filter: blur(60px);
    opacity: 0.12;
    animation: au-shimmer 4s ease-in-out infinite;
  }
  .au-card {
    background: var(--au-bg-surface);
    backdrop-filter: blur(20px);
    border: 1px solid var(--au-border);
    border-radius: var(--au-radius);
    padding: 28px;
    transition: all var(--au-transition);
  }
  .au-card:hover {
    border-color: var(--au-border-hover);
    box-shadow: var(--au-glow);
    transform: translateY(-4px);
  }
  .au-gradient-text {
    background: linear-gradient(135deg, var(--au-aurora-1), var(--au-aurora-2), var(--au-aurora-3));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
  .au-btn {
    padding: 14px 32px;
    background: linear-gradient(135deg, var(--au-aurora-2), var(--au-aurora-3));
    border: none;
    border-radius: var(--au-radius-full);
    color: #fff; font-weight: 700;
    cursor: pointer;
    box-shadow: 0 4px 20px rgba(96, 239, 255, 0.3);
    transition: all var(--au-transition);
  }
  .au-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(96, 239, 255, 0.4);
  }
  .au-wallet-btn {
    padding: 14px 32px;
    background: linear-gradient(135deg, var(--au-aurora-1), var(--au-aurora-2));
    border: none;
    border-radius: var(--au-radius-full);
    color: #070b14; font-weight: 800;
    cursor: pointer;
    box-shadow: 0 4px 20px rgba(0, 255, 135, 0.25);
    transition: all var(--au-transition);
  }
  .au-wallet-btn:hover {
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 8px 30px rgba(0, 255, 135, 0.35);
  }
}
```

## Component Patterns

```tsx
export function AuroraHero() {
  return (
    <section className="relative min-h-screen bg-au-bg flex items-center justify-center overflow-hidden">
      {/* Aurora background */}
      <div className="absolute top-[-50%] left-[-50%] w-[200%] h-[200%] bg-[conic-gradient(from_0deg_at_50%_50%,#00ff87_0deg,#60efff_72deg,#7b61ff_144deg,#ff61d8_216deg,#00c9ff_288deg,#00ff87_360deg)] blur-[80px] opacity-[0.15] animate-aurora" />
      {/* Aurora bands */}
      <div className="absolute top-[20%] left-[-10%] w-[120%] h-[300px] bg-gradient-to-r from-transparent via-au-aurora-1 via-au-aurora-2 to-transparent blur-[60px] opacity-[0.12] animate-au-shimmer" />
      <div className="absolute top-[60%] left-[-10%] w-[120%] h-[200px] bg-gradient-to-r from-transparent via-au-aurora-3 via-au-aurora-4 to-transparent blur-[50px] opacity-[0.1] animate-au-shimmer [animation-delay:2s]" />
      {/* Content */}
      <div className="relative z-10 text-center px-6 animate-au-fade-up">
        <h1 className="font-au-display text-au-hero font-bold leading-[1.05]">
          <span className="bg-gradient-to-r from-au-aurora-1 via-au-aurora-2 to-au-aurora-3 bg-clip-text text-transparent">
            Northern Lights
          </span>
        </h1>
        <p className="font-au-body text-au-text-secondary text-lg mt-6 max-w-lg mx-auto leading-relaxed">
          Ethereal, flowing, otherworldly. DeFi that dances like the aurora borealis.
        </p>
        <button className="mt-10 px-8 py-3.5 bg-gradient-to-r from-au-aurora-1 to-au-aurora-2 rounded-full text-au-bg font-au-display font-extrabold shadow-[0_4px_20px_rgba(0,255,135,0.25)] hover:-translate-y-0.5 hover:scale-[1.02] hover:shadow-[0_8px_30px_rgba(0,255,135,0.35)] transition-all">
          Connect Wallet
        </button>
      </div>
    </section>
  );
}

export function AuroraCard({ title, description, accentColor = "au-aurora-2" }: { title: string; description: string; accentColor?: string }) {
  return (
    <div className="bg-au-bg-surface backdrop-blur-[20px] border border-au-border rounded-2xl p-7 hover:border-au-border-hover hover:shadow-au-glow hover:-translate-y-1 transition-all group animate-au-fade-up">
      <div className={`w-2 h-8 rounded-full bg-${accentColor} opacity-60 group-hover:opacity-100 transition-opacity`} />
      <h3 className="font-au-display text-xl font-bold text-au-text-primary mt-4">{title}</h3>
      <p className="font-au-body text-sm text-au-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function AuroraButton({ children }: { children: React.ReactNode }) {
  return (
    <button className="px-7 py-3 bg-gradient-to-r from-au-aurora-2 to-au-aurora-3 rounded-full text-white font-au-display font-bold shadow-[0_4px_20px_rgba(96,239,255,0.3)] hover:-translate-y-0.5 hover:shadow-[0_8px_30px_rgba(96,239,255,0.4)] transition-all">
      {children}
    </button>
  );
}
```
