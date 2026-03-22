# Kinetic Typography

## CSS Variables

```css
:root {
  --kt-bg: #0a0a0a;
  --kt-bg-surface: #141414;
  --kt-bg-elevated: #1e1e1e;
  --kt-text-primary: #ffffff;
  --kt-text-secondary: #888888;
  --kt-text-dim: #444444;
  --kt-accent: #ff2d2d;
  --kt-accent-hover: #ff5555;
  --kt-accent-alt: #00e5ff;
  --kt-border: #2a2a2a;
  --kt-font-display: 'ClashDisplay', 'Space Grotesk', sans-serif;
  --kt-font-body: 'Inter', system-ui, sans-serif;
  --kt-font-mono: 'JetBrains Mono', monospace;
  --kt-font-size-mega: clamp(5rem, 18vw, 18rem);
  --kt-font-size-hero: clamp(4rem, 12vw, 12rem);
  --kt-font-size-display: clamp(2.5rem, 8vw, 6rem);
  --kt-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --kt-font-size-body: 1rem;
  --kt-font-weight-black: 900;
  --kt-letter-spacing-tight: -0.06em;
  --kt-letter-spacing-wide: 0.15em;
  --kt-line-height-display: 0.88;
  --kt-text-stroke-width: 2px;
  --kt-text-stroke-color: #ffffff;
  --kt-radius: 8px;
  --kt-transition: 0.35s cubic-bezier(0.22, 1, 0.36, 1);
  --kt-animation-stagger: 0.04s;
  --kt-animation-duration: 0.7s;
  --kt-animation-easing: cubic-bezier(0.16, 1, 0.3, 1);
  --kt-spacing-xs: 0.5rem;
  --kt-spacing-sm: 1rem;
  --kt-spacing-md: 2rem;
  --kt-spacing-lg: 3rem;
  --kt-spacing-xl: 5rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        kt: {
          bg: { DEFAULT: "#0a0a0a", surface: "#141414", elevated: "#1e1e1e" },
          text: { primary: "#ffffff", secondary: "#888888", dim: "#444444" },
          accent: { DEFAULT: "#ff2d2d", hover: "#ff5555", alt: "#00e5ff" },
          border: "#2a2a2a",
        },
      },
      fontFamily: {
        "kt-display": ["ClashDisplay", "Space Grotesk", "sans-serif"],
        "kt-body": ["Inter", "system-ui", "sans-serif"],
        "kt-mono": ["JetBrains Mono", "monospace"],
      },
      fontSize: {
        "kt-mega": "clamp(5rem, 18vw, 18rem)",
        "kt-hero": "clamp(4rem, 12vw, 12rem)",
        "kt-display": "clamp(2.5rem, 8vw, 6rem)",
        "kt-heading": "clamp(1.5rem, 3vw, 2.5rem)",
      },
      letterSpacing: {
        "kt-tight": "-0.06em",
        "kt-wide": "0.15em",
      },
      lineHeight: { "kt-display": "0.88" },
      keyframes: {
        "kt-char-up": {
          "0%": { transform: "translateY(120%) rotateX(25deg)", opacity: "0" },
          "100%": { transform: "translateY(0) rotateX(0)", opacity: "1" },
        },
        "kt-char-rotate": {
          "0%": { transform: "rotateX(90deg) scale(0.8)", opacity: "0" },
          "100%": { transform: "rotateX(0) scale(1)", opacity: "1" },
        },
        "kt-word-slide": {
          "0%": { transform: "translateX(-110%)", opacity: "0" },
          "60%": { opacity: "1" },
          "100%": { transform: "translateX(0)", opacity: "1" },
        },
        "kt-bounce-in": {
          "0%": { transform: "translateY(-200%) scaleY(1.4)", opacity: "0" },
          "60%": { transform: "translateY(15%) scaleY(0.9)", opacity: "1" },
          "80%": { transform: "translateY(-5%) scaleY(1.05)" },
          "100%": { transform: "translateY(0) scaleY(1)" },
        },
        "kt-wave": {
          "0%, 100%": { transform: "translateY(0)" },
          "25%": { transform: "translateY(-18px) rotate(-3deg)" },
          "75%": { transform: "translateY(8px) rotate(1deg)" },
        },
        "kt-shake": {
          "0%, 100%": { transform: "translateX(0)" },
          "10%, 30%, 50%, 70%, 90%": { transform: "translateX(-2px) rotate(-0.5deg)" },
          "20%, 40%, 60%, 80%": { transform: "translateX(2px) rotate(0.5deg)" },
        },
        "kt-typewriter": { "0%": { width: "0" }, "100%": { width: "100%" } },
        "kt-blink": { "0%, 100%": { opacity: "1" }, "50%": { opacity: "0" } },
      },
      animation: {
        "kt-char-up": "kt-char-up 0.7s cubic-bezier(0.16,1,0.3,1) forwards",
        "kt-char-rotate": "kt-char-rotate 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
        "kt-word-slide": "kt-word-slide 0.7s cubic-bezier(0.16,1,0.3,1) forwards",
        "kt-bounce-in": "kt-bounce-in 0.8s cubic-bezier(0.34,1.56,0.64,1) forwards",
        "kt-wave": "kt-wave 2s ease-in-out infinite",
        "kt-shake": "kt-shake 0.6s ease-in-out",
        "kt-typewriter": "kt-typewriter 2s steps(20) forwards",
        "kt-blink": "kt-blink 1s step-end infinite",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  /* Split character wrapper */
  .kt-split-char {
    display: inline-block;
    overflow: hidden;
    perspective: 600px;
  }
  .kt-split-char span {
    display: inline-block;
    transform: translateY(120%) rotateX(25deg);
    opacity: 0;
    animation: kt-char-up var(--kt-animation-duration) var(--kt-animation-easing) forwards;
  }

  /* Display text — the star of kinetic typography */
  .kt-display-text {
    font-family: var(--kt-font-display);
    font-size: var(--kt-font-size-hero);
    font-weight: var(--kt-font-weight-black);
    letter-spacing: var(--kt-letter-spacing-tight);
    line-height: var(--kt-line-height-display);
    color: var(--kt-text-primary);
    text-transform: uppercase;
  }

  /* Outline / stroke text */
  .kt-outline-text {
    -webkit-text-stroke: var(--kt-text-stroke-width) var(--kt-text-stroke-color);
    color: transparent;
    transition: color var(--kt-transition), -webkit-text-stroke-color var(--kt-transition);
  }
  .kt-outline-text:hover {
    color: var(--kt-accent);
    -webkit-text-stroke-color: var(--kt-accent);
  }

  /* Mega text — viewport-filling display */
  .kt-mega-text {
    font-family: var(--kt-font-display);
    font-size: var(--kt-font-size-mega);
    font-weight: var(--kt-font-weight-black);
    letter-spacing: var(--kt-letter-spacing-tight);
    line-height: 0.82;
    color: var(--kt-text-primary);
    text-transform: uppercase;
    white-space: nowrap;
  }

  /* Typewriter cursor effect */
  .kt-typewriter {
    overflow: hidden;
    white-space: nowrap;
    border-right: 3px solid var(--kt-accent);
    animation: kt-typewriter 2s steps(20) forwards, kt-blink 1s step-end infinite;
  }

  /* Marquee continuous scroll */
  .kt-marquee-line { overflow: hidden; white-space: nowrap; }
  .kt-marquee-content {
    display: inline-block;
    animation: marquee 18s linear infinite;
  }

  /* GSAP SplitText config reference (apply via JS) */
  .kt-gsap-config {
    /* data-split-type="chars,words" */
    /* data-stagger="0.04" */
    /* data-duration="0.7" */
    /* data-ease="expo.out" */
    /* data-from='{"y":"120%","rotationX":25,"opacity":0}' */
    /* data-to='{"y":"0%","rotationX":0,"opacity":1}' */
  }

  /* Button */
  .kt-btn {
    padding: 14px 36px;
    background: var(--kt-accent);
    border: none;
    border-radius: var(--kt-radius);
    color: #fff;
    font-weight: 700;
    font-family: var(--kt-font-display);
    text-transform: uppercase;
    letter-spacing: 0.08em;
    cursor: pointer;
    transition: all var(--kt-transition);
  }
  .kt-btn:hover {
    background: var(--kt-accent-hover);
    transform: scale(1.04);
  }

  /* Card */
  .kt-card {
    background: var(--kt-bg-surface);
    border: 1px solid var(--kt-border);
    border-radius: var(--kt-radius);
    padding: 28px;
    transition: border-color var(--kt-transition);
  }
  .kt-card:hover { border-color: var(--kt-accent); }

  /* Wallet Connect Button */
  .kt-wallet-btn {
    padding: 14px 36px;
    background: var(--kt-accent);
    border: none;
    border-radius: var(--kt-radius);
    color: #fff;
    font-weight: 700;
    font-family: var(--kt-font-display);
    text-transform: uppercase;
    letter-spacing: 0.08em;
    cursor: pointer;
    transition: all var(--kt-transition);
    position: relative;
    overflow: hidden;
  }
  .kt-wallet-btn::after {
    content: "";
    position: absolute;
    inset: 0;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.15), transparent);
    transform: translateX(-100%);
    transition: transform 0.5s;
  }
  .kt-wallet-btn:hover { background: var(--kt-accent-hover); transform: scale(1.04); }
  .kt-wallet-btn:hover::after { transform: translateX(100%); }
}
```

## Component Patterns

```tsx
"use client";

/* ── GSAP SplitText config (install: gsap + SplitText plugin) ──
import { gsap } from "gsap";
import { SplitText } from "gsap/SplitText";
gsap.registerPlugin(SplitText);

function animateText(el: HTMLElement) {
  const split = new SplitText(el, { type: "chars,words" });
  gsap.from(split.chars, {
    y: "120%", rotationX: 25, opacity: 0,
    stagger: 0.04, duration: 0.7, ease: "expo.out",
  });
}
── */

function SplitText({ text, className = "", delay = 0 }: { text: string; className?: string; delay?: number }) {
  return (
    <span className={className}>
      {text.split("").map((char, i) => (
        <span key={i} className="inline-block overflow-hidden" style={{ perspective: "600px" }}>
          <span
            className="inline-block animate-kt-char-up"
            style={{ animationDelay: `${delay + i * 0.04}s` }}
          >
            {char === " " ? "\u00A0" : char}
          </span>
        </span>
      ))}
    </span>
  );
}

function BounceSplitText({ text, className = "", delay = 0 }: { text: string; className?: string; delay?: number }) {
  return (
    <span className={className}>
      {text.split("").map((char, i) => (
        <span key={i} className="inline-block overflow-hidden">
          <span
            className="inline-block animate-kt-bounce-in"
            style={{ animationDelay: `${delay + i * 0.05}s` }}
          >
            {char === " " ? "\u00A0" : char}
          </span>
        </span>
      ))}
    </span>
  );
}

export function KineticHero() {
  return (
    <section className="min-h-screen bg-kt-bg flex flex-col justify-center px-6 overflow-hidden">
      {/* Line 1: slide-up characters */}
      <div className="overflow-hidden">
        <h1 className="font-kt-display text-kt-hero font-black uppercase tracking-kt-tight leading-kt-display text-kt-text-primary">
          <SplitText text="MOVE" />
        </h1>
      </div>
      {/* Line 2: outlined stroke text */}
      <div className="overflow-hidden">
        <h1 className="font-kt-display text-kt-hero font-black uppercase tracking-kt-tight leading-kt-display [-webkit-text-stroke:2px_#fff] text-transparent hover:text-kt-accent hover:[-webkit-text-stroke-color:#ff2d2d] transition-all">
          <SplitText text="YOUR" delay={0.3} />
        </h1>
      </div>
      {/* Line 3: accent color bounce */}
      <div className="overflow-hidden">
        <h1 className="font-kt-display text-kt-hero font-black uppercase tracking-kt-tight leading-kt-display text-kt-accent">
          <BounceSplitText text="ASSETS" delay={0.6} />
        </h1>
      </div>
      {/* CTA row */}
      <div className="mt-12 flex items-center gap-6 flex-wrap">
        <button className="kt-wallet-btn">Connect Wallet</button>
        <p className="font-kt-mono text-kt-text-secondary text-sm overflow-hidden whitespace-nowrap border-r-[3px] border-kt-accent animate-kt-typewriter">
          Decentralized exchange protocol
        </p>
      </div>
    </section>
  );
}

export function KineticCard({ title, description, index }: { title: string; description: string; index: number }) {
  return (
    <div className="bg-kt-bg-surface border border-kt-border rounded-lg p-7 hover:border-kt-accent transition-colors group">
      <span className="font-kt-mono text-xs text-kt-text-dim tracking-kt-wide">0{index + 1}</span>
      <h3 className="font-kt-display text-kt-heading font-black uppercase tracking-kt-tight text-kt-text-primary mt-2 group-hover:text-kt-accent transition-colors">
        <SplitText text={title} delay={index * 0.15} />
      </h3>
      <p className="font-kt-body text-sm text-kt-text-secondary mt-3 leading-relaxed">{description}</p>
    </div>
  );
}

export function KineticButton({ children, variant = "filled" }: { children: React.ReactNode; variant?: "filled" | "outline" }) {
  const base = "px-8 py-3.5 font-kt-display font-bold uppercase tracking-wider transition-all rounded-lg";
  const styles = variant === "outline"
    ? `${base} border-2 border-kt-text-primary text-kt-text-primary [-webkit-text-stroke:0.5px_#fff] hover:bg-kt-text-primary hover:text-kt-bg`
    : `${base} bg-kt-accent text-white hover:bg-kt-accent-hover hover:scale-[1.04]`;
  return <button className={styles}>{children}</button>;
}

export function KineticWalletButton() {
  return (
    <button className="kt-wallet-btn">
      <span className="relative z-10 flex items-center gap-2">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 12V7H5a2 2 0 010-4h14v4"/><path d="M3 5v14a2 2 0 002 2h16v-5"/><path d="M18 12a1 1 0 100 4 1 1 0 000-4z"/></svg>
        Connect Wallet
      </span>
    </button>
  );
}
```
