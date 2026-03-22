# Dark Neon (Web3 / Cyberpunk)

## CSS Variables

```css
:root {
  --neon-bg: #000000;
  --neon-bg-surface: #0a0a0a;
  --neon-bg-card: #0d0d0d;
  --neon-border: #1a1a1a;
  --neon-border-glow: #222222;
  --neon-text-primary: #ffffff;
  --neon-text-secondary: #888888;
  --neon-text-dim: #555555;
  --neon-green: #00ff88;
  --neon-pink: #ff00ff;
  --neon-blue: #00d4ff;
  --neon-purple: #b400ff;
  --neon-yellow: #ffee00;
  --neon-glow-green: 0 0 10px #00ff88, 0 0 40px rgba(0, 255, 136, 0.3), 0 0 80px rgba(0, 255, 136, 0.1);
  --neon-glow-pink: 0 0 10px #ff00ff, 0 0 40px rgba(255, 0, 255, 0.3), 0 0 80px rgba(255, 0, 255, 0.1);
  --neon-glow-blue: 0 0 10px #00d4ff, 0 0 40px rgba(0, 212, 255, 0.3), 0 0 80px rgba(0, 212, 255, 0.1);
  --neon-font: 'Space Grotesk', 'Inter', system-ui, sans-serif;
  --neon-font-mono: 'JetBrains Mono', 'Fira Code', monospace;
  --neon-radius: 8px;
  --neon-radius-lg: 16px;
  --neon-transition: 0.3s ease;
  --neon-transition-glow: 0.5s ease;
  --neon-spacing-xs: 0.5rem;
  --neon-spacing-sm: 1rem;
  --neon-spacing-md: 1.5rem;
  --neon-spacing-lg: 2.5rem;
  --neon-spacing-xl: 4rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        neon: {
          bg: "#000000", surface: "#0a0a0a", card: "#0d0d0d",
          border: { DEFAULT: "#1a1a1a", glow: "#222222" },
          text: { primary: "#ffffff", secondary: "#888888", dim: "#555555" },
          green: "#00ff88", pink: "#ff00ff", blue: "#00d4ff", purple: "#b400ff", yellow: "#ffee00",
        },
      },
      fontFamily: {
        neon: ["Space Grotesk", "Inter", "system-ui", "sans-serif"],
        "neon-mono": ["JetBrains Mono", "Fira Code", "monospace"],
      },
      boxShadow: {
        "neon-green": "0 0 10px #00ff88, 0 0 40px rgba(0,255,136,0.3), 0 0 80px rgba(0,255,136,0.1)",
        "neon-pink": "0 0 10px #ff00ff, 0 0 40px rgba(255,0,255,0.3), 0 0 80px rgba(255,0,255,0.1)",
        "neon-blue": "0 0 10px #00d4ff, 0 0 40px rgba(0,212,255,0.3), 0 0 80px rgba(0,212,255,0.1)",
        "neon-subtle": "0 0 20px rgba(0,255,136,0.08)",
        "neon-card": "0 0 0 1px #1a1a1a, 0 4px 30px rgba(0,0,0,0.8)",
      },
      backgroundImage: {
        "neon-gradient": "linear-gradient(135deg, #00ff88, #00d4ff)",
        "neon-gradient-pink": "linear-gradient(135deg, #ff00ff, #b400ff)",
        "neon-grid": "linear-gradient(rgba(0,255,136,0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(0,255,136,0.03) 1px, transparent 1px)",
      },
      backgroundSize: { "neon-grid": "60px 60px" },
      keyframes: {
        "neon-flicker": { "0%, 100%": { opacity: "1" }, "50%": { opacity: "0.8" }, "52%": { opacity: "1" }, "54%": { opacity: "0.9" } },
        "neon-pulse": { "0%, 100%": { boxShadow: "0 0 10px #00ff88, 0 0 40px rgba(0,255,136,0.3)" }, "50%": { boxShadow: "0 0 20px #00ff88, 0 0 60px rgba(0,255,136,0.5)" } },
        "scan-line": { "0%": { transform: "translateY(-100%)" }, "100%": { transform: "translateY(100vh)" } },
      },
      animation: {
        "neon-flicker": "neon-flicker 3s ease-in-out infinite",
        "neon-pulse": "neon-pulse 2s ease-in-out infinite",
        "scan-line": "scan-line 8s linear infinite",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .neon-card {
    background: var(--neon-bg-card);
    border: 1px solid var(--neon-border);
    border-radius: var(--neon-radius-lg);
    padding: 24px;
    position: relative;
    overflow: hidden;
    transition: border-color var(--neon-transition), box-shadow var(--neon-transition-glow);
  }
  .neon-card:hover {
    border-color: var(--neon-green);
    box-shadow: 0 0 20px rgba(0, 255, 136, 0.08), inset 0 0 20px rgba(0, 255, 136, 0.03);
  }
  .neon-card::before {
    content: "";
    position: absolute; top: 0; left: 0; right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, var(--neon-green), transparent);
    opacity: 0;
    transition: opacity var(--neon-transition-glow);
  }
  .neon-card:hover::before { opacity: 1; }
  .neon-text-glow {
    color: var(--neon-green);
    text-shadow: 0 0 10px rgba(0, 255, 136, 0.5), 0 0 40px rgba(0, 255, 136, 0.2);
  }
  .neon-btn {
    padding: 12px 28px;
    background: transparent;
    border: 1px solid var(--neon-green);
    border-radius: var(--neon-radius);
    color: var(--neon-green);
    font-family: var(--neon-font);
    font-size: 0.875rem; font-weight: 500;
    cursor: pointer;
    transition: all var(--neon-transition);
  }
  .neon-btn:hover {
    background: var(--neon-green);
    color: var(--neon-bg);
    box-shadow: var(--neon-glow-green);
  }
  .neon-wallet-btn {
    padding: 12px 28px;
    background: var(--neon-green);
    border: none;
    border-radius: var(--neon-radius);
    color: #000; font-weight: 700;
    font-family: var(--neon-font);
    cursor: pointer;
    box-shadow: var(--neon-glow-green);
    transition: all var(--neon-transition);
  }
  .neon-wallet-btn:hover {
    box-shadow: 0 0 15px #00ff88, 0 0 60px rgba(0,255,136,0.4), 0 0 100px rgba(0,255,136,0.15);
    transform: translateY(-1px);
  }
  .neon-grid-bg {
    background-image: linear-gradient(rgba(0,255,136,0.03) 1px, transparent 1px),
                       linear-gradient(90deg, rgba(0,255,136,0.03) 1px, transparent 1px);
    background-size: 60px 60px;
  }
  .neon-badge {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 4px 12px;
    background: rgba(0, 255, 136, 0.1);
    border: 1px solid rgba(0, 255, 136, 0.2);
    border-radius: 9999px;
    color: var(--neon-green);
    font-size: 0.75rem; font-weight: 500;
    font-family: var(--neon-font-mono);
  }
}
```

## Component Patterns

```tsx
export function NeonHero() {
  return (
    <section className="relative min-h-screen bg-neon-bg flex items-center justify-center overflow-hidden">
      {/* Grid background */}
      <div className="absolute inset-0 bg-[linear-gradient(rgba(0,255,136,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(0,255,136,0.03)_1px,transparent_1px)] bg-[size:60px_60px]" />
      {/* Glow orbs */}
      <div className="absolute top-1/4 left-1/4 w-[500px] h-[500px] bg-neon-green/5 rounded-full blur-[150px]" />
      <div className="absolute bottom-1/4 right-1/4 w-[400px] h-[400px] bg-neon-pink/5 rounded-full blur-[120px]" />
      <div className="relative z-10 text-center px-6">
        <div className="inline-flex items-center gap-2 px-4 py-1.5 bg-neon-green/10 border border-neon-green/20 rounded-full mb-8">
          <span className="w-2 h-2 rounded-full bg-neon-green animate-neon-pulse" />
          <span className="font-neon-mono text-xs text-neon-green">MAINNET LIVE</span>
        </div>
        <h1 className="font-neon text-7xl font-bold text-neon-text-primary tracking-tight">
          The Future is <span className="text-neon-green [text-shadow:0_0_10px_rgba(0,255,136,0.5),0_0_40px_rgba(0,255,136,0.2)]">Onchain</span>
        </h1>
        <p className="text-neon-text-secondary text-xl mt-6 max-w-lg mx-auto">
          Trade, stake, and build on the most advanced decentralized protocol.
        </p>
        <div className="flex items-center gap-4 justify-center mt-10">
          <button className="px-7 py-3 bg-neon-green rounded-lg text-black font-bold font-neon shadow-neon-green hover:shadow-[0_0_15px_#00ff88,0_0_60px_rgba(0,255,136,0.4)] hover:-translate-y-0.5 transition-all">
            Connect Wallet
          </button>
          <button className="px-7 py-3 bg-transparent border border-neon-border rounded-lg text-neon-text-primary font-neon font-medium hover:border-neon-green hover:text-neon-green transition-all">
            Learn More
          </button>
        </div>
      </div>
    </section>
  );
}

export function NeonCard({ title, stat, change, color = "green" }: { title: string; stat: string; change: string; color?: "green" | "pink" | "blue" }) {
  const glowColor = { green: "neon-green", pink: "neon-pink", blue: "neon-blue" }[color];
  const textColor = { green: "text-neon-green", pink: "text-neon-pink", blue: "text-neon-blue" }[color];
  return (
    <div className="bg-neon-card border border-neon-border rounded-2xl p-6 relative overflow-hidden group hover:border-neon-green/50 hover:shadow-[0_0_20px_rgba(0,255,136,0.08)] transition-all">
      <div className="absolute top-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-neon-green to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
      <p className="font-neon-mono text-xs text-neon-text-dim uppercase tracking-wider">{title}</p>
      <p className="font-neon text-3xl font-bold text-neon-text-primary mt-2">{stat}</p>
      <p className={`font-neon-mono text-sm mt-1 ${textColor}`}>{change}</p>
    </div>
  );
}

export function NeonButton({ children, variant = "outline" }: { children: React.ReactNode; variant?: "outline" | "solid" | "ghost" }) {
  const styles = {
    outline: "border border-neon-green text-neon-green hover:bg-neon-green hover:text-black hover:shadow-neon-green",
    solid: "bg-neon-green text-black font-bold shadow-neon-green hover:shadow-[0_0_15px_#00ff88,0_0_60px_rgba(0,255,136,0.4)]",
    ghost: "text-neon-text-secondary hover:text-neon-green",
  }[variant];
  return (
    <button className={`inline-flex items-center gap-2 px-6 py-3 rounded-lg font-neon text-sm font-medium transition-all hover:-translate-y-0.5 ${styles}`}>
      {children}
    </button>
  );
}
```
