# Masked Image

## CSS Variables

```css
:root {
  --mi-bg: #0a0a0a;
  --mi-bg-surface: #131313;
  --mi-bg-elevated: #1c1c1c;
  --mi-text-primary: #ffffff;
  --mi-text-secondary: #8a8a8a;
  --mi-text-dim: #505050;
  --mi-accent: #e8c547;
  --mi-accent-hover: #f0d060;
  --mi-accent-alt: #ff6b6b;
  --mi-border: #222222;
  --mi-font-display: 'Unbounded', 'Space Grotesk', sans-serif;
  --mi-font-body: 'Inter', system-ui, sans-serif;
  --mi-font-mono: 'JetBrains Mono', monospace;
  --mi-font-size-mega: clamp(5rem, 20vw, 16rem);
  --mi-font-size-hero: clamp(3rem, 10vw, 10rem);
  --mi-font-size-display: clamp(2rem, 6vw, 5rem);
  --mi-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --mi-font-size-body: 1rem;
  --mi-letter-spacing: -0.04em;
  --mi-line-height: 0.9;
  --mi-radius: 12px;
  --mi-radius-sm: 8px;
  --mi-mask-gradient: linear-gradient(135deg, #e8c547, #ff6b6b, #a855f7, #3b82f6);
  --mi-text-gradient: linear-gradient(90deg, #e8c547 0%, #ff6b6b 50%, #a855f7 100%);
  --mi-clip-diamond: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%);
  --mi-clip-hexagon: polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%);
  --mi-clip-triangle: polygon(50% 0%, 0% 100%, 100% 100%);
  --mi-clip-cross: polygon(35% 0%, 65% 0%, 65% 35%, 100% 35%, 100% 65%, 65% 65%, 65% 100%, 35% 100%, 35% 65%, 0% 65%, 0% 35%, 35% 35%);
  --mi-clip-circle: circle(40% at 50% 50%);
  --mi-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
  --mi-shadow-accent: 0 8px 30px rgba(232, 197, 71, 0.2);
  --mi-transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  --mi-spacing-xs: 0.5rem;
  --mi-spacing-sm: 1rem;
  --mi-spacing-md: 2rem;
  --mi-spacing-lg: 3rem;
  --mi-spacing-xl: 5rem;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        mi: {
          bg: { DEFAULT: "#0a0a0a", surface: "#131313", elevated: "#1c1c1c" },
          text: { primary: "#ffffff", secondary: "#8a8a8a", dim: "#505050" },
          accent: { DEFAULT: "#e8c547", hover: "#f0d060", alt: "#ff6b6b" },
          border: "#222222",
        },
      },
      fontFamily: {
        "mi-display": ["Unbounded", "Space Grotesk", "sans-serif"],
        "mi-body": ["Inter", "system-ui", "sans-serif"],
        "mi-mono": ["JetBrains Mono", "monospace"],
      },
      fontSize: {
        "mi-mega": "clamp(5rem, 20vw, 16rem)",
        "mi-hero": "clamp(3rem, 10vw, 10rem)",
        "mi-display": "clamp(2rem, 6vw, 5rem)",
        "mi-heading": "clamp(1.5rem, 3vw, 2.5rem)",
      },
      letterSpacing: { "mi-tight": "-0.04em" },
      lineHeight: { "mi-display": "0.9" },
      backgroundImage: {
        "mi-gradient": "linear-gradient(135deg, #e8c547, #ff6b6b, #a855f7, #3b82f6)",
        "mi-text-gradient": "linear-gradient(90deg, #e8c547 0%, #ff6b6b 50%, #a855f7 100%)",
      },
      keyframes: {
        "mi-reveal": {
          "0%": { clipPath: "inset(0 100% 0 0)" },
          "100%": { clipPath: "inset(0 0% 0 0)" },
        },
        "mi-clip-expand": {
          "0%": { clipPath: "circle(0% at 50% 50%)" },
          "100%": { clipPath: "circle(50% at 50% 50%)" },
        },
        "mi-gradient-shift": {
          "0%": { backgroundPosition: "0% 50%" },
          "50%": { backgroundPosition: "100% 50%" },
          "100%": { backgroundPosition: "0% 50%" },
        },
        "mi-mask-slide": {
          "0%": { backgroundPosition: "200% center" },
          "100%": { backgroundPosition: "0% center" },
        },
        "mi-fade-up": {
          "0%": { opacity: "0", transform: "translateY(30px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        "mi-scale-in": {
          "0%": { transform: "scale(0.8)", opacity: "0" },
          "100%": { transform: "scale(1)", opacity: "1" },
        },
      },
      animation: {
        "mi-reveal": "mi-reveal 1.2s cubic-bezier(0.16,1,0.3,1) forwards",
        "mi-clip-expand": "mi-clip-expand 1s cubic-bezier(0.16,1,0.3,1) forwards",
        "mi-gradient-shift": "mi-gradient-shift 4s ease infinite",
        "mi-mask-slide": "mi-mask-slide 3s ease infinite",
        "mi-fade-up": "mi-fade-up 0.8s cubic-bezier(0.16,1,0.3,1) forwards",
        "mi-scale-in": "mi-scale-in 0.6s cubic-bezier(0.16,1,0.3,1) forwards",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  /* ── Text mask: gradient / image shows through text ── */
  .mi-text-mask {
    background-clip: text;
    -webkit-background-clip: text;
    color: transparent;
    -webkit-text-fill-color: transparent;
    background-size: cover;
    background-position: center;
  }

  /* Animated gradient text mask */
  .mi-text-gradient {
    background: var(--mi-text-gradient);
    background-size: 200% 100%;
    background-clip: text;
    -webkit-background-clip: text;
    color: transparent;
    -webkit-text-fill-color: transparent;
    animation: mi-gradient-shift 4s ease infinite;
  }

  /* Image texture text mask */
  .mi-text-image {
    background-clip: text;
    -webkit-background-clip: text;
    color: transparent;
    -webkit-text-fill-color: transparent;
    background-size: cover;
    background-position: center;
  }

  /* ── Clip-path shapes ── */
  .mi-clip-diamond { clip-path: var(--mi-clip-diamond); transition: clip-path var(--mi-transition); }
  .mi-clip-diamond:hover { clip-path: polygon(50% -10%, 110% 50%, 50% 110%, -10% 50%); }
  .mi-clip-hexagon { clip-path: var(--mi-clip-hexagon); transition: clip-path var(--mi-transition); }
  .mi-clip-hexagon:hover { clip-path: polygon(20% -5%, 80% -5%, 105% 50%, 80% 105%, 20% 105%, -5% 50%); }
  .mi-clip-triangle { clip-path: var(--mi-clip-triangle); transition: clip-path var(--mi-transition); }
  .mi-clip-cross { clip-path: var(--mi-clip-cross); transition: clip-path var(--mi-transition); }
  .mi-clip-circle { clip-path: var(--mi-clip-circle); transition: clip-path var(--mi-transition); }
  .mi-clip-circle:hover { clip-path: circle(50% at 50% 50%); }

  /* Reveal animation (wipe from left) */
  .mi-clip-reveal {
    clip-path: inset(0 100% 0 0);
    animation: mi-reveal 1.2s cubic-bezier(0.16, 1, 0.3, 1) forwards;
  }

  /* ── SVG mask (organic blob shape) ── */
  .mi-svg-mask {
    mask-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath fill='%23000' d='M44.7,-76.4C58.8,-69.2,71.8,-59.1,79.6,-45.8C87.4,-32.5,90,-16.3,88.5,-0.9C87,14.5,81.4,29,72.8,41.6C64.2,54.2,52.6,64.9,39.2,72.4C25.8,79.9,10.6,84.2,-3.6,89.4C-17.8,94.7,-35.6,90.9,-49.4,82.5C-63.2,74.1,-73,61.1,-79.6,46.5C-86.2,31.9,-89.6,15.9,-88.6,0.6C-87.5,-14.8,-82,-29.5,-73.4,-41.8C-64.8,-54.1,-53.1,-64,-40,-71.4C-26.9,-78.8,-13.5,-83.7,1.1,-85.6C15.7,-87.4,30.5,-83.6,44.7,-76.4Z' transform='translate(100 100)' /%3E%3C/svg%3E");
    -webkit-mask-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath fill='%23000' d='M44.7,-76.4C58.8,-69.2,71.8,-59.1,79.6,-45.8C87.4,-32.5,90,-16.3,88.5,-0.9C87,14.5,81.4,29,72.8,41.6C64.2,54.2,52.6,64.9,39.2,72.4C25.8,79.9,10.6,84.2,-3.6,89.4C-17.8,94.7,-35.6,90.9,-49.4,82.5C-63.2,74.1,-73,61.1,-79.6,46.5C-86.2,31.9,-89.6,15.9,-88.6,0.6C-87.5,-14.8,-82,-29.5,-73.4,-41.8C-64.8,-54.1,-53.1,-64,-40,-71.4C-26.9,-78.8,-13.5,-83.7,1.1,-85.6C15.7,-87.4,30.5,-83.6,44.7,-76.4Z' transform='translate(100 100)' /%3E%3C/svg%3E");
    mask-size: cover;
    -webkit-mask-size: cover;
    mask-position: center;
    -webkit-mask-position: center;
  }

  /* ── Card with clip-path ── */
  .mi-card {
    background: var(--mi-bg-surface);
    border: 1px solid var(--mi-border);
    border-radius: var(--mi-radius);
    padding: 28px;
    overflow: hidden;
    transition: border-color var(--mi-transition), transform var(--mi-transition);
  }
  .mi-card:hover { border-color: var(--mi-accent); transform: translateY(-4px); }

  /* Card with polygon clip */
  .mi-card-clipped {
    background: var(--mi-bg-surface);
    clip-path: polygon(0 0, 100% 0, 100% 85%, 90% 100%, 0 100%);
    padding: 28px;
    transition: clip-path var(--mi-transition);
  }
  .mi-card-clipped:hover {
    clip-path: polygon(0 0, 100% 0, 100% 90%, 85% 100%, 0 100%);
  }

  /* ── Typography ── */
  .mi-heading {
    font-family: var(--mi-font-display);
    font-size: var(--mi-font-size-hero);
    font-weight: 900;
    letter-spacing: var(--mi-letter-spacing);
    line-height: var(--mi-line-height);
    color: var(--mi-text-primary);
    text-transform: uppercase;
  }

  /* ── Button ── */
  .mi-btn {
    padding: 14px 32px;
    background: var(--mi-accent);
    border: none;
    border-radius: var(--mi-radius-sm);
    color: var(--mi-bg);
    font-weight: 700;
    font-family: var(--mi-font-display);
    cursor: pointer;
    transition: all var(--mi-transition);
  }
  .mi-btn:hover { background: var(--mi-accent-hover); transform: scale(1.03); }
  .mi-btn--gradient {
    background: var(--mi-mask-gradient);
    background-size: 200% 200%;
    color: var(--mi-bg);
    animation: mi-gradient-shift 4s ease infinite;
  }
  .mi-btn--outline {
    background: transparent;
    border: 2px solid var(--mi-accent);
    color: var(--mi-accent);
  }
  .mi-btn--outline:hover {
    background: var(--mi-accent);
    color: var(--mi-bg);
  }

  /* ── Wallet connect button ── */
  .mi-wallet-btn {
    padding: 14px 32px;
    background: var(--mi-accent);
    border: none;
    border-radius: var(--mi-radius-sm);
    color: var(--mi-bg);
    font-weight: 700;
    font-family: var(--mi-font-display);
    cursor: pointer;
    box-shadow: var(--mi-shadow-accent);
    transition: all var(--mi-transition);
    position: relative;
    overflow: hidden;
  }
  .mi-wallet-btn::before {
    content: "";
    position: absolute;
    inset: -2px;
    background: var(--mi-mask-gradient);
    background-size: 200% 200%;
    animation: mi-gradient-shift 4s ease infinite;
    border-radius: inherit;
    z-index: -1;
    opacity: 0;
    transition: opacity 0.3s;
  }
  .mi-wallet-btn:hover { transform: scale(1.03); box-shadow: 0 12px 40px rgba(232, 197, 71, 0.3); }
  .mi-wallet-btn:hover::before { opacity: 1; }
}
```

## Component Patterns

```tsx
export function MaskedHero() {
  return (
    <section className="min-h-screen bg-mi-bg flex items-center justify-center px-6 overflow-hidden">
      <div className="text-center animate-mi-fade-up">
        {/* Text with image/gradient background showing through */}
        <h1
          className="font-mi-display text-mi-mega font-black uppercase tracking-mi-tight leading-mi-display bg-clip-text text-transparent [-webkit-text-fill-color:transparent] bg-cover bg-center"
          style={{ backgroundImage: "url('/hero-texture.jpg')" }}
        >
          DEFI
        </h1>
        {/* Gradient text line */}
        <h2 className="font-mi-display text-mi-display font-black uppercase tracking-mi-tight leading-mi-display bg-mi-text-gradient bg-[length:200%_100%] bg-clip-text text-transparent [-webkit-text-fill-color:transparent] animate-mi-gradient-shift mt-4">
          PROTOCOL
        </h2>
        <p className="font-mi-body text-mi-text-secondary text-lg mt-8 max-w-md mx-auto">
          Images revealed through typography. Content masked by creative form.
        </p>
        <div className="flex items-center gap-4 justify-center mt-10">
          <button className="mi-wallet-btn">Connect Wallet</button>
          <button className="mi-btn mi-btn--outline">Learn More</button>
        </div>
      </div>
    </section>
  );
}

export function MaskedCard({ image, title, description, shape = "diamond" }: { image: string; title: string; description: string; shape?: "diamond" | "hexagon" | "circle" }) {
  const clipClasses: Record<string, string> = {
    diamond: "[clip-path:polygon(50%_0%,100%_50%,50%_100%,0%_50%)] hover:[clip-path:polygon(50%_-10%,110%_50%,50%_110%,-10%_50%)]",
    hexagon: "[clip-path:polygon(25%_0%,75%_0%,100%_50%,75%_100%,25%_100%,0%_50%)] hover:[clip-path:polygon(20%_-5%,80%_-5%,105%_50%,80%_105%,20%_105%,-5%_50%)]",
    circle: "[clip-path:circle(40%_at_50%_50%)] hover:[clip-path:circle(50%_at_50%_50%)]",
  };
  return (
    <div className="bg-mi-bg-surface border border-mi-border rounded-xl overflow-hidden hover:border-mi-accent transition-all group animate-mi-fade-up">
      {/* Clipped image */}
      <div className="h-56 overflow-hidden flex items-center justify-center bg-mi-bg-elevated">
        <img
          src={image}
          alt={title}
          className={`w-full h-full object-cover transition-all duration-500 ${clipClasses[shape]}`}
        />
      </div>
      {/* Non-rectangular card bottom via polygon */}
      <div className="p-6 [clip-path:polygon(0_0,100%_8%,100%_100%,0_100%)] bg-mi-bg-surface -mt-4 pt-8">
        <h3 className="font-mi-display text-xl font-bold text-mi-text-primary">{title}</h3>
        <p className="font-mi-body text-sm text-mi-text-secondary mt-2 leading-relaxed">{description}</p>
      </div>
    </div>
  );
}

export function MaskedButton({ children, variant = "solid" }: { children: React.ReactNode; variant?: "solid" | "gradient" | "outline" }) {
  const styles: Record<string, string> = {
    solid: "bg-mi-accent text-mi-bg hover:bg-mi-accent-hover hover:scale-[1.03]",
    gradient: "bg-mi-gradient bg-[length:200%_200%] text-mi-bg animate-mi-gradient-shift hover:scale-[1.03]",
    outline: "bg-transparent border-2 border-mi-accent text-mi-accent hover:bg-mi-accent hover:text-mi-bg",
  };
  return (
    <button className={`px-7 py-3.5 rounded-lg font-mi-display font-bold transition-all ${styles[variant]}`}>
      {children}
    </button>
  );
}

export function MaskedWalletButton() {
  return (
    <button className="mi-wallet-btn flex items-center gap-2">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 12V7H5a2 2 0 010-4h14v4"/><path d="M3 5v14a2 2 0 002 2h16v-5"/><path d="M18 12a1 1 0 100 4 1 1 0 000-4z"/></svg>
      Connect Wallet
    </button>
  );
}

export function GradientText({ children, className = "" }: { children: React.ReactNode; className?: string }) {
  return (
    <span className={`bg-mi-text-gradient bg-[length:200%_100%] bg-clip-text text-transparent [-webkit-text-fill-color:transparent] animate-mi-gradient-shift ${className}`}>
      {children}
    </span>
  );
}
```
