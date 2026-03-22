---
path:
  - "design/**"
---

# Design Document Standards

## Required Sections

Every design document in `design/` MUST include the following sections. Documents missing required sections will be flagged by the `validate-commit` hook.

### Template Structure

```markdown
# [Feature/Page Name]

## Overview

Brief description of what this feature/page does and why it exists.
Link to any relevant product requirements or user research.

- **Goal**: What user problem does this solve?
- **Success Metric**: How do we measure success?
- **Priority**: P0/P1/P2/P3

## User Persona

Who is this designed for? Reference specific personas.

| Attribute     | Description                                    |
|---------------|------------------------------------------------|
| Name          | e.g., "DeFi Dave" or "NFT Newcomer Nancy"      |
| Technical     | Crypto-native / Web3-curious / Non-technical    |
| Goal          | What they want to accomplish                    |
| Pain Point    | What frustrates them with current solutions     |
| Device        | Desktop / Mobile / Both                         |

## User Flow

Step-by-step interaction flow. Use numbered steps.

1. User lands on [page]
2. User sees [element/state]
3. User clicks [action]
4. System responds with [result]
5. User reaches [outcome]

### Error Flows

Document what happens when things go wrong:
- Wallet not connected
- Wrong network
- Transaction rejected
- Insufficient funds
- Contract error / revert

## Wireframes

Low-fidelity wireframes or descriptions of the layout.

### Desktop Layout
[Describe or link wireframe]

### Mobile Layout
[Describe or link wireframe]

### Key States
- Empty state (no data)
- Loading state
- Error state
- Success state
- Populated state

## Design Decisions

Document key decisions and their rationale.

| Decision                  | Choice         | Rationale                            |
|---------------------------|----------------|--------------------------------------|
| e.g., Primary CTA color  | Indigo (#6366f1)| High contrast, accessible, on-brand |
| e.g., Wallet connection   | Modal          | Users expect modal pattern           |
| e.g., Transaction feedback| Toast + page   | Ensures visibility on all viewports  |

### Alternatives Considered

For each major decision, briefly note what was considered and rejected:

- **Option A**: [Description] — Rejected because [reason]
- **Option B**: [Description] — Rejected because [reason]
- **Chosen**: [Description] — Selected because [reason]

## Accessibility Notes

Specific accessibility considerations for this feature.

- **Keyboard Navigation**: [How users navigate without a mouse]
- **Screen Reader**: [What ARIA labels/roles are needed]
- **Color Contrast**: [Any contrast concerns and mitigations]
- **Motion**: [Animations that need reduced-motion alternatives]
- **Focus Management**: [Where focus moves during interactions]

### WCAG Checklist

- [ ] All text meets 4.5:1 contrast (AA)
- [ ] Interactive elements have visible focus indicators
- [ ] Images have descriptive alt text
- [ ] Form inputs have associated labels
- [ ] Error messages are announced to screen readers
- [ ] No content is conveyed by color alone
```

## Cross-References

Design documents should link to related technical documents:

```markdown
## Related Documents

- **Technical Spec**: [link to docs/technical-spec.md]
- **API Design**: [link to docs/api-design.md]
- **Contract Spec**: [link to docs/contract-spec.md]
- **Test Plan**: [link to tests/README.md]
```

## Naming Convention

Design doc files should follow the pattern:

```
design/
  homepage.md
  mint-page.md
  marketplace.md
  wallet-connection.md
  token-dashboard.md
```

Use kebab-case filenames that match the feature or page name.

## Review Process

Before a design doc is considered complete:

1. All required sections are filled (not just headings with "TBD")
2. At least one user flow is fully documented
3. Error states are documented
4. Accessibility notes are specific (not generic boilerplate)
5. Design decisions include rationale (not just the choice)
