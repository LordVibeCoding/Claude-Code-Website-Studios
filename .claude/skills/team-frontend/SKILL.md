---
name: team-frontend
description: "Assemble frontend team — frontend-lead, react-developer, animation-developer, responsive-developer, performance-optimizer"
tools: Read, Glob, Grep, Write, Edit, Bash, Agent
---

# Team Frontend — Frontend Development Team

## Purpose
Orchestrate a multi-agent frontend team for building Web3 website UI: component development, animations, responsive layouts, and performance optimization working in parallel.

## When to Use
- Building a new page or major UI feature
- Implementing a complex animation sequence
- Full responsive overhaul
- Frontend performance sprint

## Team Composition

### frontend-lead
**Role**: Coordinates work, defines component architecture, ensures consistency.
**Responsibilities**:
- Break page into component tree
- Define props interfaces and data flow
- Ensure design system compliance
- Review team output for consistency

### react-developer
**Role**: Core component and page implementation.
**Responsibilities**:
- Build page components in `src/components/`
- Implement custom hooks in `src/hooks/`
- Setup data fetching with React Query + wagmi
- Handle state management and form logic
- Implement error boundaries and loading states

### animation-developer
**Role**: GSAP and Framer Motion animations.
**Responsibilities**:
- Implement GSAP ScrollTrigger sequences
- Build Framer Motion page transitions
- Create micro-interactions (hover, click, focus)
- Implement style-specific animations (parallax, scroll storytelling, etc.)
- Ensure `prefers-reduced-motion` fallbacks

### responsive-developer
**Role**: Cross-device compatibility.
**Responsibilities**:
- Mobile-first responsive implementation (320px → 1536px)
- Touch interaction support
- Mobile navigation (hamburger menu, bottom nav)
- Verify wallet UI works on mobile browsers
- Test on real device viewports

### performance-optimizer
**Role**: Frontend performance optimization.
**Responsibilities**:
- Implement dynamic imports for heavy components
- Optimize images with `next/image`
- Setup proper Server/Client component boundaries
- Reduce bundle size (tree-shaking, code splitting)
- Optimize animation frame rate

## Workflow

### 1. Task Assignment (frontend-lead)
Break the feature into parallel workstreams:
```
Page: Token Swap
├── react-developer: SwapForm, TokenSelector, PriceDisplay, SlippageSettings
├── animation-developer: Page entrance, token flip animation, success confetti
├── responsive-developer: Mobile swap card, touch-friendly inputs
└── performance-optimizer: Lazy load chart, optimize token list rendering
```

### 2. Parallel Execution
Launch agents in parallel using `Agent` tool:
- Each agent works on their assigned components
- All agents reference the same design tokens
- All agents follow the same coding standards

### 3. Integration (frontend-lead)
- Merge all components into the page
- Verify data flow between components
- Test full user flow end-to-end
- Run `code-review` on assembled feature

### 4. Quality Check
- All components render without errors
- Animations run at 60fps
- Responsive on all breakpoints
- Lighthouse performance score > 90
- Accessibility check passes

## Output Format
- Complete page/feature implementation
- Components, hooks, animations, responsive layouts
- Performance optimized and tested

## Related Skills
`design-system`, `pick-style`, `team-design`, `perf-profile`, `code-review`
