# Brutalism

## CSS Variables

```css
:root {
  --brut-bg: #f5f5dc;
  --brut-bg-alt: #ffffff;
  --brut-black: #000000;
  --brut-yellow: #ffdd00;
  --brut-red: #ff3333;
  --brut-blue: #3333ff;
  --brut-green: #00cc66;
  --brut-text-primary: #000000;
  --brut-text-inverse: #ffffff;
  --brut-border-width: 3px;
  --brut-border: 3px solid #000000;
  --brut-shadow-offset: 6px;
  --brut-shadow: 6px 6px 0 #000000;
  --brut-shadow-hover: 8px 8px 0 #000000;
  --brut-shadow-active: 2px 2px 0 #000000;
  --brut-font: 'Space Mono', 'Courier New', monospace;
  --brut-font-display: 'Space Grotesk', 'Arial Black', sans-serif;
  --brut-radius: 0px;
  --brut-transition: 0.15s ease;
  --brut-spacing-xs: 0.5rem;
  --brut-spacing-sm: 1rem;
  --brut-spacing-md: 1.5rem;
  --brut-spacing-lg: 2rem;
  --brut-spacing-xl: 3rem;
  --brut-font-size-sm: 0.875rem;
  --brut-font-size-base: 1rem;
  --brut-font-size-lg: 1.25rem;
  --brut-font-size-xl: 2rem;
  --brut-font-size-2xl: 3rem;
  --brut-font-size-hero: clamp(3rem, 8vw, 6rem);
}
```

## Tailwind Config Extension

```ts
import type { Config } from "tailwindcss";
export default {
  theme: {
    extend: {
      colors: {
        brut: {
          bg: "#f5f5dc", alt: "#ffffff", black: "#000000",
          yellow: "#ffdd00", red: "#ff3333", blue: "#3333ff", green: "#00cc66",
        },
      },
      fontFamily: {
        brut: ["Space Mono", "Courier New", "monospace"],
        "brut-display": ["Space Grotesk", "Arial Black", "sans-serif"],
      },
      borderRadius: { brut: "0px" },
      borderWidth: { brut: "3px" },
      boxShadow: {
        brut: "6px 6px 0 #000000",
        "brut-hover": "8px 8px 0 #000000",
        "brut-active": "2px 2px 0 #000000",
        "brut-yellow": "6px 6px 0 #ffdd00",
        "brut-red": "6px 6px 0 #ff3333",
      },
      fontSize: { "brut-hero": "clamp(3rem, 8vw, 6rem)" },
      keyframes: {
        "brut-shake": { "0%, 100%": { transform: "translateX(0)" }, "25%": { transform: "translateX(-4px)" }, "75%": { transform: "translateX(4px)" } },
        marquee: { "0%": { transform: "translateX(0)" }, "100%": { transform: "translateX(-50%)" } },
      },
      animation: { "brut-shake": "brut-shake 0.3s ease", marquee: "marquee 20s linear infinite" },
    },
  },
} satisfies Config;
```

## Core CSS Classes

```css
@layer components {
  .brut-card {
    background: var(--brut-bg-alt);
    border: var(--brut-border);
    border-radius: 0;
    box-shadow: var(--brut-shadow);
    padding: 24px;
    transition: transform var(--brut-transition), box-shadow var(--brut-transition);
  }
  .brut-card:hover {
    transform: translate(-2px, -2px);
    box-shadow: var(--brut-shadow-hover);
  }
  .brut-btn {
    display: inline-flex; align-items: center; gap: 8px;
    padding: 14px 28px;
    background: var(--brut-yellow);
    border: var(--brut-border);
    border-radius: 0;
    box-shadow: var(--brut-shadow);
    color: var(--brut-black);
    font-family: var(--brut-font);
    font-size: var(--brut-font-size-sm);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    cursor: pointer;
    transition: transform var(--brut-transition), box-shadow var(--brut-transition);
  }
  .brut-btn:hover {
    transform: translate(-2px, -2px);
    box-shadow: var(--brut-shadow-hover);
  }
  .brut-btn:active {
    transform: translate(4px, 4px);
    box-shadow: var(--brut-shadow-active);
  }
  .brut-btn--black { background: var(--brut-black); color: var(--brut-text-inverse); box-shadow: 6px 6px 0 var(--brut-yellow); }
  .brut-btn--red { background: var(--brut-red); color: var(--brut-text-inverse); }
  .brut-heading {
    font-family: var(--brut-font-display);
    font-size: var(--brut-font-size-hero);
    font-weight: 900;
    line-height: 0.95;
    color: var(--brut-black);
    text-transform: uppercase;
  }
  .brut-marquee {
    overflow: hidden; white-space: nowrap;
    border-top: var(--brut-border);
    border-bottom: var(--brut-border);
    padding: 12px 0;
    background: var(--brut-yellow);
  }
  .brut-input {
    width: 100%; padding: 14px 16px;
    background: var(--brut-bg-alt);
    border: var(--brut-border);
    border-radius: 0;
    font-family: var(--brut-font);
    color: var(--brut-black);
    outline: none;
  }
  .brut-input:focus { box-shadow: var(--brut-shadow); }
  .brut-wallet-btn {
    padding: 14px 32px;
    background: var(--brut-black);
    border: 3px solid var(--brut-yellow);
    color: var(--brut-yellow);
    font-family: var(--brut-font);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    box-shadow: 6px 6px 0 var(--brut-yellow);
    cursor: pointer;
    transition: all var(--brut-transition);
  }
  .brut-wallet-btn:hover { transform: translate(-2px, -2px); box-shadow: 8px 8px 0 var(--brut-yellow); }
  .brut-wallet-btn:active { transform: translate(4px, 4px); box-shadow: 2px 2px 0 var(--brut-yellow); }
}
```

## Component Patterns

```tsx
export function BrutHero() {
  return (
    <section className="min-h-screen bg-brut-bg flex flex-col justify-center px-8 py-16">
      <h1 className="font-brut-display text-brut-hero font-black uppercase leading-[0.95] text-brut-black">
        NO<br />NONSENSE<br />
        <span className="bg-brut-yellow px-2 inline-block border-brut border-3 border-brut-black">DEFI</span>
      </h1>
      <p className="font-brut text-lg text-brut-black mt-8 max-w-md leading-relaxed">
        Raw. Honest. Functional. No gradients. No blur. Just code that works.
      </p>
      <div className="flex gap-4 mt-8">
        <button className="px-7 py-3.5 bg-brut-black border-3 border-brut-black text-brut-yellow font-brut font-bold uppercase tracking-wider shadow-brut-yellow hover:translate-x-[-2px] hover:translate-y-[-2px] hover:shadow-[8px_8px_0_#ffdd00] active:translate-x-1 active:translate-y-1 active:shadow-[2px_2px_0_#ffdd00] transition-all">
          Connect Wallet
        </button>
        <button className="px-7 py-3.5 bg-brut-yellow border-3 border-brut-black font-brut font-bold uppercase tracking-wider shadow-brut hover:translate-x-[-2px] hover:translate-y-[-2px] hover:shadow-brut-hover active:translate-x-1 active:translate-y-1 active:shadow-brut-active transition-all">
          Read Docs
        </button>
      </div>
      <div className="mt-16 overflow-hidden border-y-3 border-brut-black py-3 bg-brut-yellow">
        <div className="animate-marquee whitespace-nowrap font-brut font-bold uppercase text-brut-black">
          TVL: $420M &bull; VOLUME 24H: $69M &bull; USERS: 100K+ &bull; CHAINS: 5 &bull; TVL: $420M &bull; VOLUME 24H: $69M &bull; USERS: 100K+ &bull; CHAINS: 5 &bull;
        </div>
      </div>
    </section>
  );
}

export function BrutCard({ title, description, tag }: { title: string; description: string; tag: string }) {
  return (
    <div className="bg-brut-alt border-3 border-brut-black shadow-brut p-6 hover:translate-x-[-2px] hover:translate-y-[-2px] hover:shadow-brut-hover transition-all">
      <span className="inline-block px-3 py-1 bg-brut-yellow border-3 border-brut-black font-brut text-xs font-bold uppercase">{tag}</span>
      <h3 className="font-brut-display text-2xl font-black uppercase text-brut-black mt-4">{title}</h3>
      <p className="font-brut text-sm text-brut-black mt-2 leading-relaxed">{description}</p>
    </div>
  );
}

export function BrutButton({ children, color = "yellow" }: { children: React.ReactNode; color?: "yellow" | "black" | "red" }) {
  const styles = {
    yellow: "bg-brut-yellow text-brut-black shadow-brut",
    black: "bg-brut-black text-white shadow-brut-yellow",
    red: "bg-brut-red text-white shadow-brut",
  }[color];
  return (
    <button className={`px-7 py-3.5 border-3 border-brut-black font-brut font-bold uppercase tracking-wider hover:translate-x-[-2px] hover:translate-y-[-2px] active:translate-x-1 active:translate-y-1 transition-all ${styles}`}>
      {children}
    </button>
  );
}
```
