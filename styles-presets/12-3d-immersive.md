# 3D Immersive

## CSS Variables

```css
:root {
  --3d-bg: #050510;
  --3d-bg-surface: rgba(10, 10, 30, 0.8);
  --3d-text-primary: #e8e8f0;
  --3d-text-secondary: #8888aa;
  --3d-text-accent: #7b68ee;
  --3d-accent: #7b68ee;
  --3d-accent-cyan: #00ced1;
  --3d-accent-hover: #9580ff;
  --3d-border: rgba(123, 104, 238, 0.2);
  --3d-border-hover: rgba(123, 104, 238, 0.5);
  --3d-font-display: 'Orbitron', 'Inter', sans-serif;
  --3d-font-body: 'Inter', system-ui, sans-serif;
  --3d-font-size-hero: clamp(2.5rem, 6vw, 5rem);
  --3d-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --3d-font-size-body: 1rem;
  --3d-radius: 16px;
  --3d-radius-sm: 8px;
  --3d-shadow: 0 0 40px rgba(123, 104, 238, 0.15);
  --3d-shadow-hover: 0 0 60px rgba(123, 104, 238, 0.25);
  --3d-glow: 0 0 20px rgba(123, 104, 238, 0.3);
  --3d-transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  --3d-spacing-xs: 0.5rem;
  --3d-spacing-sm: 1rem;
  --3d-spacing-md: 2rem;
  --3d-spacing-lg: 3rem;
  --3d-spacing-xl: 5rem;
  --3d-canvas-z: 1;
  --3d-ui-z: 10;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        "td": {
          bg: { DEFAULT: "#050510", surface: "rgba(10,10,30,0.8)" },
          text: { primary: "#e8e8f0", secondary: "#8888aa", accent: "#7b68ee" },
          accent: { DEFAULT: "#7b68ee", cyan: "#00ced1", hover: "#9580ff" },
          border: { DEFAULT: "rgba(123,104,238,0.2)", hover: "rgba(123,104,238,0.5)" },
        },
      },
      fontFamily: {
        "td-display": ["Orbitron", "Inter", "sans-serif"],
        "td-body": ["Inter", "system-ui", "sans-serif"],
      },
      fontSize: { "td-hero": "clamp(2.5rem, 6vw, 5rem)", "td-heading": "clamp(1.5rem, 3vw, 2.5rem)" },
      boxShadow: {
        "td": "0 0 40px rgba(123,104,238,0.15)",
        "td-hover": "0 0 60px rgba(123,104,238,0.25)",
        "td-glow": "0 0 20px rgba(123,104,238,0.3)",
      },
      keyframes: {
        "td-float": { "0%, 100%": { transform: "translateY(0) rotateX(0)" }, "50%": { transform: "translateY(-15px) rotateX(2deg)" } },
        "td-rotate": { "0%": { transform: "rotateY(0)" }, "100%": { transform: "rotateY(360deg)" } },
        "td-pulse-glow": { "0%, 100%": { boxShadow: "0 0 20px rgba(123,104,238,0.2)" }, "50%": { boxShadow: "0 0 40px rgba(123,104,238,0.4)" } },
      },
      animation: {
        "td-float": "td-float 6s ease-in-out infinite",
        "td-rotate": "td-rotate 20s linear infinite",
        "td-pulse-glow": "td-pulse-glow 3s ease-in-out infinite",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .td-canvas-container {
    position: fixed;
    inset: 0;
    z-index: var(--3d-canvas-z);
  }
  .td-overlay-ui {
    position: relative;
    z-index: var(--3d-ui-z);
    pointer-events: none;
  }
  .td-overlay-ui > * { pointer-events: auto; }
  .td-panel {
    background: var(--3d-bg-surface);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid var(--3d-border);
    border-radius: var(--3d-radius);
    padding: 24px;
    box-shadow: var(--3d-shadow);
    transition: all var(--3d-transition);
  }
  .td-panel:hover {
    border-color: var(--3d-border-hover);
    box-shadow: var(--3d-shadow-hover);
  }
  .td-heading {
    font-family: var(--3d-font-display);
    font-size: var(--3d-font-size-hero);
    font-weight: 700;
    color: var(--3d-text-primary);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }
  .td-btn {
    padding: 12px 28px;
    background: var(--3d-accent);
    border: none;
    border-radius: var(--3d-radius-sm);
    color: #fff; font-weight: 600;
    font-family: var(--3d-font-display);
    font-size: 0.8rem;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    cursor: pointer;
    box-shadow: var(--3d-glow);
    transition: all var(--3d-transition);
  }
  .td-btn:hover { background: var(--3d-accent-hover); box-shadow: var(--3d-shadow-hover); transform: translateY(-2px); }
  .td-wallet-btn {
    padding: 14px 32px;
    background: linear-gradient(135deg, var(--3d-accent), var(--3d-accent-cyan));
    border: none;
    border-radius: var(--3d-radius-sm);
    color: #fff; font-weight: 700;
    font-family: var(--3d-font-display);
    font-size: 0.8rem;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    cursor: pointer;
    box-shadow: 0 0 30px rgba(123, 104, 238, 0.4);
    transition: all var(--3d-transition);
  }
  .td-wallet-btn:hover {
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 0 50px rgba(123, 104, 238, 0.5);
  }
  .td-badge {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 6px 14px;
    background: rgba(123, 104, 238, 0.1);
    border: 1px solid var(--3d-border);
    border-radius: 9999px;
    color: var(--3d-accent);
    font-family: var(--3d-font-display);
    font-size: 0.7rem;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }
}
```

## Component Patterns

```tsx
// R3F Scene + Overlay UI
export function ImmersiveHero() {
  return (
    <section className="relative min-h-screen bg-td-bg overflow-hidden">
      {/* Three.js Canvas */}
      <div className="fixed inset-0 z-[1]">
        {/* <Canvas camera={{ position: [0, 0, 5], fov: 60 }}>
          <ambientLight intensity={0.5} />
          <pointLight position={[10, 10, 10]} color="#7b68ee" intensity={1} />
          <mesh rotation={[0.5, 0.5, 0]}>
            <torusKnotGeometry args={[1, 0.3, 128, 32]} />
            <meshStandardMaterial color="#7b68ee" wireframe />
          </mesh>
          <OrbitControls enableZoom={false} autoRotate autoRotateSpeed={0.5} />
        </Canvas> */}
      </div>
      {/* UI Overlay */}
      <div className="relative z-10 min-h-screen flex items-center justify-center px-6 pointer-events-none">
        <div className="text-center pointer-events-auto">
          <div className="inline-flex items-center gap-2 px-4 py-1.5 bg-td-accent/10 border border-td-border rounded-full mb-6">
            <span className="w-2 h-2 rounded-full bg-td-accent animate-td-pulse-glow" />
            <span className="font-td-display text-[0.7rem] text-td-accent uppercase tracking-widest">3D Experience</span>
          </div>
          <h1 className="font-td-display text-td-hero font-bold text-td-text-primary uppercase tracking-wider leading-[1.1]">
            Enter the <span className="text-td-text-accent">Metaverse</span>
          </h1>
          <p className="font-td-body text-td-text-secondary text-lg mt-6 max-w-md mx-auto">
            Immersive 3D DeFi experience. Move your mouse to explore.
          </p>
          <button className="mt-10 px-8 py-3.5 bg-gradient-to-r from-td-accent to-td-accent-cyan rounded-lg text-white font-td-display text-xs font-bold uppercase tracking-widest shadow-[0_0_30px_rgba(123,104,238,0.4)] hover:-translate-y-0.5 hover:scale-[1.02] hover:shadow-[0_0_50px_rgba(123,104,238,0.5)] transition-all">
            Connect Wallet
          </button>
        </div>
      </div>
    </section>
  );
}

export function ImmersiveCard({ title, description, icon }: { title: string; description: string; icon: string }) {
  return (
    <div className="bg-td-bg-surface backdrop-blur-[20px] border border-td-border rounded-2xl p-6 shadow-td hover:border-td-border-hover hover:shadow-td-hover transition-all group animate-td-float">
      <div className="w-12 h-12 rounded-xl bg-td-accent/10 border border-td-border flex items-center justify-center text-xl group-hover:shadow-td-glow transition-shadow">
        {icon}
      </div>
      <h3 className="font-td-display text-lg font-bold text-td-text-primary uppercase tracking-wide mt-4">{title}</h3>
      <p className="font-td-body text-sm text-td-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function ImmersiveButton({ children }: { children: React.ReactNode }) {
  return (
    <button className="px-7 py-3 bg-td-accent rounded-lg text-white font-td-display text-xs font-bold uppercase tracking-widest shadow-td-glow hover:bg-td-accent-hover hover:shadow-td-hover hover:-translate-y-0.5 transition-all">
      {children}
    </button>
  );
}
```
