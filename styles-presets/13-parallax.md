# Parallax

## CSS Variables

```css
:root {
  --px-bg: #0b1120;
  --px-bg-layer-1: #0e1528;
  --px-bg-layer-2: #121a32;
  --px-bg-layer-3: #162040;
  --px-text-primary: #e4e8f0;
  --px-text-secondary: #7a8baa;
  --px-text-accent: #60a5fa;
  --px-accent: #3b82f6;
  --px-accent-hover: #60a5fa;
  --px-accent-warm: #f472b6;
  --px-border: rgba(59, 130, 246, 0.15);
  --px-font-display: 'Plus Jakarta Sans', 'Inter', sans-serif;
  --px-font-body: 'Inter', system-ui, sans-serif;
  --px-font-size-hero: clamp(3rem, 7vw, 6rem);
  --px-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --px-font-size-body: 1rem;
  --px-radius: 16px;
  --px-radius-sm: 8px;
  --px-shadow: 0 20px 50px rgba(0, 0, 0, 0.4);
  --px-shadow-glow: 0 0 30px rgba(59, 130, 246, 0.2);
  --px-transition: 0.5s cubic-bezier(0.16, 1, 0.3, 1);
  --px-parallax-speed-1: 0.2;
  --px-parallax-speed-2: 0.5;
  --px-parallax-speed-3: 0.8;
  --px-spacing-xs: 0.5rem;
  --px-spacing-sm: 1rem;
  --px-spacing-md: 2rem;
  --px-spacing-lg: 3rem;
  --px-spacing-xl: 6rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        px: {
          bg: { DEFAULT: "#0b1120", layer1: "#0e1528", layer2: "#121a32", layer3: "#162040" },
          text: { primary: "#e4e8f0", secondary: "#7a8baa", accent: "#60a5fa" },
          accent: { DEFAULT: "#3b82f6", hover: "#60a5fa", warm: "#f472b6" },
          border: "rgba(59,130,246,0.15)",
        },
      },
      fontFamily: {
        "px-display": ["Plus Jakarta Sans", "Inter", "sans-serif"],
        "px-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "px-hero": "clamp(3rem, 7vw, 6rem)", "px-heading": "clamp(1.5rem, 3vw, 2.5rem)" },
      boxShadow: {
        px: "0 20px 50px rgba(0,0,0,0.4)",
        "px-glow": "0 0 30px rgba(59,130,246,0.2)",
      },
      keyframes: {
        "px-drift": { "0%, 100%": { transform: "translateY(0) translateX(0)" }, "25%": { transform: "translateY(-20px) translateX(10px)" }, "75%": { transform: "translateY(10px) translateX(-5px)" } },
        "px-twinkle": { "0%, 100%": { opacity: "0.2" }, "50%": { opacity: "1" } },
        "px-rise": { "0%": { transform: "translateY(60px)", opacity: "0" }, "100%": { transform: "translateY(0)", opacity: "1" } },
      },
      animation: {
        "px-drift": "px-drift 15s ease-in-out infinite",
        "px-twinkle": "px-twinkle 3s ease-in-out infinite",
        "px-rise": "px-rise 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .px-scene {
    position: relative;
    overflow: hidden;
    perspective: 1000px;
  }
  .px-layer {
    position: absolute;
    inset: -20%;
    will-change: transform;
    transition: transform 0.1s linear;
  }
  .px-layer--back { z-index: 1; }
  .px-layer--mid { z-index: 2; }
  .px-layer--front { z-index: 3; }
  .px-content {
    position: relative;
    z-index: 10;
  }
  .px-star {
    position: absolute;
    width: 2px; height: 2px;
    background: #fff;
    border-radius: 50%;
    animation: px-twinkle var(--duration, 3s) ease-in-out infinite;
    animation-delay: var(--delay, 0s);
  }
  .px-mountain {
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 40%;
    clip-path: polygon(0% 100%, 15% 40%, 30% 70%, 50% 20%, 70% 60%, 85% 30%, 100% 100%);
  }
  .px-card {
    background: rgba(14, 21, 40, 0.8);
    backdrop-filter: blur(16px);
    border: 1px solid var(--px-border);
    border-radius: var(--px-radius);
    padding: 28px;
    box-shadow: var(--px-shadow);
    transition: all var(--px-transition);
  }
  .px-card:hover {
    border-color: var(--px-accent);
    box-shadow: var(--px-shadow-glow);
    transform: translateY(-4px);
  }
  .px-btn {
    padding: 12px 28px;
    background: var(--px-accent);
    border: none;
    border-radius: var(--px-radius-sm);
    color: #fff; font-weight: 600;
    cursor: pointer;
    transition: all var(--px-transition);
  }
  .px-btn:hover { background: var(--px-accent-hover); transform: translateY(-2px); box-shadow: var(--px-shadow-glow); }
  .px-wallet-btn {
    padding: 14px 32px;
    background: var(--px-accent);
    border: none;
    border-radius: var(--px-radius-sm);
    color: #fff; font-weight: 700;
    box-shadow: 0 4px 20px rgba(59, 130, 246, 0.4);
    cursor: pointer;
    transition: all var(--px-transition);
  }
  .px-wallet-btn:hover {
    background: var(--px-accent-hover);
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(59, 130, 246, 0.5);
  }
}
```

## Component Patterns

```tsx
export function ParallaxHero() {
  return (
    <section className="relative min-h-screen bg-px-bg overflow-hidden" style={{ perspective: "1000px" }}>
      {/* Back layer — stars */}
      <div className="absolute inset-[-20%] z-[1]" data-parallax-speed="0.2">
        {Array.from({ length: 50 }).map((_, i) => (
          <div key={i} className="absolute w-0.5 h-0.5 bg-white rounded-full animate-px-twinkle" style={{
            top: `${Math.random() * 100}%`, left: `${Math.random() * 100}%`,
            animationDelay: `${Math.random() * 5}s`, animationDuration: `${2 + Math.random() * 3}s`,
          }} />
        ))}
      </div>
      {/* Mid layer — nebula glow */}
      <div className="absolute inset-[-20%] z-[2]" data-parallax-speed="0.5">
        <div className="absolute top-1/3 left-1/4 w-[400px] h-[400px] bg-px-accent/10 rounded-full blur-[120px] animate-px-drift" />
        <div className="absolute bottom-1/4 right-1/3 w-[300px] h-[300px] bg-px-accent-warm/8 rounded-full blur-[100px] animate-px-drift [animation-delay:5s]" />
      </div>
      {/* Front layer — mountains */}
      <div className="absolute inset-[-20%] z-[3]" data-parallax-speed="0.8">
        <div className="absolute bottom-0 w-full h-[40%] bg-px-bg-layer1" style={{ clipPath: "polygon(0% 100%, 15% 40%, 30% 70%, 50% 20%, 70% 60%, 85% 30%, 100% 100%)" }} />
      </div>
      {/* Content */}
      <div className="relative z-10 min-h-screen flex items-center justify-center px-6">
        <div className="text-center animate-px-rise">
          <h1 className="font-px-display text-px-hero font-bold text-px-text-primary leading-[1.05] tracking-tight">
            Beyond the <span className="text-px-text-accent">Horizon</span>
          </h1>
          <p className="font-px-body text-px-text-secondary text-lg mt-6 max-w-lg mx-auto leading-relaxed">
            Multi-layered DeFi experience with depth and dimension.
          </p>
          <button className="mt-10 px-8 py-3.5 bg-px-accent rounded-lg text-white font-px-body font-bold shadow-[0_4px_20px_rgba(59,130,246,0.4)] hover:bg-px-accent-hover hover:-translate-y-0.5 hover:shadow-[0_8px_30px_rgba(59,130,246,0.5)] transition-all">
            Connect Wallet
          </button>
        </div>
      </div>
    </section>
  );
}

export function ParallaxCard({ title, description, delay = 0 }: { title: string; description: string; delay?: number }) {
  return (
    <div className="bg-px-bg-layer1/80 backdrop-blur-[16px] border border-px-border rounded-2xl p-7 shadow-px hover:border-px-accent hover:shadow-px-glow hover:-translate-y-1 transition-all animate-px-rise" style={{ animationDelay: `${delay}s` }}>
      <h3 className="font-px-display text-xl font-bold text-px-text-primary">{title}</h3>
      <p className="font-px-body text-sm text-px-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function ParallaxButton({ children }: { children: React.ReactNode }) {
  return (
    <button className="px-7 py-3 bg-px-accent rounded-lg text-white font-px-body font-semibold hover:bg-px-accent-hover hover:-translate-y-0.5 hover:shadow-px-glow transition-all">
      {children}
    </button>
  );
}
```
