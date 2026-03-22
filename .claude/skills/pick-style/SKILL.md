---
name: pick-style
description: "Interactive style picker — present 25 design styles, load real style presets into project"
tools: Read, Write, Edit, AskUserQuestion, Glob, Bash
---

# Pick Style — Design Style Selector

## Purpose
Present all 25 available design styles with descriptions, let user choose, then **load real style preset files** from `~/.claude/styles-presets/` into the project. Every component built after this step MUST use the loaded preset — no default/generic styles allowed.

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

### 3. Load Real Style Preset（核心步骤）

用户选择风格后，**必须**读取并加载对应的预设文件：

#### 3.1 读取预设文件
```
读取文件：~/.claude/styles-presets/{序号}-{风格名}.md
示例：~/.claude/styles-presets/08-dark-neon.md
```

风格序号与名称映射表：
| 序号 | 文件名 |
|------|--------|
| 01 | 01-scroll-storytelling.md |
| 02 | 02-horizontal-scroll.md |
| 03 | 03-parallax.md |
| 04 | 04-card-stacking.md |
| 05 | 05-infinite-scroll-gallery.md |
| 06 | 06-glassmorphism.md |
| 07 | 07-neumorphism.md |
| 08 | 08-dark-neon.md |
| 09 | 09-gradient-mesh.md |
| 10 | 10-aurora.md |
| 11 | 11-claymorphism.md |
| 12 | 12-grain-retro.md |
| 13 | 13-bento-grid.md |
| 14 | 14-split-screen.md |
| 15 | 15-mondrian-grid.md |
| 16 | 16-layered-paper.md |
| 17 | 17-big-typography.md |
| 18 | 18-kinetic-typography.md |
| 19 | 19-cursor-interaction.md |
| 20 | 20-brutalism.md |
| 21 | 21-minimalism.md |
| 22 | 22-3d-immersive.md |
| 23 | 23-illustrated.md |
| 24 | 24-organic-shapes.md |
| 25 | 25-masked-image.md |

**如果预设文件不存在，报错并停止，不得使用默认样式替代。**

#### 3.2 解析预设文件并写入项目

预设文件包含以下 4 个区块，必须全部写入项目：

**A. CSS Variables → `src/styles/globals.css`**
- 将预设中 `## CSS Variables` 区块的内容写入 `src/styles/globals.css` 的 `:root` 和 `[data-theme="dark"]` 中
- 如果文件已存在，合并而非覆盖

**B. Tailwind Config Extension → `tailwind.config.ts`**
- 将预设中 `## Tailwind Config Extension` 区块的配置合并到 `tailwind.config.ts` 的 `theme.extend` 中
- 保留项目已有的 Tailwind 配置，只合并新增的部分

**C. Core CSS Classes → `src/styles/style-preset.css`**
- 将预设中 `## Core CSS Classes` 区块的内容写入 `src/styles/style-preset.css`
- 这是风格专属的 CSS 类，组件开发必须使用
- 在 `globals.css` 中 `@import './style-preset.css'`

**D. Component Patterns → 注入上下文**
- 将预设中 `## Component Patterns` 区块的代码作为参考模式注入当前会话上下文
- 后续所有组件开发**必须参考**这些模式代码
- 不得使用默认/通用/大众化的组件样式

#### 3.3 创建风格配置文件

在项目根目录创建 `.style-config.json`：
```json
{
  "styleId": 8,
  "styleName": "dark-neon",
  "styleDisplayName": "Dark+Neon",
  "primaryColor": "#从预设中提取",
  "accentColor": "#从预设中提取",
  "secondaryStyle": null,
  "presetFile": "08-dark-neon.md",
  "loadedAt": "2024-01-01T00:00:00Z",
  "presetSections": {
    "cssVariables": true,
    "tailwindConfig": true,
    "coreClasses": true,
    "componentPatterns": true
  }
}
```

### 4. Generate Design Tokens
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
**颜色值必须从预设文件提取，不得使用默认值。**

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

**所有 variant 必须基于预设中的 Component Patterns，不得使用通用样式。**

## Output Files
- `.style-config.json` — 风格配置记录
- `src/styles/globals.css` — CSS Variables（从预设加载）
- `src/styles/style-preset.css` — 风格专属 CSS 类（从预设加载）
- `tailwind.config.ts` — 合并预设的 Tailwind 扩展
- `src/styles/design-tokens.ts` — Design tokens（从预设提取）
- `src/styles/animations.ts` — Animation presets
- `src/styles/variants.ts` — CVA component variants（基于预设模式）

## 强制规则
1. **必须加载真实预设文件** — 不得跳过、不得用默认值替代
2. **预设文件不存在 = 报错停止** — 提示用户创建预设文件
3. **所有颜色/样式/组件模式必须来自预设** — 不得自行发挥
4. **后续组件开发必须参考预设中的 Component Patterns**
5. **代码审查时检查风格一致性** — 与 `.style-config.json` 中记录的风格对比

## Related Skills
`new-site`, `design-system`, `design-review`, `team-frontend`, `team-design`
