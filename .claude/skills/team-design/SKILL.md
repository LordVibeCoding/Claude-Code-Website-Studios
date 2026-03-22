---
name: team-design
description: "Assemble design team — ui-ux-lead, visual-designer, interaction-designer, design-system-developer"
tools: Read, Glob, Grep, Write, Edit, Agent
---

# Team Design — Design Development Team

## Purpose
Orchestrate a multi-agent design team for creating cohesive Web3 website visual identity: design system, visual components, interaction patterns, and animation design.

## When to Use
- Establishing visual identity for a new project
- Major design overhaul or style change
- Building or extending the component library
- Implementing a complex design style from the 25 available

## Team Composition

### ui-ux-lead
**Role**: Design direction, user flow design, consistency oversight.
**Responsibilities**:
- Define information architecture and page flow
- Create user journey maps for Web3 interactions
- Ensure consistent UX patterns across pages
- Review designs for usability and accessibility
- Define Web3-specific UX patterns (connect → approve → confirm)

### visual-designer
**Role**: Visual style implementation and brand consistency.
**Responsibilities**:
- Implement chosen design style from 25 options
- Define color palette, typography scale, spacing system
- Create visual hierarchy rules
- Design hero sections and key visual moments
- Ensure brand consistency across all pages
- Select and configure icon library

### interaction-designer
**Role**: Micro-interactions, transitions, and animation choreography.
**Responsibilities**:
- Design GSAP ScrollTrigger sequences
- Create Framer Motion transition choreography
- Define hover, focus, active state animations
- Design loading and skeleton animations
- Create transaction flow animations (pending → success)
- Design page transition patterns
- Implement style-specific interactions:
  - Scroll Storytelling: chapter reveal sequences
  - Cursor Interaction: custom cursor effects
  - Parallax: depth layer configurations
  - Kinetic Typography: text animation timelines

### design-system-developer
**Role**: Design token system and component library maintenance.
**Responsibilities**:
- Build and maintain `src/styles/design-tokens.ts`
- Create CVA component variants in `src/styles/variants.ts`
- Sync design tokens with Tailwind config
- Build base UI components (Button, Card, Input, etc.)
- Build Web3-specific components (AddressDisplay, TokenAmount, etc.)
- Ensure dark mode / theme switching works

## Workflow

### 1. Design Direction (ui-ux-lead)
Define the design approach:
- Which of 25 styles applies?
- What's the brand personality?
- Key pages and their purpose
- User flow through Web3 interactions

### 2. Visual Foundation (visual-designer + design-system-developer)
Work in parallel:
- **visual-designer**: Define colors, fonts, visual rules
- **design-system-developer**: Implement as design tokens + Tailwind config

### 3. Component Library (design-system-developer)
Build base components:
- Start with atoms (Button, Badge, Input)
- Build molecules (Card, FormField, TokenDisplay)
- Build organisms (Header, Hero, SwapWidget)

### 4. Interaction Layer (interaction-designer)
Add motion and interaction:
- Page entrance animations
- Scroll-triggered reveals
- Micro-interactions on interactive elements
- Transaction state animations

### 5. Review & Polish (ui-ux-lead)
- Consistency check across all components
- Responsive verification
- Accessibility audit
- Design system documentation

## Output Format
- Design tokens and Tailwind configuration
- Complete component library
- Animation presets and configs
- Design consistency verified

## Related Skills
`pick-style`, `design-system`, `design-review`, `team-frontend`, `accessibility-check`
