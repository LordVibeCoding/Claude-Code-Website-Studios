# SVG Animated Components Reference Library

Complete, production-ready React + TypeScript implementations of 20 animated SVG component types. All use CSS `@keyframes` (no SMIL), CSS Variables for theming, and `will-change` for GPU acceleration.

---

## 1. ParticleField — Starfield Particle Background

```tsx
import React, { useMemo } from 'react';

interface ParticleFieldProps {
  particleCount?: number;
  color?: string;
  speed?: 'slow' | 'medium' | 'fast';
  className?: string;
}

export const ParticleField: React.FC<ParticleFieldProps> = ({
  particleCount = 60,
  color = 'var(--color-primary, #ffffff)',
  speed = 'medium',
  className = '',
}) => {
  const speedDuration = { slow: 20, medium: 12, fast: 6 };
  const dur = speedDuration[speed];

  const particles = useMemo(
    () =>
      Array.from({ length: particleCount }, (_, i) => ({
        id: i,
        cx: Math.random() * 1920,
        cy: Math.random() * 1080,
        r: Math.random() * 2.5 + 0.3,
        delay: Math.random() * dur,
        dx: (Math.random() - 0.5) * 300,
        dy: (Math.random() - 0.5) * 300,
        opacity: Math.random() * 0.7 + 0.1,
        twinkleDur: 2 + Math.random() * 4,
      })),
    [particleCount, dur]
  );

  return (
    <svg
      viewBox="0 0 1920 1080"
      className={`particle-field ${className}`}
      style={{ width: '100%', height: '100%', position: 'absolute', inset: 0 }}
      preserveAspectRatio="xMidYMid slice"
      aria-hidden="true"
    >
      <style>{`
        .pf-dot {
          will-change: transform, opacity;
        }
        @keyframes pf-drift {
          0%, 100% {
            transform: translate(0, 0);
            opacity: var(--pf-op);
          }
          25% {
            transform: translate(calc(var(--pf-dx) * 0.3), calc(var(--pf-dy) * 0.7));
          }
          50% {
            transform: translate(var(--pf-dx), var(--pf-dy));
            opacity: calc(var(--pf-op) * 1.8);
          }
          75% {
            transform: translate(calc(var(--pf-dx) * 0.5), calc(var(--pf-dy) * 0.2));
          }
        }
        @keyframes pf-twinkle {
          0%, 100% { opacity: var(--pf-op); }
          50%      { opacity: 0.02; }
        }
      `}</style>
      {particles.map((p) => (
        <circle
          key={p.id}
          className="pf-dot"
          cx={p.cx}
          cy={p.cy}
          r={p.r}
          fill={color}
          style={
            {
              '--pf-dx': `${p.dx}px`,
              '--pf-dy': `${p.dy}px`,
              '--pf-op': p.opacity,
              animation: `pf-drift ${dur}s ease-in-out ${p.delay}s infinite, pf-twinkle ${p.twinkleDur}s ease-in-out ${p.delay}s infinite`,
            } as React.CSSProperties
          }
        />
      ))}
    </svg>
  );
};
```

**Usage:**
```tsx
<div style={{ position: 'relative', height: '100vh', background: '#0a0a1a' }}>
  <ParticleField particleCount={80} speed="slow" color="var(--color-primary)" />
  <div style={{ position: 'relative', zIndex: 1 }}>
    {/* Your content */}
  </div>
</div>
```

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| particleCount | number | 60 | Number of particles |
| color | string | `var(--color-primary, #ffffff)` | Particle fill color |
| speed | `'slow' \| 'medium' \| 'fast'` | `'medium'` | Animation speed |
| className | string | `''` | Additional CSS class |

---

## 2. AuroraBackground — Northern Lights Flowing Gradient

```tsx
import React from 'react';

interface AuroraBackgroundProps {
  colors?: [string, string, string];
  intensity?: 'subtle' | 'normal' | 'vivid';
  className?: string;
}

export const AuroraBackground: React.FC<AuroraBackgroundProps> = ({
  colors = [
    'var(--color-primary, #00ff87)',
    'var(--color-secondary, #60efff)',
    'var(--color-accent, #ff00e5)',
  ],
  intensity = 'normal',
  className = '',
}) => {
  const opacityMap = { subtle: 0.2, normal: 0.35, vivid: 0.55 };
  const baseOpacity = opacityMap[intensity];

  return (
    <svg
      viewBox="0 0 1920 1080"
      className={`aurora-bg ${className}`}
      style={{ width: '100%', height: '100%', position: 'absolute', inset: 0 }}
      preserveAspectRatio="xMidYMid slice"
      aria-hidden="true"
    >
      <style>{`
        .aurora-blob {
          will-change: transform;
          mix-blend-mode: screen;
        }
        @keyframes aurora-drift-1 {
          0%   { transform: translate(0, 0) scale(1) rotate(0deg); }
          20%  { transform: translate(180px, -80px) scale(1.15) rotate(5deg); }
          40%  { transform: translate(-100px, 60px) scale(0.95) rotate(-3deg); }
          60%  { transform: translate(220px, 40px) scale(1.1) rotate(8deg); }
          80%  { transform: translate(-60px, -120px) scale(0.9) rotate(-5deg); }
          100% { transform: translate(0, 0) scale(1) rotate(0deg); }
        }
        @keyframes aurora-drift-2 {
          0%   { transform: translate(0, 0) scale(1.1) rotate(0deg); }
          25%  { transform: translate(-200px, 100px) scale(0.85) rotate(-8deg); }
          50%  { transform: translate(150px, -50px) scale(1.25) rotate(6deg); }
          75%  { transform: translate(-120px, -80px) scale(1.0) rotate(-4deg); }
          100% { transform: translate(0, 0) scale(1.1) rotate(0deg); }
        }
        @keyframes aurora-drift-3 {
          0%   { transform: translate(0, 0) scale(0.9) rotate(0deg); }
          30%  { transform: translate(100px, 130px) scale(1.15) rotate(10deg); }
          60%  { transform: translate(-180px, -70px) scale(0.85) rotate(-6deg); }
          100% { transform: translate(0, 0) scale(0.9) rotate(0deg); }
        }
      `}</style>
      <defs>
        <filter id="aurora-blur-heavy">
          <feGaussianBlur stdDeviation="100" />
        </filter>
        <filter id="aurora-blur-medium">
          <feGaussianBlur stdDeviation="70" />
        </filter>
      </defs>
      <rect width="1920" height="1080" fill="transparent" />
      <ellipse
        className="aurora-blob"
        cx="500"
        cy="350"
        rx="550"
        ry="320"
        fill={colors[0]}
        opacity={baseOpacity}
        filter="url(#aurora-blur-heavy)"
        style={{ animation: 'aurora-drift-1 18s ease-in-out infinite' }}
      />
      <ellipse
        className="aurora-blob"
        cx="1300"
        cy="450"
        rx="650"
        ry="280"
        fill={colors[1]}
        opacity={baseOpacity * 0.9}
        filter="url(#aurora-blur-heavy)"
        style={{ animation: 'aurora-drift-2 22s ease-in-out infinite' }}
      />
      <ellipse
        className="aurora-blob"
        cx="900"
        cy="600"
        rx="500"
        ry="380"
        fill={colors[2]}
        opacity={baseOpacity * 0.75}
        filter="url(#aurora-blur-medium)"
        style={{ animation: 'aurora-drift-3 26s ease-in-out infinite' }}
      />
      {/* Secondary smaller blobs for depth */}
      <ellipse
        className="aurora-blob"
        cx="300"
        cy="700"
        rx="300"
        ry="200"
        fill={colors[1]}
        opacity={baseOpacity * 0.5}
        filter="url(#aurora-blur-medium)"
        style={{ animation: 'aurora-drift-2 30s ease-in-out 3s infinite' }}
      />
      <ellipse
        className="aurora-blob"
        cx="1600"
        cy="300"
        rx="350"
        ry="250"
        fill={colors[0]}
        opacity={baseOpacity * 0.4}
        filter="url(#aurora-blur-medium)"
        style={{ animation: 'aurora-drift-3 24s ease-in-out 5s infinite' }}
      />
    </svg>
  );
};
```

**Usage:**
```tsx
<section style={{ position: 'relative', height: '100vh', background: '#050510' }}>
  <AuroraBackground
    colors={['#00ff87', '#60efff', '#a855f7']}
    intensity="vivid"
  />
</section>
```

---

## 3. FloatingBlob — Organic Morphing Shape

```tsx
import React from 'react';

interface FloatingBlobProps {
  color?: string;
  gradientTo?: string;
  size?: number;
  blur?: number;
  className?: string;
}

export const FloatingBlob: React.FC<FloatingBlobProps> = ({
  color = 'var(--color-primary, #6c5ce7)',
  gradientTo = 'var(--color-accent, #a855f7)',
  size = 400,
  blur = 0,
  className = '',
}) => (
  <svg
    viewBox="0 0 400 400"
    className={`floating-blob ${className}`}
    style={{ width: size, height: size }}
    aria-hidden="true"
  >
    <style>{`
      @keyframes blob-morph {
        0% {
          d: path("M200,80 C280,60 360,130 340,200 C320,270 360,350 280,360 C200,370 120,320 100,250 C80,180 120,100 200,80 Z");
        }
        20% {
          d: path("M180,70 C270,50 370,110 350,190 C330,270 370,340 270,370 C170,400 110,330 90,260 C70,190 90,90 180,70 Z");
        }
        40% {
          d: path("M220,90 C290,75 350,150 330,220 C310,290 350,350 270,365 C190,380 110,310 95,240 C80,170 150,105 220,90 Z");
        }
        60% {
          d: path("M190,75 C275,55 365,120 345,195 C325,270 360,345 275,360 C190,375 115,315 95,250 C75,185 105,95 190,75 Z");
        }
        80% {
          d: path("M210,85 C285,65 355,140 335,210 C315,280 345,355 265,365 C185,375 120,310 105,245 C90,180 135,105 210,85 Z");
        }
        100% {
          d: path("M200,80 C280,60 360,130 340,200 C320,270 360,350 280,360 C200,370 120,320 100,250 C80,180 120,100 200,80 Z");
        }
      }
      .blob-path {
        will-change: d;
        animation: blob-morph 10s ease-in-out infinite;
      }
      @keyframes blob-rotate {
        from { transform: rotate(0deg); }
        to   { transform: rotate(360deg); }
      }
      .blob-wrapper {
        transform-origin: 200px 200px;
        animation: blob-rotate 40s linear infinite;
      }
    `}</style>
    <defs>
      {blur > 0 && (
        <filter id="blob-blur-f">
          <feGaussianBlur stdDeviation={blur} />
        </filter>
      )}
      <linearGradient id="blob-lg" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" stopColor={color} />
        <stop offset="100%" stopColor={gradientTo} />
      </linearGradient>
    </defs>
    <g className="blob-wrapper">
      {/* Glow layer */}
      <path
        className="blob-path"
        d="M200,80 C280,60 360,130 340,200 C320,270 360,350 280,360 C200,370 120,320 100,250 C80,180 120,100 200,80 Z"
        fill="url(#blob-lg)"
        opacity="0.3"
        filter={blur > 0 ? 'url(#blob-blur-f)' : undefined}
      />
      {/* Main blob */}
      <path
        className="blob-path"
        d="M200,80 C280,60 360,130 340,200 C320,270 360,350 280,360 C200,370 120,320 100,250 C80,180 120,100 200,80 Z"
        fill="url(#blob-lg)"
        opacity="0.7"
      />
    </g>
  </svg>
);
```

**Usage:**
```tsx
<FloatingBlob color="#6c5ce7" gradientTo="#00cec9" size={500} blur={20} />
```

---

## 4. CryptoRing — Multi-Layer Spinning Tech Rings

```tsx
import React from 'react';

interface CryptoRingProps {
  color?: string;
  size?: number;
  children?: React.ReactNode;
  className?: string;
}

export const CryptoRing: React.FC<CryptoRingProps> = ({
  color = 'var(--color-primary, #00f5d4)',
  size = 400,
  children,
  className = '',
}) => {
  const c = size / 2;
  const ringConfigs = [
    { r: size * 0.44, dash: '3 15', w: 1.2, dur: 25, dir: 'normal' },
    { r: size * 0.38, dash: '25 10 5 10', w: 1.5, dur: 18, dir: 'reverse' },
    { r: size * 0.31, dash: '2 20', w: 2, dur: 30, dir: 'normal' },
    { r: size * 0.25, dash: '10 5 2 5', w: 0.8, dur: 14, dir: 'reverse' },
    { r: size * 0.18, dash: '1 8', w: 1, dur: 22, dir: 'normal' },
  ];

  const ticks = Array.from({ length: 60 }, (_, i) => {
    const angle = (i * 6 * Math.PI) / 180;
    const r1 = size * 0.45;
    const r2 = size * (i % 5 === 0 ? 0.48 : 0.46);
    return {
      x1: c + r1 * Math.cos(angle),
      y1: c + r1 * Math.sin(angle),
      x2: c + r2 * Math.cos(angle),
      y2: c + r2 * Math.sin(angle),
      major: i % 5 === 0,
    };
  });

  return (
    <svg
      viewBox={`0 0 ${size} ${size}`}
      className={`crypto-ring ${className}`}
      style={{ width: size, height: size }}
      aria-hidden="true"
    >
      <style>{`
        .cr-ring {
          fill: none;
          will-change: transform;
          transform-origin: ${c}px ${c}px;
        }
        @keyframes cr-rotate {
          from { transform: rotate(0deg); }
          to   { transform: rotate(360deg); }
        }
        @keyframes cr-glow {
          0%, 100% { filter: drop-shadow(0 0 3px ${color}); opacity: 0.7; }
          50%      { filter: drop-shadow(0 0 10px ${color}); opacity: 1; }
        }
        .cr-outer { animation: cr-glow 4s ease-in-out infinite; }
        @keyframes cr-data-flow {
          from { stroke-dashoffset: 0; }
          to   { stroke-dashoffset: -60; }
        }
      `}</style>
      <g className="cr-outer">
        {/* Tick marks */}
        {ticks.map((t, i) => (
          <line
            key={`t-${i}`}
            x1={t.x1}
            y1={t.y1}
            x2={t.x2}
            y2={t.y2}
            stroke={color}
            strokeWidth={t.major ? 1.5 : 0.5}
            opacity={t.major ? 0.6 : 0.2}
          />
        ))}
        {/* Spinning rings */}
        {ringConfigs.map((ring, i) => (
          <circle
            key={`r-${i}`}
            className="cr-ring"
            cx={c}
            cy={c}
            r={ring.r}
            stroke={color}
            strokeWidth={ring.w}
            strokeDasharray={ring.dash}
            opacity={0.9 - i * 0.1}
            style={{
              animation: `cr-rotate ${ring.dur}s linear infinite ${ring.dir}`,
            }}
          />
        ))}
        {/* Inner data flow ring */}
        <circle
          cx={c}
          cy={c}
          r={size * 0.15}
          fill="none"
          stroke={color}
          strokeWidth="0.5"
          strokeDasharray="4 4"
          opacity="0.4"
          style={{
            transformOrigin: `${c}px ${c}px`,
            animation: 'cr-data-flow 2s linear infinite',
          }}
        />
        {/* Core circle */}
        <circle cx={c} cy={c} r={size * 0.12} fill={color} opacity="0.05" />
      </g>
      {children && (
        <foreignObject
          x={c - size * 0.1}
          y={c - size * 0.1}
          width={size * 0.2}
          height={size * 0.2}
        >
          <div
            style={{
              width: '100%',
              height: '100%',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            {children}
          </div>
        </foreignObject>
      )}
    </svg>
  );
};
```

**Usage:**
```tsx
<CryptoRing size={500} color="#00f5d4">
  <img src="/token.png" alt="Token" style={{ width: 48, height: 48 }} />
</CryptoRing>
```

---

## 5. CircuitLines — Circuit Board Signal Flow

```tsx
import React, { useMemo } from 'react';

interface CircuitLinesProps {
  color?: string;
  lineCount?: number;
  signalSpeed?: number;
  className?: string;
}

export const CircuitLines: React.FC<CircuitLinesProps> = ({
  color = 'var(--color-primary, #00ff88)',
  lineCount = 10,
  signalSpeed = 3,
  className = '',
}) => {
  const circuits = useMemo(
    () => [
      { d: 'M80,180 L280,180 L280,380 L480,380 L480,280 L680,280', nodes: [[280,180],[280,380],[480,380],[480,280]] },
      { d: 'M1840,80 L1640,80 L1640,280 L1440,280 L1440,480 L1240,480', nodes: [[1640,80],[1640,280],[1440,280],[1440,480]] },
      { d: 'M180,820 L380,820 L380,620 L580,620 L580,720 L880,720', nodes: [[380,820],[380,620],[580,620],[580,720]] },
      { d: 'M1740,920 L1540,920 L1540,720 L1340,720 L1340,620 L1140,620', nodes: [[1540,920],[1540,720],[1340,720],[1340,620]] },
      { d: 'M80,520 L230,520 L230,370 L430,370 L430,570 L630,570', nodes: [[230,520],[230,370],[430,370],[430,570]] },
      { d: 'M1840,420 L1670,420 L1670,570 L1470,570 L1470,470 L1270,470', nodes: [[1670,420],[1670,570],[1470,570],[1470,470]] },
      { d: 'M280,980 L480,980 L480,880 L680,880 L680,980 L930,980', nodes: [[480,980],[480,880],[680,880],[680,980]] },
      { d: 'M960,80 L960,230 L1100,230 L1100,380 L960,380 L960,530', nodes: [[960,230],[1100,230],[1100,380],[960,380]] },
      { d: 'M120,50 L320,50 L320,150 L520,150 L520,50 L720,50', nodes: [[320,50],[320,150],[520,150],[520,50]] },
      { d: 'M1200,900 L1400,900 L1400,800 L1600,800 L1600,900 L1800,900', nodes: [[1400,900],[1400,800],[1600,800],[1600,900]] },
    ],
    []
  );

  return (
    <svg
      viewBox="0 0 1920 1080"
      className={`circuit-lines ${className}`}
      style={{ width: '100%', height: '100%', position: 'absolute', inset: 0 }}
      preserveAspectRatio="xMidYMid slice"
      aria-hidden="true"
    >
      <style>{`
        .cl-base {
          fill: none;
          stroke-width: 1;
          stroke-linecap: square;
          stroke-linejoin: miter;
        }
        .cl-signal {
          fill: none;
          stroke-width: 2;
          stroke-linecap: round;
          will-change: stroke-dashoffset;
        }
        @keyframes cl-flow {
          from { stroke-dashoffset: 0; }
          to   { stroke-dashoffset: -120; }
        }
        .cl-node {
          will-change: opacity;
        }
        @keyframes cl-blink {
          0%, 100% { opacity: 0.2; }
          50%      { opacity: 1; }
        }
      `}</style>
      <defs>
        <filter id="cl-glow-f">
          <feGaussianBlur stdDeviation="3" />
        </filter>
      </defs>
      {circuits.slice(0, lineCount).map((circuit, i) => (
        <g key={i}>
          {/* Base static line */}
          <path
            className="cl-base"
            d={circuit.d}
            stroke={color}
            opacity="0.1"
          />
          {/* Glow underlay */}
          <path
            className="cl-signal"
            d={circuit.d}
            stroke={color}
            opacity="0.3"
            strokeDasharray="15 105"
            filter="url(#cl-glow-f)"
            style={{
              animation: `cl-flow ${signalSpeed + i * 0.4}s linear ${i * 0.25}s infinite`,
            }}
          />
          {/* Signal line */}
          <path
            className="cl-signal"
            d={circuit.d}
            stroke={color}
            opacity="0.8"
            strokeDasharray="15 105"
            style={{
              animation: `cl-flow ${signalSpeed + i * 0.4}s linear ${i * 0.25}s infinite`,
            }}
          />
          {/* Junction nodes */}
          {circuit.nodes.map(([nx, ny], j) => (
            <g key={`n-${i}-${j}`}>
              <circle
                cx={nx}
                cy={ny}
                r="5"
                fill={color}
                opacity="0.15"
                filter="url(#cl-glow-f)"
              />
              <circle
                className="cl-node"
                cx={nx}
                cy={ny}
                r="2.5"
                fill={color}
                style={{
                  animation: `cl-blink ${1.5 + j * 0.3}s ease-in-out ${i * 0.2 + j * 0.4}s infinite`,
                }}
              />
            </g>
          ))}
        </g>
      ))}
    </svg>
  );
};
```

**Usage:**
```tsx
<div style={{ position: 'relative', height: '100vh', background: '#0a0a0a' }}>
  <CircuitLines color="#00ff88" lineCount={8} signalSpeed={2.5} />
</div>
```

---

## 6. WaveDivider — Multi-Layer Wave Section Separator

```tsx
import React from 'react';

interface WaveDividerProps {
  colors?: [string, string, string];
  height?: number;
  flip?: boolean;
  speed?: 'slow' | 'medium' | 'fast';
  className?: string;
}

export const WaveDivider: React.FC<WaveDividerProps> = ({
  colors = [
    'var(--color-primary, #1a1a3e)',
    'var(--color-secondary, #2a1a4e)',
    'var(--color-accent, #3a1a5e)',
  ],
  height = 200,
  flip = false,
  speed = 'medium',
  className = '',
}) => {
  const speedMap = { slow: [30, 22, 16], medium: [20, 15, 10], fast: [12, 9, 6] };
  const [s1, s2, s3] = speedMap[speed];

  return (
    <svg
      viewBox="0 0 3840 200"
      className={`wave-divider ${className}`}
      style={{
        width: '100%',
        height,
        display: 'block',
        transform: flip ? 'scaleY(-1)' : 'none',
      }}
      preserveAspectRatio="none"
      aria-hidden="true"
    >
      <style>{`
        .wd-layer { will-change: transform; }
        @keyframes wd-slide {
          from { transform: translateX(0); }
          to   { transform: translateX(-1920px); }
        }
      `}</style>
      {/* Back layer */}
      <g className="wd-layer" style={{ animation: `wd-slide ${s1}s linear infinite` }}>
        <path
          fill={colors[0]}
          opacity="0.5"
          d="M0,110 C240,70 480,150 720,110 C960,70 1200,150 1440,110 C1680,70 1920,150 2160,110 C2400,70 2640,150 2880,110 C3120,70 3360,150 3600,110 C3840,70 3840,200 3840,200 L0,200 Z"
        />
      </g>
      {/* Mid layer */}
      <g className="wd-layer" style={{ animation: `wd-slide ${s2}s linear infinite` }}>
        <path
          fill={colors[1]}
          opacity="0.65"
          d="M0,135 C240,105 480,165 720,135 C960,105 1200,165 1440,135 C1680,105 1920,165 2160,135 C2400,105 2640,165 2880,135 C3120,105 3360,165 3600,135 C3840,105 3840,200 3840,200 L0,200 Z"
        />
      </g>
      {/* Front layer */}
      <g className="wd-layer" style={{ animation: `wd-slide ${s3}s linear infinite reverse` }}>
        <path
          fill={colors[2]}
          opacity="0.85"
          d="M0,160 C240,140 480,180 720,160 C960,140 1200,180 1440,160 C1680,140 1920,180 2160,160 C2400,140 2640,180 2880,160 C3120,140 3360,180 3600,160 C3840,140 3840,200 3840,200 L0,200 Z"
        />
      </g>
    </svg>
  );
};
```

**Usage:**
```tsx
<WaveDivider height={180} speed="slow" flip={false} />
{/* Content section */}
<WaveDivider height={180} speed="slow" flip={true} />
```

---

## 7. GlowGrid — Perspective Grid Floor with Pulsing Nodes

```tsx
import React, { useMemo } from 'react';

interface GlowGridProps {
  color?: string;
  rows?: number;
  cols?: number;
  className?: string;
}

export const GlowGrid: React.FC<GlowGridProps> = ({
  color = 'var(--color-primary, #0ff)',
  rows = 15,
  cols = 20,
  className = '',
}) => {
  const vanishY = 480;
  const bottomY = 1080;
  const horizonSpread = 1920;

  const horizontalLines = useMemo(
    () =>
      Array.from({ length: rows }, (_, i) => {
        const t = i / (rows - 1);
        const y = vanishY + t * (bottomY - vanishY);
        const spread = t * horizonSpread;
        return {
          x1: 960 - spread / 2,
          y1: y,
          x2: 960 + spread / 2,
          y2: y,
          opacity: 0.03 + t * 0.2,
        };
      }),
    [rows]
  );

  const verticalLines = useMemo(
    () =>
      Array.from({ length: cols }, (_, i) => {
        const x = (i / (cols - 1)) * 1920;
        return { x1: 960, y1: vanishY, x2: x, y2: bottomY };
      }),
    [cols]
  );

  const nodes = useMemo(
    () =>
      Array.from({ length: 30 }, (_, i) => {
        const row = Math.floor(i / 6);
        const col = i % 6;
        const t = (row + 1) / 6;
        const y = vanishY + t * (bottomY - vanishY);
        const spread = t * horizonSpread;
        const x = 960 - spread / 2 + (col / 5) * spread;
        return { x, y, delay: Math.random() * 4, dur: 2 + Math.random() * 3 };
      }),
    []
  );

  return (
    <svg
      viewBox="0 0 1920 1080"
      className={`glow-grid ${className}`}
      style={{ width: '100%', height: '100%', position: 'absolute', inset: 0 }}
      preserveAspectRatio="xMidYMid slice"
      aria-hidden="true"
    >
      <style>{`
        @keyframes gg-pulse {
          0%, 100% { opacity: 0; r: 1.5; }
          50%      { opacity: 0.9; r: 4; }
        }
        .gg-node { will-change: opacity, r; }
        @keyframes gg-scan-h {
          0%, 100% { opacity: var(--gg-op); }
          50%      { opacity: calc(var(--gg-op) * 2.5); }
        }
        .gg-hline { will-change: opacity; }
      `}</style>
      <defs>
        <filter id="gg-glow">
          <feGaussianBlur stdDeviation="4" />
        </filter>
      </defs>
      {/* Vertical converging lines */}
      {verticalLines.map((l, i) => (
        <line
          key={`v-${i}`}
          x1={l.x1}
          y1={l.y1}
          x2={l.x2}
          y2={l.y2}
          stroke={color}
          strokeWidth="0.4"
          opacity="0.08"
        />
      ))}
      {/* Horizontal lines */}
      {horizontalLines.map((l, i) => (
        <line
          key={`h-${i}`}
          className="gg-hline"
          x1={l.x1}
          y1={l.y1}
          x2={l.x2}
          y2={l.y2}
          stroke={color}
          strokeWidth="0.5"
          style={{
            '--gg-op': l.opacity,
            opacity: l.opacity,
            animation: `gg-scan-h 5s ease-in-out ${i * 0.3}s infinite`,
          } as React.CSSProperties}
        />
      ))}
      {/* Glow nodes at intersections */}
      {nodes.map((n, i) => (
        <g key={`n-${i}`}>
          <circle
            cx={n.x}
            cy={n.y}
            r="6"
            fill={color}
            opacity="0.15"
            filter="url(#gg-glow)"
            className="gg-node"
            style={{ animation: `gg-pulse ${n.dur}s ease-in-out ${n.delay}s infinite` }}
          />
          <circle
            className="gg-node"
            cx={n.x}
            cy={n.y}
            r="1.5"
            fill={color}
            style={{ animation: `gg-pulse ${n.dur}s ease-in-out ${n.delay}s infinite` }}
          />
        </g>
      ))}
    </svg>
  );
};
```

**Usage:**
```tsx
<div style={{ position: 'relative', height: '100vh', background: '#000' }}>
  <GlowGrid color="#0ff" rows={12} cols={16} />
</div>
```

---

## 8. TokenPulse — Expanding Ring Pulse Effect

```tsx
import React from 'react';

interface TokenPulseProps {
  color?: string;
  size?: number;
  ringCount?: number;
  pulseSpeed?: number;
  children?: React.ReactNode;
  className?: string;
}

export const TokenPulse: React.FC<TokenPulseProps> = ({
  color = 'var(--color-primary, #00f5d4)',
  size = 300,
  ringCount = 4,
  pulseSpeed = 3,
  children,
  className = '',
}) => {
  const center = size / 2;
  const maxR = center * 0.85;
  const coreR = center * 0.15;

  return (
    <svg
      viewBox={`0 0 ${size} ${size}`}
      className={`token-pulse ${className}`}
      style={{ width: size, height: size }}
      aria-hidden="true"
    >
      <style>{`
        @keyframes tp-expand {
          0% {
            r: ${coreR};
            opacity: 0.7;
            stroke-width: 2.5;
          }
          100% {
            r: ${maxR};
            opacity: 0;
            stroke-width: 0.3;
          }
        }
        .tp-ring {
          fill: none;
          will-change: r, opacity, stroke-width;
        }
        @keyframes tp-core-breathe {
          0%, 100% {
            opacity: 0.5;
            filter: drop-shadow(0 0 4px ${color});
          }
          50% {
            opacity: 1;
            filter: drop-shadow(0 0 15px ${color});
          }
        }
        .tp-core {
          will-change: opacity, filter;
          animation: tp-core-breathe 2s ease-in-out infinite;
        }
      `}</style>
      {/* Expanding pulse rings */}
      {Array.from({ length: ringCount }, (_, i) => (
        <circle
          key={i}
          className="tp-ring"
          cx={center}
          cy={center}
          r={coreR}
          stroke={color}
          style={{
            animation: `tp-expand ${pulseSpeed}s ease-out ${
              i * (pulseSpeed / ringCount)
            }s infinite`,
          }}
        />
      ))}
      {/* Core glow */}
      <circle
        className="tp-core"
        cx={center}
        cy={center}
        r={coreR * 1.5}
        fill={color}
        opacity="0.1"
      />
      {/* Core solid */}
      <circle
        className="tp-core"
        cx={center}
        cy={center}
        r={coreR}
        fill={color}
        opacity="0.3"
      />
      {/* Inner detail ring */}
      <circle
        cx={center}
        cy={center}
        r={coreR * 0.7}
        fill="none"
        stroke={color}
        strokeWidth="0.5"
        strokeDasharray="2 3"
        opacity="0.5"
      />
      {children && (
        <foreignObject
          x={center - coreR}
          y={center - coreR}
          width={coreR * 2}
          height={coreR * 2}
        >
          <div
            style={{
              width: '100%',
              height: '100%',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            {children}
          </div>
        </foreignObject>
      )}
    </svg>
  );
};
```

**Usage:**
```tsx
<TokenPulse size={400} color="#00f5d4" ringCount={5} pulseSpeed={2.5}>
  <span style={{ fontSize: 24, fontWeight: 'bold', color: '#00f5d4' }}>$TOKEN</span>
</TokenPulse>
```

---

## Additional Components (Summary Implementations)

### 9. GeometricPulse — Rotating Polygon Rings

Same pattern as CryptoRing but with polygon shapes (hexagons, triangles, squares) instead of circles. Uses `transform: rotate()` with different speeds per layer. Each polygon ring has a unique stroke-dasharray pattern.

### 10. WaveMountain — Layered Mountain Silhouettes

3-5 overlapping `<path>` elements shaped as mountain ranges. Each path uses `translateX` animation at different speeds for parallax effect. Back layers are more transparent and slower.

### 11. NoiseGradient — Animated Noise Texture

Uses `<feTurbulence>` filter with animated `baseFrequency` values. Overlays a radial gradient with slow rotation animation. The noise layer is composited at low opacity (0.1-0.2) over the gradient.

### 12. HexField — Floating Geometric Fragments

Generates 15-30 random geometric shapes (triangles, hexagons, diamonds) as `<path>` elements. Each shape has unique `translate + rotate` keyframes with random delays. All shapes are wireframe (stroke-only) at low opacity.

### 13. PerspectiveGrid — 3D Ground Grid

Vertical lines converge to a vanishing point. Horizontal lines increase in spacing and width as they move toward the viewer. Node points at intersections pulse with staggered delays.

### 14. SlashDivider — Angled Section Cut

A `<polygon>` creates the angled surface. A `<line>` along the cut edge uses `stroke-dasharray` + `stroke-dashoffset` animation for a sweeping glow effect.

### 15. ParticleTransition — Particle Band Separator

A horizontal band (150-200px tall) filled with particles that float upward. Uses `translateY` animation with random delays. A `linearGradient` overlay fades the band edges to transparent.

### 16. MouseGlow — Cursor Light Effect

Uses `onMouseMove` event handler to update a `<circle>` position with a radial gradient fill. The circle position updates via `ref` for performance (no state re-render). Applies smooth `transition` for fluid movement.

### 17. HoverScale — Interactive Hover Elements

Grid of hexagonal `<polygon>` elements. CSS `:hover` pseudo-class triggers `transform: scale(1.5)` with `transition`. A glow `<circle>` with blur filter fades in on hover. No JavaScript needed for the interaction.

### 18. ScrollDraw — Scroll-Activated Path Drawing

Uses `IntersectionObserver` or scroll position calculation to determine draw progress. Sets `stroke-dashoffset` proportional to (1 - progress). Multiple paths at different offsets create a cascading reveal effect.

### 19. PriceChart — Animated Chart Line

Converts data array to SVG path coordinates. Uses `stroke-dasharray` + `stroke-dashoffset` animation for a drawing-in effect. An area fill path with gradient fades in with a delay.

### 20. BlockchainNodes — Connected Network Graph

Generates random node positions. Connects nodes within a distance threshold using `<line>` elements. Lines pulse in opacity. Nodes pulse in size. The overall effect suggests a living network.

---

---

## Animation Libraries Integration

除了纯 SVG + CSS 动画，以下 npm 库也是建站必备工具：

### Vivus — SVG 路径绘制动画
```tsx
// src/components/svg/SvgDrawAnimation.tsx
"use client";
import { useEffect, useRef } from "react";
import Vivus from "vivus";

interface SvgDrawAnimationProps {
  svgId: string;
  duration?: number;
  type?: "delayed" | "sync" | "oneByOne";
  className?: string;
}

export function SvgDrawAnimation({
  svgId,
  duration = 200,
  type = "delayed",
  className = "",
}: SvgDrawAnimationProps) {
  const initialized = useRef(false);

  useEffect(() => {
    if (initialized.current) return;
    initialized.current = true;
    new Vivus(svgId, { duration, type, animTimingFunction: Vivus.EASE });
  }, [svgId, duration, type]);

  return <div id={svgId} className={className} />;
}
```

**适用场景**：Logo 入场、图标绘制入场、路线图节点连线

### Lottie-web — JSON 动画播放器
```tsx
// src/components/svg/LottieAnimation.tsx
"use client";
import { useEffect, useRef } from "react";
import lottie, { type AnimationItem } from "lottie-web";

interface LottieAnimationProps {
  animationData: object;
  loop?: boolean;
  autoplay?: boolean;
  className?: string;
  style?: React.CSSProperties;
}

export function LottieAnimation({
  animationData,
  loop = true,
  autoplay = true,
  className = "",
  style,
}: LottieAnimationProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const animRef = useRef<AnimationItem | null>(null);

  useEffect(() => {
    if (!containerRef.current) return;
    animRef.current = lottie.loadAnimation({
      container: containerRef.current,
      renderer: "svg",
      loop,
      autoplay,
      animationData,
    });
    return () => { animRef.current?.destroy(); };
  }, [animationData, loop, autoplay]);

  return <div ref={containerRef} className={className} style={style} aria-hidden="true" />;
}
```

**适用场景**：复杂序列动画、交易成功/失败动效、空状态插画

### React Three Fiber — 3D 场景（按需）
```tsx
// src/components/svg/Scene3D.tsx
"use client";
import { Canvas } from "@react-three/fiber";
import { OrbitControls, Float } from "@react-three/drei";

interface Scene3DProps {
  className?: string;
  children: React.ReactNode;
}

export function Scene3D({ className = "", children }: Scene3DProps) {
  return (
    <div className={className} style={{ width: "100%", height: "100%" }}>
      <Canvas camera={{ position: [0, 0, 5], fov: 50 }}>
        <ambientLight intensity={0.5} />
        <pointLight position={[10, 10, 10]} />
        <Float speed={2} rotationIntensity={0.5} floatIntensity={1}>
          {children}
        </Float>
        <OrbitControls enableZoom={false} autoRotate autoRotateSpeed={0.5} />
      </Canvas>
    </div>
  );
}
```

**适用场景**：GameFi/Metaverse 项目 Hero 区、3D 代币展示、沉浸式背景

### 动画库选用决策表

| 需求 | 推荐方案 | 说明 |
|------|---------|------|
| Logo/图标入场 | vivus | SVG 路径绘制，轻量 |
| 复杂序列动画 | lottie-web | AE 导出 JSON，流畅 |
| 3D 装饰/GameFi | react-three-fiber | WebGL 3D 渲染 |
| 滚动驱动动画 | GSAP ScrollTrigger | 时间线精确控制 |
| 组件入场/退出 | Framer Motion | React 原生，简洁 |
| 背景粒子/流动 | 纯 SVG + CSS | 本文件中的组件 |
| 交互悬浮/脉冲 | 纯 SVG + CSS | CryptoRing, TokenPulse |

---

## 3D 玻璃素材集成（可选 — 需用户自行配置素材库）

若用户在 `.style-config.json` 中配置了 `assetsLibraryPath`，可从本地素材库选取 3D 玻璃装饰素材。
**未配置则跳过此部分，仅使用 SVG 动效 + 动画库。**

**配置方法**：在项目 `.style-config.json` 中添加 `"assetsLibraryPath": "/your/path/to/assets"`
素材库目录需包含 `.catalog/index.json` 和 `.catalog/sheets/` 联系表。

### GlassDecor 组件模板
```tsx
// src/components/ui/GlassDecor.tsx
import Image from "next/image";

interface GlassDecorProps {
  src: string;
  alt?: string;
  size?: number;
  className?: string;
  float?: boolean;
  glow?: boolean;
}

export function GlassDecor({
  src,
  alt = "",
  size = 400,
  className = "",
  float = true,
  glow = false,
}: GlassDecorProps) {
  return (
    <div
      className={`pointer-events-none ${float ? "glass-float" : ""} ${glow ? "chrome-glow" : ""} ${className}`}
      aria-hidden="true"
    >
      <Image
        src={src}
        alt={alt}
        width={size}
        height={size}
        loading="lazy"
        quality={85}
      />
    </div>
  );
}
```

### 素材选用策略（仅在配置了素材库时生效）

| 网站类型 | 首选分类 | 备选 |
|----------|---------|------|
| Web3/DeFi | 627W镭射玻璃, 1237镀铬形状 | 704W科幻晶体 |
| GameFi | 704W科幻晶体, 627W镭射玻璃 | 1237镀铬形状 |
| NFT | 447A艺术玻璃, 5082立体抽象 | 627W镭射玻璃 |
| SaaS/Infrastructure | G314透明玻璃, 35Y玻璃晶体 | 503抽象立体金属 |
| Meme | 5082立体抽象, Abstract Shapes | 751W艺术图形 |

> 注：以上分类名称仅供参考，实际分类取决于用户素材库内容。

---

## Accessibility

All decorative SVGs must include `aria-hidden="true"`. For animations, respect the user's `prefers-reduced-motion` setting:

```css
@media (prefers-reduced-motion: reduce) {
  .particle-field *, .aurora-bg *, .floating-blob *,
  .crypto-ring *, .circuit-lines *, .glow-grid *,
  .token-pulse *, .wave-divider * {
    animation-duration: 0s !important;
    transition-duration: 0s !important;
  }
}
```

## Performance Checklist

- [ ] Only animate `transform`, `opacity`, `stroke-dashoffset`, `d` (path)
- [ ] Use `will-change` on animated elements
- [ ] Keep particle counts under 100 (50 for mobile)
- [ ] Use `preserveAspectRatio="xMidYMid slice"` for fullscreen backgrounds
- [ ] Lazy-load below-fold SVGs with `IntersectionObserver`
- [ ] Total SVG file size under 100KB each
- [ ] Use `useMemo` for generated data arrays
- [ ] Add `aria-hidden="true"` to decorative SVGs
