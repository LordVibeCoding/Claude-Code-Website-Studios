---
name: gen-svg
description: "Generate large animated SVG assets — hero backgrounds, decorative elements, section dividers, and interactive graphics"
tools: Read, Write, Glob, Grep, AskUserQuestion, Agent
---

# gen-svg Skill

Generate visually impactful, large-scale animated SVG components for web projects. Every output is a production-ready React + TypeScript component.

## Workflow

### Step 1: Read Project Style

```
Read .style-config.json from project root
Extract: primary colors, style theme, brand identity
If no config found → ask user for preferred style
```

Style-to-SVG mapping:

| Style Theme | Recommended SVGs |
|-------------|-----------------|
| dark-neon | ParticleField, CircuitLines, GlowGrid, CryptoRing, TokenPulse |
| glassmorphism | AuroraBackground, FloatingBlob, WaveDivider |
| aurora | AuroraBackground, WaveMountain, NoiseGradient |
| brutalism | GeometricPulse (hard keyframes), SlashDivider, HexField |
| 3d-immersive | PerspectiveGrid, GeometricPulse, BlockchainNodes |
| minimalism | ParticleField (low density), WaveDivider (subtle), MouseGlow |
| cyberpunk | CircuitLines, GlowGrid, PerspectiveGrid, CryptoRing |

### Step 2: Ask User What They Need

Present these options:

```
需要生成什么类型的 SVG 动画素材？

A) Hero 全屏动态背景
   - ParticleField（星空粒子）
   - AuroraBackground（极光流动）
   - GeometricPulse（几何脉冲环）
   - WaveMountain（波浪山脉轮廓）
   - NoiseGradient（噪点渐变）

B) 装饰性大元素
   - FloatingBlob（有机形状变形）
   - CryptoRing（加密光环旋转）
   - HexField（浮动几何碎片）
   - CircuitLines（电路板线条动画）
   - PerspectiveGrid（3D透视网格）

C) Section 分隔器
   - WaveDivider（多层波浪）
   - SlashDivider（斜切+动画边缘）
   - ParticleTransition（粒子过渡带）

D) 交互式 SVG
   - MouseGlow（鼠标跟随光效）
   - HoverScale（悬浮响应）
   - ScrollDraw（滚动触发绘制）

E) Token/Crypto 专用
   - TokenPulse（代币脉冲）
   - PriceChart（价格图表动画）
   - BlockchainNodes（区块链节点连线）
   - WalletConnectPulse（钱包连接效果）

F) 全套（以上全部）
```

### Step 3: Generate via Agent

Invoke the `svg-motion-designer` agent with:
- Selected SVG types
- Project style theme and colors
- Target directory path
- Any customization requirements (colors, speed, density)

Reference the component templates in `~/.claude/styles-presets/svg-components.md` for implementation patterns.

### Step 4: Write Components

Output directory structure:
```
src/components/svg/
├── backgrounds/
│   ├── ParticleField.tsx
│   ├── AuroraBackground.tsx
│   ├── GeometricPulse.tsx
│   ├── WaveMountain.tsx
│   └── NoiseGradient.tsx
├── decorative/
│   ├── FloatingBlob.tsx
│   ├── CryptoRing.tsx
│   ├── HexField.tsx
│   ├── CircuitLines.tsx
│   └── PerspectiveGrid.tsx
├── dividers/
│   ├── WaveDivider.tsx
│   ├── SlashDivider.tsx
│   └── ParticleTransition.tsx
├── interactive/
│   ├── MouseGlow.tsx
│   ├── HoverScale.tsx
│   └── ScrollDraw.tsx
├── crypto/
│   ├── TokenPulse.tsx
│   ├── PriceChart.tsx
│   ├── BlockchainNodes.tsx
│   └── WalletConnectPulse.tsx
└── index.ts
```

Each component file must:
- Have a typed props interface with sensible defaults
- Use CSS Variables for all colors (`var(--color-primary, #fallback)`)
- Use CSS `@keyframes` animations (no SMIL)
- Include `will-change` for GPU acceleration
- Be under 100KB
- Work standalone without external dependencies

### Step 5: Generate Index

Create `src/components/svg/index.ts`:

```typescript
// Backgrounds
export { ParticleField } from './backgrounds/ParticleField';
export { AuroraBackground } from './backgrounds/AuroraBackground';
export { GeometricPulse } from './backgrounds/GeometricPulse';
export { WaveMountain } from './backgrounds/WaveMountain';
export { NoiseGradient } from './backgrounds/NoiseGradient';

// Decorative
export { FloatingBlob } from './decorative/FloatingBlob';
export { CryptoRing } from './decorative/CryptoRing';
export { HexField } from './decorative/HexField';
export { CircuitLines } from './decorative/CircuitLines';
export { PerspectiveGrid } from './decorative/PerspectiveGrid';

// Dividers
export { WaveDivider } from './dividers/WaveDivider';
export { SlashDivider } from './dividers/SlashDivider';
export { ParticleTransition } from './dividers/ParticleTransition';

// Interactive
export { MouseGlow } from './interactive/MouseGlow';
export { HoverScale } from './interactive/HoverScale';
export { ScrollDraw } from './interactive/ScrollDraw';

// Crypto
export { TokenPulse } from './crypto/TokenPulse';
export { PriceChart } from './crypto/PriceChart';
export { BlockchainNodes } from './crypto/BlockchainNodes';
export { WalletConnectPulse } from './crypto/WalletConnectPulse';
```

### Step 6: Provide Usage Examples

```tsx
// Hero section with particle background + mouse glow
import { ParticleField, MouseGlow } from '@/components/svg';

export const HeroSection = () => (
  <section style={{ position: 'relative', height: '100vh', overflow: 'hidden' }}>
    <ParticleField particleCount={80} speed="slow" />
    <MouseGlow radius={300} />
    <div style={{ position: 'relative', zIndex: 1 }}>
      <h1>Your Content Here</h1>
    </div>
  </section>
);

// Section with wave divider
import { WaveDivider } from '@/components/svg';

export const SectionBreak = () => (
  <>
    <section>Content above</section>
    <WaveDivider height={150} />
    <section>Content below</section>
  </>
);

// Token display with pulse + ring
import { TokenPulse, CryptoRing } from '@/components/svg';

export const TokenHero = () => (
  <div style={{ position: 'relative', display: 'flex', justifyContent: 'center' }}>
    <CryptoRing size={500}>
      <img src="/token-logo.png" alt="Token" width={60} height={60} />
    </CryptoRing>
  </div>
);
```

## CSS Variables Contract

Host pages must define these CSS variables for the SVG components to adapt:

```css
:root {
  --color-primary: #00f5d4;
  --color-secondary: #60efff;
  --color-accent: #ff00e5;
  --color-bg: #0a0a1a;
}
```

## Performance Guidelines

- Prefer `transform` and `opacity` for animations (GPU-composited)
- Use `will-change: transform` on animated elements
- Keep particle counts under 100 for mobile
- Lazy-load SVGs below the fold with IntersectionObserver
- Consider `prefers-reduced-motion` media query for accessibility

## Trigger Words

This skill activates on: `svg`, `动画背景`, `粒子`, `波浪`, `光环`, `视觉素材`, `hero背景`, `section分隔`, `装饰元素`, `generate svg`, `gen-svg`
