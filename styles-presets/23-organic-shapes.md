# Organic Shapes

## CSS Variables

```css
:root {
  --org-bg: #f9f5f0;
  --org-bg-surface: #ffffff;
  --org-bg-muted: #f0ede6;
  --org-text-primary: #2d3436;
  --org-text-secondary: #636e72;
  --org-text-tertiary: #b2bec3;
  --org-accent: #e17055;
  --org-accent-hover: #d35d43;
  --org-accent-green: #00b894;
  --org-accent-purple: #a29bfe;
  --org-border: #dfe6e9;
  --org-color-pastel-mint: #a8e6cf;
  --org-color-pastel-lime: #dcedc1;
  --org-color-pastel-peach: #ffd3b6;
  --org-color-pastel-coral: #ffaaa5;
  --org-color-pastel-lavender: #c3aed6;
  --org-color-pastel-sky: #a0d2db;
  --org-font-display: 'Quicksand', 'Nunito', sans-serif;
  --org-font-body: 'Nunito Sans', 'Inter', sans-serif;
  --org-font-size-hero: clamp(2.5rem, 5vw, 4.5rem);
  --org-font-size-heading: clamp(1.25rem, 2.5vw, 2rem);
  --org-font-size-body: 1.0625rem;
  --org-blob-radius-1: 30% 70% 70% 30% / 30% 30% 70% 70%;
  --org-blob-radius-2: 60% 40% 30% 70% / 50% 60% 40% 50%;
  --org-blob-radius-3: 40% 60% 50% 50% / 70% 30% 60% 40%;
  --org-blob-radius-4: 50% 50% 40% 60% / 40% 60% 50% 50%;
  --org-blob-radius-card: 24px 60px 24px 60px;
  --org-blob-radius-btn: 50px;
  --org-radius: 20px;
  --org-radius-lg: 32px;
  --org-shadow-soft: 0 8px 30px rgba(0, 0, 0, 0.06);
  --org-shadow-hover: 0 12px 40px rgba(0, 0, 0, 0.1);
  --org-transition: 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
  --org-spacing-xs: 0.5rem;
  --org-spacing-sm: 1rem;
  --org-spacing-md: 1.5rem;
  --org-spacing-lg: 2.5rem;
  --org-spacing-xl: 4rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        org: {
          bg: { DEFAULT: "#f9f5f0", surface: "#ffffff", muted: "#f0ede6" },
          text: { primary: "#2d3436", secondary: "#636e72", tertiary: "#b2bec3" },
          accent: { DEFAULT: "#e17055", hover: "#d35d43", green: "#00b894", purple: "#a29bfe" },
          border: "#dfe6e9",
          pastel: {
            mint: "#a8e6cf", lime: "#dcedc1", peach: "#ffd3b6",
            coral: "#ffaaa5", lavender: "#c3aed6", sky: "#a0d2db",
          },
        },
      },
      fontFamily: {
        "org-display": ["Quicksand", "Nunito", "sans-serif"],
        "org-body": ["Nunito Sans", "Inter", "sans-serif"],
      },
      fontSize: {
        "org-hero": "clamp(2.5rem, 5vw, 4.5rem)",
        "org-heading": "clamp(1.25rem, 2.5vw, 2rem)",
      },
      borderRadius: {
        "org-blob-1": "30% 70% 70% 30% / 30% 30% 70% 70%",
        "org-blob-2": "60% 40% 30% 70% / 50% 60% 40% 50%",
        "org-blob-3": "40% 60% 50% 50% / 70% 30% 60% 40%",
        "org-blob-4": "50% 50% 40% 60% / 40% 60% 50% 50%",
        "org-card": "24px 60px 24px 60px",
        "org-btn": "50px",
        "org": "20px",
        "org-lg": "32px",
      },
      boxShadow: {
        "org-soft": "0 8px 30px rgba(0,0,0,0.06)",
        "org-hover": "0 12px 40px rgba(0,0,0,0.1)",
      },
      keyframes: {
        "org-morph": {
          "0%": { borderRadius: "30% 70% 70% 30% / 30% 30% 70% 70%" },
          "25%": { borderRadius: "60% 40% 30% 70% / 50% 60% 40% 50%" },
          "50%": { borderRadius: "40% 60% 50% 50% / 70% 30% 60% 40%" },
          "75%": { borderRadius: "50% 50% 40% 60% / 40% 60% 50% 50%" },
          "100%": { borderRadius: "30% 70% 70% 30% / 30% 30% 70% 70%" },
        },
        "org-float": {
          "0%, 100%": { transform: "translateY(0) rotate(0deg)" },
          "33%": { transform: "translateY(-14px) rotate(2deg)" },
          "66%": { transform: "translateY(8px) rotate(-1deg)" },
        },
        "org-pulse": {
          "0%, 100%": { transform: "scale(1)", opacity: "0.5" },
          "50%": { transform: "scale(1.1)", opacity: "0.7" },
        },
        "org-fade-up": {
          "0%": { opacity: "0", transform: "translateY(24px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
      },
      animation: {
        "org-morph": "org-morph 8s ease-in-out infinite",
        "org-float": "org-float 6s ease-in-out infinite",
        "org-pulse": "org-pulse 4s ease-in-out infinite",
        "org-fade-up": "org-fade-up 0.6s ease forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .org-page {
    background: var(--org-bg);
    min-height: 100vh;
    position: relative;
    overflow: hidden;
  }

  /* ── Animated blob background ── */
  .org-blob {
    position: absolute;
    border-radius: var(--org-blob-radius-1);
    filter: blur(60px);
    opacity: 0.5;
    animation: org-morph 8s ease-in-out infinite, org-float 6s ease-in-out infinite;
    z-index: 0;
    pointer-events: none;
  }
  .org-blob--mint { background: var(--org-color-pastel-mint); }
  .org-blob--lime { background: var(--org-color-pastel-lime); }
  .org-blob--peach { background: var(--org-color-pastel-peach); }
  .org-blob--coral { background: var(--org-color-pastel-coral); }
  .org-blob--lavender { background: var(--org-color-pastel-lavender); }
  .org-blob--sky { background: var(--org-color-pastel-sky); }

  /* SVG blob background container */
  .org-svg-blob {
    position: absolute;
    z-index: 0;
    pointer-events: none;
    animation: org-morph 10s ease-in-out infinite;
  }

  /* ── Card with organic shape ── */
  .org-card {
    background: var(--org-bg-surface);
    border-radius: var(--org-blob-radius-card);
    padding: 32px;
    box-shadow: var(--org-shadow-soft);
    transition: all var(--org-transition);
    position: relative;
    z-index: 1;
  }
  .org-card:hover {
    box-shadow: var(--org-shadow-hover);
    transform: translateY(-6px);
    border-radius: 60px 24px 60px 24px;
  }
  .org-card::before {
    content: "";
    position: absolute;
    top: -20px; right: -20px;
    width: 80px; height: 80px;
    border-radius: var(--org-blob-radius-2);
    background: var(--org-color-pastel-mint);
    opacity: 0.15;
    animation: org-morph 8s ease-in-out infinite;
    pointer-events: none;
  }

  /* ── Typography ── */
  .org-heading {
    font-family: var(--org-font-display);
    font-size: var(--org-font-size-hero);
    font-weight: 700;
    color: var(--org-text-primary);
    line-height: 1.2;
  }
  .org-body {
    font-family: var(--org-font-body);
    font-size: var(--org-font-size-body);
    color: var(--org-text-secondary);
    line-height: 1.7;
  }

  /* ── Pill-shaped button ── */
  .org-btn {
    padding: 14px 36px;
    background: var(--org-accent);
    border: none;
    border-radius: var(--org-blob-radius-btn);
    color: #fff;
    font-family: var(--org-font-display);
    font-weight: 700;
    font-size: 0.9375rem;
    cursor: pointer;
    box-shadow: var(--org-shadow-soft);
    transition: all var(--org-transition);
  }
  .org-btn:hover {
    background: var(--org-accent-hover);
    box-shadow: var(--org-shadow-hover);
    transform: translateY(-3px) scale(1.02);
  }
  .org-btn--green { background: var(--org-accent-green); }
  .org-btn--green:hover { background: #00a382; }
  .org-btn--purple { background: var(--org-accent-purple); }
  .org-btn--purple:hover { background: #8b84e0; }
  .org-btn--outline {
    background: transparent;
    border: 2px solid var(--org-accent);
    color: var(--org-accent);
  }
  .org-btn--outline:hover {
    background: var(--org-accent);
    color: #fff;
  }

  /* ── Badge ── */
  .org-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 18px;
    background: var(--org-bg-muted);
    border-radius: var(--org-blob-radius-btn);
    font-family: var(--org-font-display);
    font-weight: 600;
    font-size: 0.8125rem;
    color: var(--org-accent-green);
  }

  /* ── Wallet connect button ── */
  .org-wallet-btn {
    padding: 14px 36px;
    background: linear-gradient(135deg, var(--org-color-pastel-mint), var(--org-accent-green));
    border: none;
    border-radius: var(--org-blob-radius-btn);
    color: #fff;
    font-family: var(--org-font-display);
    font-weight: 700;
    cursor: pointer;
    box-shadow: 0 4px 18px rgba(0, 184, 148, 0.25);
    transition: all var(--org-transition);
  }
  .org-wallet-btn:hover {
    transform: translateY(-3px) scale(1.02);
    box-shadow: 0 8px 28px rgba(0, 184, 148, 0.35);
  }

  /* ── Wavy SVG divider ── */
  .org-divider {
    width: 100%;
    height: 48px;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1200 48'%3E%3Cpath d='M0 24 Q150 0 300 24 T600 24 T900 24 T1200 24 V48 H0Z' fill='%23f9f5f0'/%3E%3C/svg%3E") no-repeat center;
    background-size: cover;
  }
}
```

## Component Patterns

```tsx
export function OrganicHero() {
  return (
    <section className="org-page min-h-screen flex items-center justify-center px-6 py-20">
      {/* Background blobs */}
      <div className="org-blob org-blob--mint w-[400px] h-[400px] top-[10%] left-[5%]" />
      <div className="org-blob org-blob--peach w-[350px] h-[350px] top-[20%] right-[10%] [animation-delay:-3s]" />
      <div className="org-blob org-blob--lavender w-[300px] h-[300px] bottom-[15%] left-[30%] [animation-delay:-5s]" />
      {/* SVG blob behind content */}
      <svg className="org-svg-blob w-[600px] h-[600px] -z-0 opacity-10" viewBox="0 0 200 200">
        <path fill="#a8e6cf" d="M44.7,-76.4C58.8,-69.2,71.8,-59.1,79.6,-45.8C87.4,-32.5,90,-16.3,88.5,-0.9C87,14.5,81.4,29,72.8,41.6C64.2,54.2,52.6,64.9,39.2,72.4C25.8,79.9,10.6,84.2,-3.6,89.4C-17.8,94.7,-35.6,90.9,-49.4,82.5C-63.2,74.1,-73,61.1,-79.6,46.5C-86.2,31.9,-89.6,15.9,-88.6,0.6C-87.5,-14.8,-82,-29.5,-73.4,-41.8C-64.8,-54.1,-53.1,-64,-40,-71.4C-26.9,-78.8,-13.5,-83.7,1.1,-85.6C15.7,-87.4,30.5,-83.6,44.7,-76.4Z" transform="translate(100 100)" />
      </svg>
      {/* Wave bottom */}
      <svg className="absolute bottom-0 left-0 w-full" viewBox="0 0 1440 200" preserveAspectRatio="none">
        <path fill="#f0ede6" d="M0,160 C360,260 720,60 1080,160 C1260,210 1380,180 1440,160 L1440,200 L0,200 Z" />
      </svg>

      {/* Content */}
      <div className="relative z-10 text-center max-w-2xl animate-org-fade-up">
        <div className="org-badge mb-6">
          <span className="w-2 h-2 rounded-full bg-org-accent-green" />
          Live on Mainnet
        </div>
        <h1 className="font-org-display text-org-hero font-bold text-org-text-primary leading-[1.2]">
          Naturally Fluid<br />Finance
        </h1>
        <p className="font-org-body text-org-text-secondary mt-5 text-lg leading-relaxed max-w-md mx-auto">
          Organic shapes meet decentralized protocols. Soft, approachable, and powerful.
        </p>
        <div className="flex items-center gap-4 justify-center mt-10">
          <button className="org-wallet-btn">Connect Wallet</button>
          <button className="org-btn org-btn--outline">Explore</button>
        </div>
      </div>
    </section>
  );
}

export function OrganicCard({ title, description, color = "mint" }: { title: string; description: string; color?: "mint" | "peach" | "coral" | "lavender" }) {
  const accents: Record<string, string> = {
    mint: "bg-org-pastel-mint/20 text-org-accent-green",
    peach: "bg-org-pastel-peach/30 text-org-accent",
    coral: "bg-org-pastel-coral/30 text-org-accent",
    lavender: "bg-org-pastel-lavender/30 text-org-accent-purple",
  };
  return (
    <div className="bg-org-surface rounded-org-card p-8 shadow-org-soft hover:shadow-org-hover hover:-translate-y-1.5 hover:rounded-[60px_24px_60px_24px] transition-all duration-400 animate-org-fade-up relative overflow-hidden">
      <div className="absolute -top-5 -right-5 w-20 h-20 rounded-org-blob-2 animate-org-morph opacity-[0.12]" style={{ background: `var(--org-color-pastel-${color})` }} />
      <div className={`inline-block rounded-org-btn px-4 py-1.5 text-xs font-bold ${accents[color]}`}>
        {color.charAt(0).toUpperCase() + color.slice(1)}
      </div>
      <h3 className="font-org-display text-org-heading font-bold text-org-text-primary mt-4">{title}</h3>
      <p className="font-org-body text-sm text-org-text-secondary mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function OrganicButton({ children, variant = "default" }: { children: React.ReactNode; variant?: "default" | "green" | "purple" | "outline" }) {
  const styles: Record<string, string> = {
    default: "bg-org-accent text-white hover:bg-org-accent-hover",
    green: "bg-org-accent-green text-white hover:bg-[#00a382]",
    purple: "bg-org-accent-purple text-white hover:bg-[#8b84e0]",
    outline: "bg-transparent border-2 border-org-accent text-org-accent hover:bg-org-accent hover:text-white",
  };
  return (
    <button className={`px-9 py-3.5 rounded-org-btn font-org-display font-bold shadow-org-soft hover:shadow-org-hover hover:-translate-y-0.5 hover:scale-[1.02] transition-all ${styles[variant]}`}>
      {children}
    </button>
  );
}

export function OrganicWalletButton() {
  return (
    <button className="org-wallet-btn flex items-center gap-2">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 12V7H5a2 2 0 010-4h14v4"/><path d="M3 5v14a2 2 0 002 2h16v-5"/><path d="M18 12a1 1 0 100 4 1 1 0 000-4z"/></svg>
      Connect Wallet
    </button>
  );
}
```
