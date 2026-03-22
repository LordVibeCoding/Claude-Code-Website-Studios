# Design Styles Guide — 25 Styles

## Overview

The studio includes 25 built-in design styles selectable via `/pick-style`. Each style defines visual language, CSS patterns, animation approach, and component aesthetics.

---

## Style Catalog

### 1. Scroll Storytelling

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `scroll-snap-type: y mandatory`, `position: sticky`, full-viewport sections (`height: 100vh`), GSAP ScrollTrigger pin/scrub |
| **Best For** | High-end product launches, roadmap narratives, brand stories |
| **Complexity** | High |

Sections animate in/out as user scrolls. Each viewport-height section tells one part of the story. Heavy use of scroll-triggered animations with GSAP ScrollTrigger.

---

### 2. Bento Grid

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `display: grid`, `grid-template-columns: repeat(auto-fit, minmax(200px, 1fr))`, variable `grid-row: span N` / `grid-column: span N`, `gap: 1rem` |
| **Best For** | SaaS dashboards, DApp dashboards, feature showcases |
| **Complexity** | Medium |

Apple-inspired grid layout with cards of varying sizes. Content organized in modular, asymmetric grid tiles. Clean borders, subtle shadows, rounded corners.

---

### 3. Glassmorphism

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `backdrop-filter: blur(16px)`, `background: rgba(255,255,255,0.1)`, `border: 1px solid rgba(255,255,255,0.2)`, `box-shadow: 0 8px 32px rgba(0,0,0,0.1)` |
| **Best For** | Modern DApps, wallet interfaces, token dashboards |
| **Complexity** | Low-Medium |

Frosted glass effect with translucent layers. Works best on dark backgrounds with colorful gradients behind the glass panels.

---

### 4. Neumorphism

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `box-shadow: 8px 8px 16px #d1d5db, -8px -8px 16px #ffffff`, `border-radius: 16px`, soft background matching shadows, inset shadows for pressed states |
| **Best For** | Control panels, dashboard widgets, settings UI |
| **Complexity** | Medium |

Soft, extruded UI elements that appear to push out from the background. Requires careful shadow tuning. Best on light monochrome backgrounds.

---

### 5. Dark Mode + Neon

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `background: #0a0a0a`, `color: #00ff88` (neon green) or `#00d4ff` (neon blue), `text-shadow: 0 0 10px currentColor`, `box-shadow: 0 0 20px rgba(0,255,136,0.3)`, glowing borders |
| **Best For** | Web3/crypto projects, gaming, token pages |
| **Complexity** | Low |

Dark backgrounds with neon accent colors that glow. Electric, futuristic feel. Borders and text have luminous glow effects.

---

### 6. Brutalism

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `border: 3px solid black`, `box-shadow: 4px 4px 0 black`, monospace fonts, high-contrast colors, no border-radius, raw HTML aesthetic |
| **Best For** | Meme tokens, punk/counterculture projects, experimental |
| **Complexity** | Low |

Raw, unpolished aesthetic. Bold borders, harsh shadows, unconventional layouts. Intentionally "ugly" design that stands out.

---

### 7. Minimalism

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | Generous whitespace (`padding: 4rem+`), limited color palette (2-3 colors), `font-weight: 300-400`, subtle hover states, clean sans-serif typography |
| **Best For** | Premium brands, institutional crypto, DeFi protocols |
| **Complexity** | Low |

Less is more. Maximum whitespace, minimal decoration, content-focused. Typography and spacing do the heavy lifting.

---

### 8. Big Typography

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `font-size: clamp(3rem, 8vw, 10rem)`, `font-weight: 900`, `line-height: 0.9`, text as hero element, `mix-blend-mode: difference`, split-text animations |
| **Best For** | Token launches, announcements, bold statements |
| **Complexity** | Medium |

Typography IS the design. Oversized display text dominates the page. Text animations (reveal, split, scramble) add dynamism.

---

### 9. Horizontal Scroll

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `display: flex`, `flex-wrap: nowrap`, `overflow-x: auto`, `scroll-snap-type: x mandatory`, GSAP horizontal scroll pin, `width: max-content` |
| **Best For** | NFT galleries, portfolio showcases, timelines |
| **Complexity** | High |

Content scrolls horizontally instead of vertically. GSAP transforms vertical scroll input into horizontal movement. Great for linear narratives or galleries.

---

### 10. Card Stacking

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `position: sticky`, `top: calc(var(--index) * 2rem)`, stacked z-index layers, scroll-triggered card reveal, perspective transforms |
| **Best For** | Feature showcases, pricing pages, DeFi protocol pages |
| **Complexity** | Medium-High |

Cards stack on top of each other as user scrolls, each card "pinning" and the next sliding in. Creates depth and progressive disclosure.

---

### 11. Split Screen

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `display: grid; grid-template-columns: 1fr 1fr`, full-height splits, `position: sticky` for one side, independent scroll on each half |
| **Best For** | Before/after comparisons, dual-narrative pages, product vs. competitor |
| **Complexity** | Medium |

Page divided vertically into two halves. One side can be sticky while the other scrolls. Good for contrasting content.

---

### 12. 3D Immersive

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `perspective: 1000px`, `transform-style: preserve-3d`, `transform: rotateX/Y()`, Three.js/React Three Fiber canvas, WebGL shaders |
| **Best For** | GameFi, metaverse projects, high-end product pages |
| **Complexity** | Very High |

Full 3D scenes rendered via Three.js or CSS 3D transforms. Interactive 3D models, particle systems, camera movement on scroll.

---

### 13. Parallax

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `transform: translateY(calc(var(--scroll) * 0.5))`, layered backgrounds at different scroll speeds, `will-change: transform`, GSAP ScrollTrigger with scrub |
| **Best For** | Brand stories, roadmap pages, landing pages |
| **Complexity** | Medium |

Multiple layers move at different speeds during scroll, creating depth illusion. Background, midground, and foreground elements.

---

### 14. Grain & Retro

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `filter: grainy` via SVG noise filter, muted/sepia color palette, serif/typewriter fonts, `border-radius: 0`, vintage textures as overlays |
| **Best For** | Vintage crypto projects, community-driven tokens, nostalgia |
| **Complexity** | Medium |

Film grain overlays, vintage colors, retro typography. Creates warmth and authenticity. Good for projects with a "back to basics" narrative.

---

### 15. Illustrated

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | SVG illustrations as hero elements, hand-drawn border styles, custom illustrated icons, `stroke-dasharray` animations for line drawing effects |
| **Best For** | Community-focused projects, educational platforms, friendly DApps |
| **Complexity** | Medium (depends on illustration quality) |

Custom illustrations replace stock photos. Hand-drawn feel with animated SVG line drawings. Approachable and unique.

---

### 16. Cursor Interaction

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | Custom cursor (`cursor: none` + JS-tracked div), `transform: translate(mouseX, mouseY)`, magnetic buttons, hover ripple effects, cursor trail particles |
| **Best For** | Creative DApps, experimental projects, artist portfolios |
| **Complexity** | High |

Custom cursor that changes shape, leaves trails, or interacts with page elements. Magnetic pull on buttons, distortion effects on hover.

---

### 17. Gradient Mesh

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `background: conic-gradient(...)` layered with `radial-gradient(...)`, animated gradient positions via CSS custom properties, `mix-blend-mode: multiply/screen`, mesh gradient SVGs |
| **Best For** | Token pages, modern crypto, protocol branding |
| **Complexity** | Low-Medium |

Complex multi-color gradient backgrounds that shift and animate. Creates a modern, polished feel. Apple/Stripe-inspired.

---

### 18. Claymorphism

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `border-radius: 24px`, `background: linear-gradient(145deg, #e6e6e6, #ffffff)`, inner shadow + outer shadow combo, pastel colors, soft rounded shapes |
| **Best For** | Casual GameFi, family-friendly projects, playful DApps |
| **Complexity** | Low |

3D clay-like elements with rounded shapes, soft shadows, and pastel colors. Playful and approachable. Like Claymation in UI.

---

### 19. Aurora

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | Animated `radial-gradient` with shifting positions, `filter: blur(80px)` on large color blobs, `mix-blend-mode: screen`, slow CSS keyframe animation on gradient positions |
| **Best For** | AI + crypto projects, ambient backgrounds, premium tokens |
| **Complexity** | Low-Medium |

Soft, shifting color blobs that create an aurora borealis effect. Dreamlike, ethereal backgrounds. Pairs well with glassmorphism cards.

---

### 20. Layered Paper

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | Stacked `box-shadow` layers, subtle rotations (`transform: rotate(1deg)`), `background: #fafaf8` (off-white), tape/clip decorative elements, paper textures |
| **Best For** | Documentation sites, whitepapers, DAO governance pages |
| **Complexity** | Low |

Elements styled as layered paper sheets, slightly rotated, with shadows creating depth. Scholarly, trustworthy feel.

---

### 21. Mondrian Grid

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `display: grid` with asymmetric cells, bold primary colors (red, blue, yellow) with black borders, `border: 4px solid black`, strict grid alignment |
| **Best For** | Art NFT platforms, gallery sites, creative marketplaces |
| **Complexity** | Medium |

Inspired by Piet Mondrian's art. Asymmetric grid with bold primary colors and thick black borders. Artistic and distinctive.

---

### 22. Kinetic Typography

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | GSAP SplitText for character-level animation, `transform: translateY/rotate`, staggered reveals, `overflow: hidden` with `clip-path`, scroll-triggered text animations |
| **Best For** | Launch events, announcements, narrative-driven pages |
| **Complexity** | High |

Text that moves, morphs, and animates as the primary visual element. Characters reveal, rotate, scale, and rearrange.

---

### 23. Organic Shapes

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%` (blob shapes), SVG morphing via GSAP MorphSVG, `clip-path: polygon(...)`, nature-inspired colors |
| **Best For** | Health/green crypto, sustainable blockchain, eco-friendly projects |
| **Complexity** | Medium |

Flowing, blob-like shapes instead of rectangles. Organic curves, nature colors, fluid morphing animations.

---

### 24. Masked Image

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | `clip-path: polygon(...)`, `mask-image: url(shape.svg)`, text as mask (`background-clip: text`), scroll-revealed images through geometric masks |
| **Best For** | NFT showcases, fashion/art crypto, visual-heavy projects |
| **Complexity** | Medium |

Images revealed through shaped masks — circles, hexagons, text cutouts. Dynamic mask transitions on scroll or hover.

---

### 25. Infinite Scroll Gallery

| Field | Detail |
|-------|--------|
| **Key CSS Patterns** | CSS `animation: scroll linear infinite`, duplicated content for seamless loop, `IntersectionObserver` for lazy loading, masonry grid with `columns: 3` |
| **Best For** | NFT collections, portfolio showcases, community galleries |
| **Complexity** | Medium |

Continuously scrolling galleries (horizontal or vertical) that loop infinitely. Auto-scroll with pause on hover. Masonry or grid layout.

---

## Recommended Combinations by Project Type

### Token Official Site
**Primary:** Dark + Neon | **Secondary:** Gradient Mesh
- Neon glow creates crypto-native feel
- Gradient mesh for hero backgrounds
- Combine with Big Typography for key stats

### DApp Dashboard
**Primary:** Bento Grid | **Secondary:** Glassmorphism
- Bento grid for dashboard layout (variable-size widgets)
- Glassmorphism for card overlays on data displays
- Clean, functional, data-dense

### NFT Gallery
**Primary:** Infinite Scroll Gallery | **Secondary:** Dark + Neon
- Infinite gallery for collection browsing
- Dark + Neon for cyberpunk/digital art aesthetic
- Add Masked Image for featured NFTs

### GameFi Project
**Primary:** 3D Immersive | **Secondary:** Aurora
- 3D scenes for game previews and world showcase
- Aurora for ambient backgrounds between sections
- Add Cursor Interaction for playful engagement

### DeFi Protocol
**Primary:** Minimalism | **Secondary:** Card Stacking
- Minimalism for trust and professionalism
- Card stacking for feature/benefit progressive disclosure
- Clean typography, institutional feel

### Meme Token
**Primary:** Brutalism | **Secondary:** Big Typography
- Brutalism for irreverent, attention-grabbing aesthetic
- Big Typography for price, supply, and meme phrases
- High contrast, unapologetic design

### DAO Governance
**Primary:** Layered Paper | **Secondary:** Bento Grid
- Layered paper for documentation/proposal feel
- Bento grid for governance dashboard widgets
- Scholarly, transparent, trustworthy

### AI + Crypto Project
**Primary:** Aurora | **Secondary:** Glassmorphism
- Aurora for ethereal, futuristic AI feel
- Glassmorphism for interface cards
- Soft, luminous, cutting-edge

---

## Complexity Rating Scale

| Rating | Meaning | Dev Effort |
|--------|---------|------------|
| Low | CSS-only, no JS animation required | 1-2 hours |
| Low-Medium | Minimal JS, mostly CSS effects | 2-4 hours |
| Medium | GSAP/Framer Motion for core effects | 4-8 hours |
| Medium-High | Complex scroll interactions, multiple animation layers | 8-16 hours |
| High | Custom interactions, heavy JS, performance tuning needed | 16-24 hours |
| Very High | Three.js/WebGL, shader programming, extensive optimization | 24-40+ hours |
