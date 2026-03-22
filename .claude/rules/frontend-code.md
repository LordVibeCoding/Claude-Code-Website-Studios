---
path:
  - "src/site/**"
  - "src/components/**"
---

# Frontend Code Standards

## SEO-Ready Markup

Use semantic HTML elements exclusively. Every page must be crawlable and indexable.

```tsx
// CORRECT: Semantic structure
<main>
  <article>
    <header>
      <h1>{title}</h1>
      <time dateTime={publishDate}>{formattedDate}</time>
    </header>
    <section aria-label="Content">
      <p>{content}</p>
    </section>
  </article>
</main>

// WRONG: Div soup
<div className="main">
  <div className="article">
    <div className="header">
      <div className="title">{title}</div>
    </div>
  </div>
</div>
```

Every page MUST include:

```tsx
export const metadata: Metadata = {
  title: "Page Title — Web3 Studios",
  description: "Unique 150-160 char description",
  openGraph: { title, description, images },
  twitter: { card: "summary_large_image" },
  alternates: { canonical: "/page-path" },
};
```

## Accessibility (ARIA)

- All interactive elements must be keyboard-navigable
- Images require `alt` text (empty `alt=""` for decorative images)
- Form inputs must have associated `<label>` elements
- Color contrast minimum 4.5:1 (AA) for body text, 3:1 for large text
- Focus indicators must be visible
- Use `aria-label` or `aria-labelledby` for icon-only buttons

```tsx
// CORRECT
<button aria-label="Connect wallet" onClick={connect}>
  <WalletIcon aria-hidden="true" />
</button>

// WRONG
<div onClick={connect}>
  <WalletIcon />
</div>
```

## Core Web Vitals Optimization

- **LCP < 2.5s**: Lazy-load below-fold images, preload hero images
- **FID < 100ms**: No heavy computation on main thread; use Web Workers
- **CLS < 0.1**: Always set explicit width/height on images and embeds

```tsx
// CORRECT: Optimized image
import Image from "next/image";

<Image
  src="/hero.webp"
  alt="Platform hero banner"
  width={1200}
  height={600}
  priority  // Preload hero images
  placeholder="blur"
  blurDataURL={blurHash}
/>

// WRONG: Raw img tag
<img src="/hero.png" />
```

## Server vs Client Components

**Default to Server Components.** Only use `"use client"` when the component genuinely needs:
- Event handlers (`onClick`, `onChange`, etc.)
- `useState`, `useEffect`, `useReducer`
- Browser-only APIs (`window`, `localStorage`)
- Third-party client libraries (wallet connectors, etc.)

```tsx
// Server Component (default) — no directive needed
export default function TokenList({ tokens }: Props) {
  return (
    <ul>
      {tokens.map((t) => (
        <li key={t.address}>{t.name}: {t.balance}</li>
      ))}
    </ul>
  );
}

// Client Component — explicit directive required
"use client";
import { useState } from "react";

export function TokenFilter({ onFilter }: Props) {
  const [query, setQuery] = useState("");
  return <input value={query} onChange={(e) => setQuery(e.target.value)} />;
}
```

## No Direct DOM Manipulation

Never use `document.querySelector`, `document.getElementById`, or direct DOM mutations. Use React refs and state instead.

```tsx
// CORRECT
const inputRef = useRef<HTMLInputElement>(null);
const focusInput = () => inputRef.current?.focus();

// WRONG
const focusInput = () => document.getElementById("input")?.focus();
```

## Image Optimization

- Use `next/image` or equivalent framework image component
- Serve WebP/AVIF formats with fallbacks
- Implement responsive `sizes` attribute
- Use `placeholder="blur"` for perceived performance
- Lazy-load all images below the fold

```tsx
<Image
  src="/nft-gallery/item-01.webp"
  alt="Digital artwork #01 by Artist Name"
  width={400}
  height={400}
  sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
  loading="lazy"
/>
```
