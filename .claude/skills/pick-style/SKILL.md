---
name: pick-style
description: "Interactive style picker — present 25 design styles, generate style configuration"
tools: Read, Write, Edit, AskUserQuestion
---

# Pick Style — Design Style Selector

## Purpose
Present all 25 available design styles with descriptions and visual characteristics, let user choose, then generate a complete style configuration (colors, fonts, spacing, animations, component variants).

## When to Use
- Starting a new project and need design direction
- User wants to change/update the visual style
- Comparing design approaches for a Web3 site

## Step-by-Step Workflow

### 1. Present Style Categories
Group the 25 styles by vibe and present via `AskUserQuestion`:

**Motion & Scroll**
1. **Scroll Storytelling** — Narrative sections revealed on scroll, GSAP ScrollTrigger, chapter-based flow
2. **Horizontal Scroll** — Lateral page navigation, panel-based content, mouse wheel hijack
3. **Parallax** — Multi-layer depth movement, foreground/background speed difference
4. **Card Stacking** — Overlapping cards that fan out on scroll, z-index animation
5. **Infinite Scroll Gallery** — Endlessly loading visual grid, masonry layout, intersection observer

**Visual & Surface**
6. **Glassmorphism** — Frosted glass, backdrop-blur, subtle borders, transparency layers
7. **Neumorphism** — Soft extruded UI, inner/outer shadows, monochrome palette
8. **Dark+Neon** — Dark backgrounds, vibrant neon glows, cyberpunk aesthetic
9. **Gradient Mesh** — Complex multi-color gradients, mesh backgrounds, fluid color
10. **Aurora** — Northern lights color shifts, animated gradient waves, ethereal
11. **Claymorphism** — Soft 3D clay-like elements, rounded, pastel shadows
12. **Grain&Retro** — Film grain overlay, vintage colors, retro typography

**Layout & Structure**
13. **Bento Grid** — Asymmetric grid boxes, varied sizes, content dashboard feel
14. **Split Screen** — Dual-panel layouts, contrasting content sides
15. **Mondrian Grid** — Geometric blocks, primary colors, art-inspired grid
16. **Layered Paper** — Stacked paper-like sections, subtle shadows, depth

**Typography & Interaction**
17. **Big Typography** — Oversized headings, type as hero element, minimal imagery
18. **Kinetic Typography** — Animated text, letter-by-letter reveals, text morphing
19. **Cursor Interaction** — Custom cursors, hover effects, mouse-following elements
20. **Brutalism** — Raw, unpolished, bold borders, system fonts, anti-design

**Artistic & Organic**
21. **Minimalism** — Whitespace-heavy, essential elements only, clean lines
22. **3D Immersive** — Three.js/R3F scenes, 3D model integration, spatial
23. **Illustrated** — Hand-drawn elements, custom illustrations, playful
24. **Organic Shapes** — Blob shapes, fluid borders, natural curves, SVG morphing
25. **Masked Image** — Shape-masked images, clip-path reveals, creative cropping

### 2. Get User Selection
Allow user to pick 1 primary style and optionally 1 secondary style for mixing.

### 3. Generate Style Configuration
Create `src/styles/design-tokens.ts`:
```typescript
export const designTokens = {
  style: 'dark-neon', // selected style ID
  colors: { primary, secondary, accent, background, surface, text, muted },
  fonts: { heading, body, mono },
  spacing: { section, container, gap },
  borderRadius: { sm, md, lg, xl },
  shadows: { sm, md, lg, glow },
  animations: { duration, easing, stagger },
}
```

### 4. Generate Tailwind Theme Extension
Update `tailwind.config.ts` with style-specific:
- Color palette with CSS variables
- Font family stack
- Custom animations and keyframes
- Box shadow presets
- Border radius scale

### 5. Generate Animation Config
Create `src/styles/animations.ts`:
- GSAP ScrollTrigger presets per style
- Framer Motion variants (enter, exit, hover, tap)
- Page transition configs
- Reusable animation hooks

### 6. Generate Component Variants
Create `src/styles/variants.ts` using CVA:
- Button variants matching style
- Card variants
- Input/form field variants
- Badge/tag variants

## Output Format
- `src/styles/design-tokens.ts` — Complete token set
- `tailwind.config.ts` — Updated theme
- `src/styles/animations.ts` — Animation presets
- `src/styles/variants.ts` — CVA component variants

## Related Skills
`new-site`, `design-system`, `design-review`
