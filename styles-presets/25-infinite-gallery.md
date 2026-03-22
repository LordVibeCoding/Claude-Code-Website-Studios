# Infinite Gallery

## CSS Variables

```css
:root {
  --ig-bg: #0c0c10;
  --ig-bg-surface: #16161c;
  --ig-bg-elevated: #1e1e26;
  --ig-text-primary: #f0f0f5;
  --ig-text-secondary: #8888a0;
  --ig-text-dim: #555566;
  --ig-accent: #e040fb;
  --ig-accent-hover: #ea6dfc;
  --ig-accent-blue: #40c4ff;
  --ig-accent-green: #69f0ae;
  --ig-border: #2a2a35;
  --ig-font-display: 'Syne', 'Space Grotesk', sans-serif;
  --ig-font-body: 'Inter', system-ui, sans-serif;
  --ig-font-mono: 'JetBrains Mono', monospace;
  --ig-font-size-hero: clamp(3rem, 7vw, 6rem);
  --ig-font-size-heading: clamp(1.5rem, 3vw, 2.5rem);
  --ig-font-size-body: 1rem;
  --ig-radius: 12px;
  --ig-radius-sm: 8px;
  --ig-radius-full: 9999px;
  --ig-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
  --ig-shadow-accent: 0 8px 30px rgba(224, 64, 251, 0.2);
  --ig-transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  --ig-scroll-speed: 30s;
  --ig-scroll-speed-slow: 45s;
  --ig-scroll-speed-fast: 20s;
  --ig-gallery-gap: 16px;
  --ig-gallery-gap-lg: 24px;
  --ig-item-size: 320px;
  --ig-item-height: 220px;
  --ig-item-size-sm: 240px;
  --ig-item-height-sm: 160px;
  --ig-spacing-xs: 0.5rem;
  --ig-spacing-sm: 1rem;
  --ig-spacing-md: 2rem;
  --ig-spacing-lg: 3rem;
  --ig-spacing-xl: 5rem;
  --ig-fade-width: 150px;
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        ig: {
          bg: { DEFAULT: "#0c0c10", surface: "#16161c", elevated: "#1e1e26" },
          text: { primary: "#f0f0f5", secondary: "#8888a0", dim: "#555566" },
          accent: { DEFAULT: "#e040fb", hover: "#ea6dfc", blue: "#40c4ff", green: "#69f0ae" },
          border: "#2a2a35",
        },
      },
      fontFamily: {
        "ig-display": ["Syne", "Space Grotesk", "sans-serif"],
        "ig-body": ["Inter", "system-ui", "sans-serif"],
        "ig-mono": ["JetBrains Mono", "monospace"],
      },
      fontSize: {
        "ig-hero": "clamp(3rem, 7vw, 6rem)",
        "ig-heading": "clamp(1.5rem, 3vw, 2.5rem)",
      },
      keyframes: {
        "ig-scroll-left": {
          "0%": { transform: "translateX(0)" },
          "100%": { transform: "translateX(-50%)" },
        },
        "ig-scroll-right": {
          "0%": { transform: "translateX(-50%)" },
          "100%": { transform: "translateX(0)" },
        },
        "ig-fade-up": {
          "0%": { opacity: "0", transform: "translateY(24px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        "ig-scale-in": {
          "0%": { transform: "scale(0.9)", opacity: "0" },
          "100%": { transform: "scale(1)", opacity: "1" },
        },
        "ig-glow-pulse": {
          "0%, 100%": { boxShadow: "0 0 20px rgba(224,64,251,0.15)" },
          "50%": { boxShadow: "0 0 40px rgba(224,64,251,0.3)" },
        },
      },
      animation: {
        "ig-scroll-left": "ig-scroll-left 30s linear infinite",
        "ig-scroll-left-slow": "ig-scroll-left 45s linear infinite",
        "ig-scroll-left-fast": "ig-scroll-left 20s linear infinite",
        "ig-scroll-right": "ig-scroll-right 30s linear infinite",
        "ig-scroll-right-slow": "ig-scroll-right 45s linear infinite",
        "ig-scroll-right-fast": "ig-scroll-right 20s linear infinite",
        "ig-fade-up": "ig-fade-up 0.6s ease forwards",
        "ig-scale-in": "ig-scale-in 0.5s ease forwards",
        "ig-glow-pulse": "ig-glow-pulse 3s ease-in-out infinite",
      },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  /* ── Marquee track container ── */
  .ig-track-container {
    overflow: hidden;
    width: 100%;
    position: relative;
  }
  .ig-track-container:hover .ig-track {
    animation-play-state: paused;
  }

  /* Track: flex row of items, width: max-content */
  .ig-track {
    display: flex;
    gap: var(--ig-gallery-gap);
    width: max-content;
  }
  .ig-track--left { animation: ig-scroll-left var(--ig-scroll-speed) linear infinite; }
  .ig-track--right { animation: ig-scroll-right var(--ig-scroll-speed) linear infinite; }
  .ig-track--slow { animation-duration: var(--ig-scroll-speed-slow); }
  .ig-track--fast { animation-duration: var(--ig-scroll-speed-fast); }

  /* ── Edge fade gradients ── */
  .ig-fade-left {
    position: absolute;
    left: 0; top: 0; bottom: 0;
    width: var(--ig-fade-width);
    background: linear-gradient(to right, var(--ig-bg), transparent);
    z-index: 10;
    pointer-events: none;
  }
  .ig-fade-right {
    position: absolute;
    right: 0; top: 0; bottom: 0;
    width: var(--ig-fade-width);
    background: linear-gradient(to left, var(--ig-bg), transparent);
    z-index: 10;
    pointer-events: none;
  }

  /* ── Gallery item ── */
  .ig-item {
    flex-shrink: 0;
    width: var(--ig-item-size);
    height: var(--ig-item-height);
    border-radius: var(--ig-radius);
    overflow: hidden;
    position: relative;
    transition: transform var(--ig-transition), box-shadow var(--ig-transition);
  }
  .ig-item:hover {
    transform: scale(1.06);
    z-index: 10;
    box-shadow: var(--ig-shadow);
  }
  .ig-item img {
    width: 100%; height: 100%;
    object-fit: cover;
    transition: transform var(--ig-transition);
  }
  .ig-item:hover img { transform: scale(1.1); }

  /* Item hover overlay */
  .ig-item-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.75) 0%, rgba(0,0,0,0.1) 40%, transparent 60%);
    opacity: 0;
    transition: opacity var(--ig-transition);
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    padding: 16px;
  }
  .ig-item:hover .ig-item-overlay { opacity: 1; }

  /* Small item variant */
  .ig-item--sm {
    width: var(--ig-item-size-sm);
    height: var(--ig-item-height-sm);
  }

  /* ── Heading ── */
  .ig-heading {
    font-family: var(--ig-font-display);
    font-size: var(--ig-font-size-hero);
    font-weight: 700;
    color: var(--ig-text-primary);
    line-height: 1.1;
    letter-spacing: -0.02em;
  }

  /* ── Card ── */
  .ig-card {
    background: var(--ig-bg-surface);
    border: 1px solid var(--ig-border);
    border-radius: var(--ig-radius);
    padding: 24px;
    transition: all var(--ig-transition);
  }
  .ig-card:hover {
    border-color: var(--ig-accent);
    transform: translateY(-3px);
    box-shadow: 0 0 20px rgba(224, 64, 251, 0.1);
  }

  /* ── Button ── */
  .ig-btn {
    padding: 14px 32px;
    background: var(--ig-accent);
    border: none;
    border-radius: var(--ig-radius-full);
    color: #fff;
    font-weight: 700;
    font-family: var(--ig-font-display);
    cursor: pointer;
    transition: all var(--ig-transition);
  }
  .ig-btn:hover { background: var(--ig-accent-hover); transform: scale(1.03); }
  .ig-btn--blue { background: var(--ig-accent-blue); }
  .ig-btn--blue:hover { background: #33b3e6; }
  .ig-btn--outline {
    background: transparent;
    border: 2px solid var(--ig-accent);
    color: var(--ig-accent);
  }
  .ig-btn--outline:hover {
    background: var(--ig-accent);
    color: #fff;
  }

  /* ── Wallet connect button ── */
  .ig-wallet-btn {
    padding: 14px 32px;
    background: var(--ig-accent);
    border: none;
    border-radius: var(--ig-radius-full);
    color: #fff;
    font-weight: 700;
    font-family: var(--ig-font-display);
    cursor: pointer;
    box-shadow: var(--ig-shadow-accent);
    transition: all var(--ig-transition);
  }
  .ig-wallet-btn:hover {
    background: var(--ig-accent-hover);
    transform: scale(1.03);
    box-shadow: 0 12px 40px rgba(224, 64, 251, 0.35);
  }

  /* ── Counter / stats badge ── */
  .ig-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 16px;
    background: var(--ig-bg-elevated);
    border: 1px solid var(--ig-border);
    border-radius: var(--ig-radius-full);
    font-family: var(--ig-font-mono);
    font-size: 0.8125rem;
    color: var(--ig-text-secondary);
  }
}
```

## Component Patterns

```tsx
"use client";

/**
 * MarqueeRow — Infinite scrolling row with seamless loop.
 * Content is duplicated so the loop has no visible gap.
 * Hover pauses animation via CSS animation-play-state.
 */
function MarqueeRow({
  images,
  direction = "left",
  speed = "default",
}: {
  images: { src: string; title?: string; artist?: string }[];
  direction?: "left" | "right";
  speed?: "default" | "slow" | "fast";
}) {
  const animMap: Record<string, Record<string, string>> = {
    left: { default: "animate-ig-scroll-left", slow: "animate-ig-scroll-left-slow", fast: "animate-ig-scroll-left-fast" },
    right: { default: "animate-ig-scroll-right", slow: "animate-ig-scroll-right-slow", fast: "animate-ig-scroll-right-fast" },
  };
  const animClass = animMap[direction][speed];
  const doubled = [...images, ...images]; // Duplicate for seamless loop

  return (
    <div className="overflow-hidden w-full relative group">
      {/* Edge fades */}
      <div className="ig-fade-left" />
      <div className="ig-fade-right" />
      {/* Track */}
      <div className={`flex gap-[var(--ig-gallery-gap)] w-max ${animClass} group-hover:[animation-play-state:paused]`}>
        {doubled.map((item, i) => (
          <div
            key={i}
            className="flex-shrink-0 w-[var(--ig-item-size)] h-[var(--ig-item-height)] rounded-xl overflow-hidden relative hover:scale-[1.06] hover:z-10 hover:shadow-[0_10px_40px_rgba(0,0,0,0.5)] transition-all"
          >
            <img src={item.src} alt={item.title ?? ""} className="w-full h-full object-cover hover:scale-110 transition-transform" />
            <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/10 to-transparent opacity-0 hover:opacity-100 transition-opacity flex flex-col justify-end p-4">
              {item.title && <span className="font-ig-display text-sm text-white font-bold">{item.title}</span>}
              {item.artist && <span className="font-ig-body text-xs text-ig-text-secondary mt-0.5">by {item.artist}</span>}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export function InfiniteGalleryHero() {
  const row1 = [
    { src: "/nft-1.jpg", title: "Cosmic Drift", artist: "0xAr7" },
    { src: "/nft-2.jpg", title: "Neon Pulse", artist: "CryptoVis" },
    { src: "/nft-3.jpg", title: "Liquid Gold", artist: "MintLabs" },
    { src: "/nft-4.jpg", title: "Fractal Dawn", artist: "GenArt" },
    { src: "/nft-5.jpg", title: "Void Echo", artist: "0xZen" },
    { src: "/nft-6.jpg", title: "Data Bloom", artist: "PixelDAO" },
  ];
  const row2 = [
    { src: "/nft-7.jpg", title: "Glass Reef" },
    { src: "/nft-8.jpg", title: "Prism Wave" },
    { src: "/nft-9.jpg", title: "Solar Flare" },
    { src: "/nft-10.jpg", title: "Glitch Core" },
    { src: "/nft-11.jpg", title: "Silk Thread" },
    { src: "/nft-12.jpg", title: "Hex Garden" },
  ];
  const row3 = [
    { src: "/nft-13.jpg" }, { src: "/nft-14.jpg" }, { src: "/nft-15.jpg" },
    { src: "/nft-16.jpg" }, { src: "/nft-17.jpg" }, { src: "/nft-18.jpg" },
  ];

  return (
    <section className="min-h-screen bg-ig-bg flex flex-col justify-center py-20 overflow-hidden">
      {/* Header */}
      <div className="text-center px-6 mb-16 animate-ig-fade-up">
        <div className="ig-badge mx-auto mb-4">
          <span className="w-2 h-2 rounded-full bg-ig-accent-green animate-pulse" />
          <span>12,847 items</span>
        </div>
        <h1 className="font-ig-display text-ig-hero font-bold text-ig-text-primary tracking-tight leading-[1.1]">
          Infinite <span className="text-ig-accent">Gallery</span>
        </h1>
        <p className="font-ig-body text-ig-text-secondary text-lg mt-4 max-w-md mx-auto">
          Endlessly scrolling collections. Hover to pause, explore, and discover.
        </p>
        <button className="ig-wallet-btn mt-8">Connect Wallet</button>
      </div>

      {/* Marquee rows — odd=left, even=right */}
      <div className="space-y-[var(--ig-gallery-gap)]">
        <MarqueeRow images={row1} direction="left" />
        <MarqueeRow images={row2} direction="right" speed="slow" />
        <MarqueeRow images={row3} direction="left" speed="slow" />
      </div>
    </section>
  );
}

export function GalleryCard({ title, artist, image, price }: { title: string; artist: string; image: string; price?: string }) {
  return (
    <div className="bg-ig-bg-surface border border-ig-border rounded-xl overflow-hidden hover:border-ig-accent hover:-translate-y-1 transition-all group animate-ig-scale-in">
      <div className="h-52 overflow-hidden">
        <img src={image} alt={title} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
      </div>
      <div className="p-5">
        <h3 className="font-ig-display text-lg font-bold text-ig-text-primary">{title}</h3>
        <p className="font-ig-body text-sm text-ig-text-secondary mt-1">by {artist}</p>
        {price && (
          <div className="flex items-center justify-between mt-4 pt-3 border-t border-ig-border">
            <span className="font-ig-mono text-xs text-ig-text-dim">Current Price</span>
            <span className="font-ig-display text-sm font-bold text-ig-accent">{price}</span>
          </div>
        )}
      </div>
    </div>
  );
}

export function GalleryButton({ children, variant = "default" }: { children: React.ReactNode; variant?: "default" | "blue" | "outline" }) {
  const styles: Record<string, string> = {
    default: "bg-ig-accent text-white hover:bg-ig-accent-hover",
    blue: "bg-ig-accent-blue text-white hover:bg-[#33b3e6]",
    outline: "bg-transparent border-2 border-ig-accent text-ig-accent hover:bg-ig-accent hover:text-white",
  };
  return (
    <button className={`px-7 py-3.5 rounded-full font-ig-display font-bold hover:scale-[1.03] transition-all ${styles[variant]}`}>
      {children}
    </button>
  );
}

export function GalleryWalletButton() {
  return (
    <button className="ig-wallet-btn flex items-center gap-2">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 12V7H5a2 2 0 010-4h14v4"/><path d="M3 5v14a2 2 0 002 2h16v-5"/><path d="M18 12a1 1 0 100 4 1 1 0 000-4z"/></svg>
      Connect Wallet
    </button>
  );
}

export { MarqueeRow };
```
