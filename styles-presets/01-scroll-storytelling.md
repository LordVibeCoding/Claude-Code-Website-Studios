# Scroll Storytelling

## CSS Variables

```css
:root {
  --st-bg-primary: #0a0a0a;
  --st-bg-secondary: #111111;
  --st-bg-overlay: rgba(0, 0, 0, 0.6);
  --st-text-primary: #f5f5f5;
  --st-text-secondary: #a0a0a0;
  --st-text-accent: #e0d4b8;
  --st-accent: #c9a96e;
  --st-accent-hover: #dfc08a;
  --st-font-display: 'Playfair Display', Georgia, serif;
  --st-font-body: 'Inter', system-ui, sans-serif;
  --st-font-size-hero: clamp(3rem, 10vw, 8rem);
  --st-font-size-heading: clamp(2rem, 5vw, 4rem);
  --st-font-size-body: clamp(1rem, 1.2vw, 1.25rem);
  --st-line-height-hero: 0.95;
  --st-line-height-body: 1.7;
  --st-spacing-section: 100vh;
  --st-spacing-lg: 6rem;
  --st-spacing-md: 3rem;
  --st-spacing-sm: 1.5rem;
  --st-border-radius: 2px;
  --st-transition-slow: 1.2s cubic-bezier(0.16, 1, 0.3, 1);
  --st-transition-medium: 0.6s cubic-bezier(0.16, 1, 0.3, 1);
  --st-shadow-text: 0 2px 40px rgba(0, 0, 0, 0.8);
  --st-shadow-card: 0 20px 60px rgba(0, 0, 0, 0.5);
  --st-gradient-fade: linear-gradient(to bottom, transparent, var(--st-bg-primary));
  --st-z-content: 10;
  --st-z-overlay: 5;
  --st-z-video: 1;
}
```

## Tailwind Config Extension

```ts
// tailwind.config.ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        st: {
          bg: { primary: "#0a0a0a", secondary: "#111111", overlay: "rgba(0,0,0,0.6)" },
          text: { primary: "#f5f5f5", secondary: "#a0a0a0", accent: "#e0d4b8" },
          accent: { DEFAULT: "#c9a96e", hover: "#dfc08a" },
        },
      },
      fontFamily: { display: ["Playfair Display", "Georgia", "serif"], body: ["Inter", "system-ui", "sans-serif"] },
      fontSize: { hero: "clamp(3rem, 10vw, 8rem)", heading: "clamp(2rem, 5vw, 4rem)" },
      lineHeight: { hero: "0.95" },
      spacing: { section: "100vh" },
      transitionTimingFunction: { story: "cubic-bezier(0.16, 1, 0.3, 1)" },
      boxShadow: { "st-text": "0 2px 40px rgba(0,0,0,0.8)", "st-card": "0 20px 60px rgba(0,0,0,0.5)" },
      keyframes: {
        "fade-up": { "0%": { opacity: "0", transform: "translateY(60px)" }, "100%": { opacity: "1", transform: "translateY(0)" } },
        "scale-in": { "0%": { opacity: "0", transform: "scale(1.1)" }, "100%": { opacity: "1", transform: "scale(1)" } },
      },
      animation: { "fade-up": "fade-up 1.2s cubic-bezier(0.16,1,0.3,1) forwards", "scale-in": "scale-in 1.5s cubic-bezier(0.16,1,0.3,1) forwards" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .st-section {
    position: relative;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    background: var(--st-bg-primary);
  }
  .st-video-bg {
    position: absolute;
    inset: 0;
    z-index: var(--st-z-video);
    object-fit: cover;
    width: 100%;
    height: 100%;
  }
  .st-overlay {
    position: absolute;
    inset: 0;
    z-index: var(--st-z-overlay);
    background: var(--st-gradient-fade);
  }
  .st-content {
    position: relative;
    z-index: var(--st-z-content);
    max-width: 900px;
    padding: var(--st-spacing-md);
    opacity: 0;
    transform: translateY(60px);
  }
  .st-content.is-visible {
    opacity: 1;
    transform: translateY(0);
    transition: opacity var(--st-transition-slow), transform var(--st-transition-slow);
  }
  .st-heading {
    font-family: var(--st-font-display);
    font-size: var(--st-font-size-hero);
    line-height: var(--st-line-height-hero);
    color: var(--st-text-primary);
    text-shadow: var(--st-shadow-text);
    font-weight: 700;
  }
  .st-body {
    font-family: var(--st-font-body);
    font-size: var(--st-font-size-body);
    line-height: var(--st-line-height-body);
    color: var(--st-text-secondary);
    margin-top: var(--st-spacing-sm);
  }
  .st-progress {
    position: fixed;
    top: 0;
    left: 0;
    height: 3px;
    background: var(--st-accent);
    z-index: 100;
    transform-origin: left;
  }
  .st-wallet-btn {
    font-family: var(--st-font-body);
    padding: 14px 32px;
    background: transparent;
    border: 1px solid var(--st-accent);
    color: var(--st-accent);
    font-size: 0.875rem;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    cursor: pointer;
    transition: all var(--st-transition-medium);
  }
  .st-wallet-btn:hover {
    background: var(--st-accent);
    color: var(--st-bg-primary);
  }
}
```

## Component Patterns

```tsx
// Hero Section — 全屏视频背景 + 电影感文字
export function StoryHero() {
  return (
    <section className="relative min-h-screen flex items-center justify-center overflow-hidden bg-st-bg-primary">
      <video
        className="absolute inset-0 z-[1] w-full h-full object-cover"
        src="/hero.mp4" autoPlay muted loop playsInline
      />
      <div className="absolute inset-0 z-[5] bg-gradient-to-b from-transparent to-st-bg-primary" />
      <div className="relative z-10 max-w-[900px] px-6 text-center animate-fade-up">
        <h1 className="font-display text-hero leading-hero text-st-text-primary drop-shadow-[0_2px_40px_rgba(0,0,0,0.8)]">
          Into the Unknown
        </h1>
        <p className="font-body text-lg text-st-text-secondary mt-6 leading-relaxed max-w-[600px] mx-auto">
          A journey through decentralized frontiers. Scroll to begin.
        </p>
        <button className="mt-10 px-8 py-3.5 border border-st-accent text-st-accent uppercase tracking-widest text-sm font-body hover:bg-st-accent hover:text-st-bg-primary transition-all duration-600 ease-story">
          Connect Wallet
        </button>
      </div>
    </section>
  );
}

// Card — 暗色电影卡片
export function StoryCard({ title, description }: { title: string; description: string }) {
  return (
    <div className="relative bg-st-bg-secondary rounded-sm shadow-st-card p-10 max-w-lg opacity-0 translate-y-[60px] transition-all duration-[1200ms] ease-story data-[visible=true]:opacity-100 data-[visible=true]:translate-y-0">
      <h3 className="font-display text-heading text-st-text-primary leading-tight">{title}</h3>
      <p className="font-body text-base text-st-text-secondary mt-4 leading-relaxed">{description}</p>
      <div className="mt-6 h-px bg-gradient-to-r from-st-accent to-transparent" />
    </div>
  );
}

// Button — 电影感 CTA
export function StoryCTA({ children }: { children: React.ReactNode }) {
  return (
    <button className="group relative px-10 py-4 bg-st-accent text-st-bg-primary font-body text-sm uppercase tracking-[0.15em] font-medium overflow-hidden transition-all duration-600 ease-story hover:shadow-[0_0_40px_rgba(201,169,110,0.3)]">
      <span className="relative z-10">{children}</span>
      <span className="absolute inset-0 bg-st-accent-hover scale-x-0 origin-left transition-transform duration-600 ease-story group-hover:scale-x-100" />
    </button>
  );
}
```
