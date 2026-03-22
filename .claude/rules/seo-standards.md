---
path:
  - "src/site/**"
---

# SEO Standards

## Unique Title and Description

Every page MUST have a unique `<title>` and `<meta name="description">`. Never duplicate across pages.

```tsx
// CORRECT: Next.js App Router metadata
// src/site/mint/page.tsx
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Mint NFT — Web3 Studios",
  description:
    "Mint your unique digital artwork on Base. Gas-optimized, instant confirmation, built on ERC-721.",
};

// CORRECT: Dynamic metadata
// src/site/token/[id]/page.tsx
export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const token = await getTokenById(params.id);

  return {
    title: `${token.name} — Web3 Studios`,
    description: token.description.slice(0, 160),
  };
}

// WRONG: Missing metadata
export default function MintPage() {
  return <div>Mint page</div>; // No metadata!
}

// WRONG: Generic/duplicate metadata
export const metadata = {
  title: "Web3 Studios",           // Same as homepage — not unique
  description: "A Web3 website",   // Too vague
};
```

**Title rules:**
- 50-60 characters maximum
- Brand name at the end: "Page Name — Brand"
- Most important keyword first

**Description rules:**
- 150-160 characters
- Include primary keyword naturally
- Include a call-to-action when appropriate

## Open Graph Tags

Every page must have Open Graph metadata for social sharing (Facebook, Discord, Telegram).

```tsx
export const metadata: Metadata = {
  openGraph: {
    title: "Mint NFT — Web3 Studios",
    description: "Mint your unique digital artwork on Base.",
    url: "https://web3studios.xyz/mint",
    siteName: "Web3 Studios",
    images: [
      {
        url: "https://web3studios.xyz/og/mint.png",
        width: 1200,
        height: 630,
        alt: "Web3 Studios Mint Page Preview",
      },
    ],
    locale: "en_US",
    type: "website",
  },
};
```

**OG Image requirements:**
- Dimensions: 1200x630px
- Format: PNG or JPG
- File size: < 300KB
- Include branding and key visual
- Each page should have a unique OG image when possible

## Twitter Card Tags

Every page must have Twitter Card metadata.

```tsx
export const metadata: Metadata = {
  twitter: {
    card: "summary_large_image",
    title: "Mint NFT — Web3 Studios",
    description: "Mint your unique digital artwork on Base.",
    images: ["https://web3studios.xyz/og/mint.png"],
    creator: "@web3studios",
    site: "@web3studios",
  },
};
```

## Canonical URLs

Every page MUST specify a canonical URL to prevent duplicate content issues.

```tsx
export const metadata: Metadata = {
  alternates: {
    canonical: "https://web3studios.xyz/mint",
  },
};

// For paginated pages
export const metadata: Metadata = {
  alternates: {
    canonical: "https://web3studios.xyz/marketplace",
    // Don't set ?page=1 as canonical — use the base URL
  },
};
```

## Structured Data (JSON-LD)

Add JSON-LD structured data for rich search results. Use the appropriate schema type.

```tsx
// CORRECT: JSON-LD for organization
// src/site/layout.tsx
export default function RootLayout({ children }: Props) {
  return (
    <html lang="en">
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: JSON.stringify({
              "@context": "https://schema.org",
              "@type": "Organization",
              name: "Web3 Studios",
              url: "https://web3studios.xyz",
              logo: "https://web3studios.xyz/logo.png",
              sameAs: [
                "https://twitter.com/web3studios",
                "https://github.com/web3studios",
              ],
            }),
          }}
        />
      </head>
      <body>{children}</body>
    </html>
  );
}

// CORRECT: JSON-LD for a product (NFT collection page)
function CollectionStructuredData({ collection }: { collection: Collection }) {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{
        __html: JSON.stringify({
          "@context": "https://schema.org",
          "@type": "Product",
          name: collection.name,
          description: collection.description,
          image: collection.imageUrl,
          offers: {
            "@type": "Offer",
            price: collection.floorPrice,
            priceCurrency: "ETH",
            availability: "https://schema.org/InStock",
          },
        }),
      }}
    />
  );
}

// CORRECT: JSON-LD for FAQ page
const faqSchema = {
  "@context": "https://schema.org",
  "@type": "FAQPage",
  mainEntity: faqs.map((faq) => ({
    "@type": "Question",
    name: faq.question,
    acceptedAnswer: {
      "@type": "Answer",
      text: faq.answer,
    },
  })),
};
```

## Alt Text on All Images

Every `<img>` and `<Image>` MUST have descriptive alt text. Use empty `alt=""` ONLY for purely decorative images.

```tsx
// CORRECT: Descriptive alt text
<Image
  src={nft.image}
  alt={`${nft.name} by ${nft.artist} — ${nft.collection} collection`}
  width={400}
  height={400}
/>

// CORRECT: Decorative image (background patterns, dividers)
<Image
  src="/decorative-pattern.svg"
  alt=""
  aria-hidden="true"
  width={1200}
  height={40}
/>

// WRONG: Missing alt
<Image src={nft.image} width={400} height={400} />

// WRONG: Useless alt text
<Image src={nft.image} alt="image" width={400} height={400} />
<Image src={nft.image} alt="NFT" width={400} height={400} />
```

## Heading Hierarchy

Use headings in strict hierarchical order. Only one `<h1>` per page.

```tsx
// CORRECT: Proper hierarchy
<main>
  <h1>NFT Marketplace</h1>                    {/* Only one h1 */}

  <section>
    <h2>Featured Collections</h2>             {/* Section heading */}
    <div>
      <h3>Cyber Apes</h3>                     {/* Sub-section */}
      <p>Collection description...</p>
    </div>
    <div>
      <h3>Digital Dreams</h3>
      <p>Collection description...</p>
    </div>
  </section>

  <section>
    <h2>Recent Activity</h2>
    <h3>Sales</h3>                            {/* Sub-section */}
    <h3>Listings</h3>
  </section>
</main>

// WRONG: Skipped heading levels
<h1>Marketplace</h1>
<h4>Featured</h4>         {/* Skipped h2 and h3! */}

// WRONG: Multiple h1 tags
<h1>Marketplace</h1>
<h1>Featured Collections</h1>  {/* Second h1! */}
```

## Semantic HTML Elements

Use semantic elements instead of generic `<div>` containers.

```tsx
// CORRECT: Semantic structure
<header>                          {/* Site header */}
  <nav aria-label="Main">         {/* Primary navigation */}
    <a href="/">Home</a>
    <a href="/mint">Mint</a>
    <a href="/marketplace">Marketplace</a>
  </nav>
</header>

<main>                            {/* Page content */}
  <article>                       {/* Self-contained content */}
    <header>
      <h1>{title}</h1>
      <time dateTime={date}>{formattedDate}</time>
    </header>
    <section aria-label="Details">
      {/* ... */}
    </section>
    <footer>
      <p>Created by {artist}</p>
    </footer>
  </article>

  <aside aria-label="Related">   {/* Secondary content */}
    <h2>Similar Items</h2>
  </aside>
</main>

<footer>                          {/* Site footer */}
  <nav aria-label="Footer">
    <a href="/terms">Terms</a>
    <a href="/privacy">Privacy</a>
  </nav>
</footer>

// WRONG: Div-only structure
<div class="header">
  <div class="nav">...</div>
</div>
<div class="main">
  <div class="article">...</div>
</div>
<div class="footer">...</div>
```
