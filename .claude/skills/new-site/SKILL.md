---
name: new-site
description: "Create official website — brand setup, style selection, page structure generation"
tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion
---

# New Site — Official Website Generator

## Purpose
Create a complete Web3 brand website with Next.js 15, chosen design style, responsive layout, and optional wallet integration.

## When to Use
- User wants a landing page, brand site, or product showcase
- Building an official site for a Web3 project on BNB Chain

## Step-by-Step Workflow

### 1. Gather Brand Information
Ask via `AskUserQuestion`:
- Project name and tagline
- Industry/niche (DeFi, GameFi, SocialFi, Infrastructure, DAO)
- Brand colors (primary, secondary, accent) or "generate for me"
- Logo file path or "create placeholder"
- Target audience description

### 2. Select Design Style
Invoke `pick-style` to present 25 styles. Recommend styles by niche:
- **DeFi**: Dark+Neon, Glassmorphism, Aurora, Gradient Mesh
- **GameFi**: 3D Immersive, Scroll Storytelling, Parallax, Cursor Interaction
- **SocialFi**: Bento Grid, Minimalism, Big Typography, Organic Shapes
- **Infrastructure**: Brutalism, Neumorphism, Split Screen, Mondrian Grid
- **DAO**: Layered Paper, Card Stacking, Kinetic Typography

### 3. Define Page Structure
Generate pages based on project type:
```
src/app/
  page.tsx           — Hero + value proposition
  about/page.tsx     — Team, mission, roadmap
  features/page.tsx  — Product features showcase
  tokenomics/page.tsx — Token distribution (if applicable)
  community/page.tsx — Social links, DAO governance
  docs/page.tsx      — Documentation links
  layout.tsx         — Root layout with nav + footer
```

### 4. Generate Components
Create in `src/components/`:
- `Header.tsx` — Navigation with wallet connect button
- `Hero.tsx` — Above-the-fold section with CTA
- `Features.tsx` — Feature grid/cards
- `Stats.tsx` — On-chain stats display
- `CTA.tsx` — Call-to-action sections
- `Footer.tsx` — Links, social, legal

### 5. Apply Design Style
- Generate `src/styles/design-tokens.ts` with colors, fonts, spacing
- Configure `tailwind.config.ts` with custom theme
- Add animation configs for GSAP/Framer Motion per chosen style
- Create style-specific utility classes

### 6. Setup SEO
- Generate `metadata` exports in each page
- Create `sitemap.ts` and `robots.ts`
- Add Open Graph images config
- Setup structured data (JSON-LD)

## Output Format
- Complete Next.js page structure
- Design tokens and Tailwind config
- Component library scaffolded
- SEO meta configured

## Related Skills
`pick-style`, `setup-stack`, `design-system`, `seo-check`
