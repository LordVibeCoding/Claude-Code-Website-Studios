# Gradient Mesh

## CSS Variables

```css
:root {
  --gm-bg: #0f0f1a;
  --gm-bg-surface: rgba(255, 255, 255, 0.04);
  --gm-text-primary: #ffffff;
  --gm-text-secondary: #b0b0cc;
  --gm-text-tertiary: #6b6b8a;
  --gm-gradient-1: #ff6ec7;
  --gm-gradient-2: #7873f5;
  --gm-gradient-3: #4ff5c5;
  --gm-gradient-4: #ffcb57;
  --gm-gradient-5: #3b82f6;
  --gm-accent: #7873f5;
  --gm-accent-hover: #9590ff;
  --gm-border: rgba(255, 255, 255, 0.08);
  --gm-border-hover: rgba(255, 255, 255, 0.15);
  --gm-font-display: 'Plus Jakarta Sans', 'Inter', sans-serif;
  --gm-font-body: 'Inter', system-ui, sans-serif;
  --gm-font-size-hero: clamp(3rem, 7vw, 6rem);
  --gm-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --gm-font-size-body: 1rem;
  --gm-radius: 20px;
  --gm-radius-sm: 12px;
  --gm-radius-full: 9999px;
  --gm-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
  --gm-transition: 0.4s ease;
  --gm-blur-mesh: 100px;
  --gm-spacing-xs: 0.5rem;
  --gm-spacing-sm: 1rem;
  --gm-spacing-md: 2rem;
  --gm-spacing-lg: 3rem;
  --gm-spacing-xl: 5rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        gm: {
          bg: { DEFAULT: "#0f0f1a", surface: "rgba(255,255,255,0.04)" },
          text: { primary: "#ffffff", secondary: "#b0b0cc", tertiary: "#6b6b8a" },
          gradient: { 1: "#ff6ec7", 2: "#7873f5", 3: "#4ff5c5", 4: "#ffcb57", 5: "#3b82f6" },
          accent: { DEFAULT: "#7873f5", hover: "#9590ff" },
          border: { DEFAULT: "rgba(255,255,255,0.08)", hover: "rgba(255,255,255,0.15)" },
        },
      },
      fontFamily: {
        "gm-display": ["Plus Jakarta Sans", "Inter", "sans-serif"],
        "gm-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "gm-hero": "clamp(3rem, 7vw, 6rem)", "gm-heading": "clamp(1.5rem, 3vw, 2.5rem)" },
      borderRadius: { gm: "20px", "gm-sm": "12px" },
      backgroundImage: {
        "gm-mesh": "radial-gradient(at 0% 0%, #ff6ec7 0, transparent 50%), radial-gradient(at 100% 0%, #7873f5 0, transparent 50%), radial-gradient(at 100% 100%, #4ff5c5 0, transparent 50%), radial-gradient(at 0% 100%, #ffcb57 0, transparent 50%)",
      },
      keyframes: {
        "gm-shift": {
          "0%": { backgroundPosition: "0% 50%" },
          "50%": { backgroundPosition: "100% 50%" },
          "100%": { backgroundPosition: "0% 50%" },
        },
        "gm-rotate": { "0%": { transform: "rotate(0deg)" }, "100%": { transform: "rotate(360deg)" } },
        "gm-morph": {
          "0%, 100%": { borderRadius: "60% 40% 30% 70% / 60% 30% 70% 40%" },
          "50%": { borderRadius: "30% 60% 70% 40% / 50% 60% 30% 60%" },
        },
      },
      animation: {
        "gm-shift": "gm-shift 15s ease infinite",
        "gm-rotate": "gm-rotate 30s linear infinite",
        "gm-morph": "gm-morph 8s ease-in-out infinite",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .gm-mesh-bg {
    position: absolute;
    inset: -50%;
    background: radial-gradient(at 0% 0%, var(--gm-gradient-1) 0, transparent 50%),
                radial-gradient(at 100% 0%, var(--gm-gradient-2) 0, transparent 50%),
                radial-gradient(at 100% 100%, var(--gm-gradient-3) 0, transparent 50%),
                radial-gradient(at 0% 100%, var(--gm-gradient-4) 0, transparent 50%);
    filter: blur(var(--gm-blur-mesh));
    opacity: 0.4;
    animation: gm-rotate 30s linear infinite;
  }
  .gm-noise-overlay {
    position: absolute; inset: 0;
    z-index: 2;
    opacity: 0.03;
  }
  .gm-card {
    background: var(--gm-bg-surface);
    backdrop-filter: blur(20px);
    border: 1px solid var(--gm-border);
    border-radius: var(--gm-radius);
    padding: 28px;
    transition: all var(--gm-transition);
    position: relative;
    overflow: hidden;
  }
  .gm-card:hover {
    border-color: var(--gm-border-hover);
    transform: translateY(-4px);
  }
  .gm-card::before {
    content: "";
    position: absolute; top: 0; left: 0; right: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--gm-gradient-1), var(--gm-gradient-2), var(--gm-gradient-3));
    opacity: 0;
    transition: opacity var(--gm-transition);
  }
  .gm-card:hover::before { opacity: 1; }
  .gm-gradient-text {
    background: linear-gradient(135deg, var(--gm-gradient-1), var(--gm-gradient-2), var(--gm-gradient-3));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
  .gm-btn {
    padding: 14px 32px;
    background: linear-gradient(135deg, var(--gm-gradient-2), var(--gm-gradient-1));
    border: none;
    border-radius: var(--gm-radius-full);
    color: #fff; font-weight: 700;
    cursor: pointer;
    transition: all var(--gm-transition);
    box-shadow: 0 4px 20px rgba(120, 115, 245, 0.3);
  }
  .gm-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(120, 115, 245, 0.4);
  }
  .gm-blob {
    border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%;
    animation: gm-morph 8s ease-in-out infinite;
  }
  .gm-wallet-btn {
    padding: 14px 32px;
    background: linear-gradient(135deg, var(--gm-gradient-1), var(--gm-gradient-2));
    border: none;
    border-radius: var(--gm-radius-full);
    color: #fff; font-weight: 700;
    cursor: pointer;
    box-shadow: 0 4px 20px rgba(255, 110, 199, 0.3);
    transition: all var(--gm-transition);
  }
  .gm-wallet-btn:hover {
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 8px 30px rgba(255, 110, 199, 0.4);
  }
}
```

## Component Patterns

```tsx
export function MeshHero() {
  return (
    <section className="relative min-h-screen bg-gm-bg flex items-center justify-center overflow-hidden">
      {/* Mesh gradient background */}
      <div className="absolute inset-[-50%] bg-[radial-gradient(at_0%_0%,#ff6ec7_0,transparent_50%),radial-gradient(at_100%_0%,#7873f5_0,transparent_50%),radial-gradient(at_100%_100%,#4ff5c5_0,transparent_50%),radial-gradient(at_0%_100%,#ffcb57_0,transparent_50%)] blur-[100px] opacity-40 animate-gm-rotate" />
      {/* SVG noise */}
      <svg className="absolute inset-0 z-[2] opacity-[0.03] w-full h-full">
        <filter id="meshNoise"><feTurbulence baseFrequency="0.8" numOctaves="4" stitchTiles="stitch" /></filter>
        <rect width="100%" height="100%" filter="url(#meshNoise)" />
      </svg>
      <div className="relative z-10 text-center px-6">
        <h1 className="font-gm-display text-gm-hero font-bold leading-[1.05]">
          <span className="bg-gradient-to-r from-gm-gradient-1 via-gm-gradient-2 to-gm-gradient-3 bg-clip-text text-transparent">
            Living Colors
          </span>
        </h1>
        <p className="font-gm-body text-gm-text-secondary text-lg mt-6 max-w-md mx-auto">
          Dynamic gradient meshes that breathe life into decentralized finance.
        </p>
        <button className="mt-10 px-8 py-3.5 bg-gradient-to-r from-gm-gradient-1 to-gm-gradient-2 rounded-full text-white font-gm-display font-bold shadow-[0_4px_20px_rgba(255,110,199,0.3)] hover:-translate-y-0.5 hover:scale-[1.02] hover:shadow-[0_8px_30px_rgba(255,110,199,0.4)] transition-all">
          Connect Wallet
        </button>
      </div>
    </section>
  );
}

export function MeshCard({ title, description }: { title: string; description: string }) {
  return (
    <div className="bg-gm-bg-surface backdrop-blur-[20px] border border-gm-border rounded-gm p-7 relative overflow-hidden hover:border-gm-border-hover hover:-translate-y-1 transition-all group">
      <div className="absolute top-0 left-0 right-0 h-0.5 bg-gradient-to-r from-gm-gradient-1 via-gm-gradient-2 to-gm-gradient-3 opacity-0 group-hover:opacity-100 transition-opacity" />
      <h3 className="font-gm-display text-xl font-bold text-gm-text-primary">{title}</h3>
      <p className="font-gm-body text-sm text-gm-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function MeshButton({ children }: { children: React.ReactNode }) {
  return (
    <button className="px-7 py-3 bg-gradient-to-r from-gm-gradient-2 to-gm-gradient-1 rounded-full text-white font-gm-display font-bold shadow-[0_4px_20px_rgba(120,115,245,0.3)] hover:-translate-y-0.5 hover:shadow-[0_8px_30px_rgba(120,115,245,0.4)] transition-all">
      {children}
    </button>
  );
}
```
