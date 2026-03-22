# Agent Coordination Map

## Hierarchy Diagram

```
                            ┌─────────┐
                            │  USER   │
                            └────┬────┘
                                 │
                    ┌────────────┼────────────┐
                    │            │            │
              ┌─────▼─────┐ ┌───▼────┐ ┌─────▼──────┐
              │ Creative   │ │Producer│ │ Technical  │
              │ Director   │ │        │ │ Director   │
              │  (Opus)    │ │ (Opus) │ │  (Opus)    │
              └─────┬──────┘ └───┬────┘ └─────┬──────┘
                    │            │            │
         ┌─────────┤        Coordinates      ├──────────────────────┐
         │         │         All Teams        │                     │
    ┌────▼───┐     │                    ┌─────▼─────┐         ┌────▼─────┐
    │ UI/UX  │     │                    │ Frontend  │         │ DevOps   │
    │ Lead   │     │                    │ Lead      │         │ Lead     │
    └───┬────┘     │                    └─────┬─────┘         └────┬─────┘
        │          │                          │                    │
   ┌────┤     ┌────▼─────┐    ┌───────────┬───┤              ┌────┤
   │    │     │ Content  │    │           │   │              │    │
   │    │     │ Lead     │    │           │   │              │    │
   │    │     └────┬─────┘    │           │   │              │    │
   │    │          │          │           │   │              │    │
Vis. Inter. Des.  SEO Copy Loc. React Anim. Resp. Perf.  DevOps Anal.
Des. Des.  Sys.   Spec.  Spec.  Dev   Dev   Dev   Opt.   Eng.  Eng.
                                │
                    ┌───────────┼───────────┐
                    │                       │
              ┌─────▼─────┐          ┌─────▼─────┐
              │Smart Cont.│          │   Web3    │
              │   Lead    │          │   Lead    │
              └─────┬─────┘          └─────┬─────┘
                    │                      │
              ┌─────┼─────┐          ┌─────┼─────┐
              │     │     │          │     │     │
           Solid. Cont. Token     Wallet Block. Sub.  NFT
           Dev   Aud.  Eng.      Int.   Dev   Dev   Dev
                  DeFi Dev

              ┌─────▼─────┐          ┌─────▼─────┐
              │  QA Lead  │          │ Security  │
              │           │          │   Lead    │
              └─────┬─────┘          └─────┬─────┘
                    │                      │
              ┌─────┼─────┐              Security
              │     │     │              Auditor
           QA    E2E   Access.
           Test  Test  Spec.
```

## Delegation Patterns

### Vertical Delegation (Top-Down)

```
Director → Lead → Specialist
```

- Directors set strategy and quality bars
- Leads translate strategy into tasks and coordinate specialists
- Specialists execute implementation work
- Results flow back up: Specialist → Lead → Director for review

### Horizontal Consultation (Peer-to-Peer)

Leads and specialists at the same tier can consult each other, but **cannot override** decisions in another domain.

| From | Can Consult | Common Scenarios |
|------|------------|-----------------|
| Frontend Lead | Smart Contract Lead | ABI shape, event formats, function signatures |
| Frontend Lead | Web3 Lead | Wallet connection UX, transaction states |
| Smart Contract Lead | Security Lead | Vulnerability patterns, audit requirements |
| Web3 Lead | Frontend Lead | Component integration, data display patterns |
| UI/UX Lead | Frontend Lead | Component feasibility, animation performance |
| Content Lead | UI/UX Lead | Copy layout, typography requirements |
| QA Lead | All Leads | Test coverage requirements, test data needs |

## Escalation Paths

### When to Escalate

| Situation | Escalate To |
|-----------|-------------|
| Design vision conflicts with technical feasibility | Producer (mediates Creative Director + Technical Director) |
| Two leads disagree on implementation approach | Their shared parent Director |
| Scope creep detected | Producer |
| Security vulnerability found | Security Lead → Technical Director |
| Performance budget exceeded | Technical Director |
| Timeline at risk | Producer |
| Contract changes affect frontend | Producer (coordinates Smart Contract Lead + Frontend Lead) |

### Escalation Flow

```
Specialist conflict → Lead resolves
Lead conflict (same dept) → Director resolves
Lead conflict (cross-dept) → Producer coordinates
Director conflict → Producer mediates with User input
Unresolvable → User makes final call
```

## Domain Boundaries

Each agent has strict file ownership. Agents should NOT modify files outside their domain.

| Domain | Owner(s) | Files |
|--------|----------|-------|
| `src/site/**` | Frontend Lead, React Developer | Page components, layouts, SEO |
| `src/dapp/**` | Frontend Lead, Web3 Lead | DApp pages, wallet-aware components |
| `src/contracts/**` | Smart Contract Lead, Solidity Developer | Solidity files, ABIs, deploy scripts |
| `src/components/**` | UI/UX Lead, Design System Developer | Shared components, design tokens |
| `src/hooks/**` | Frontend Lead, React Developer | Custom React hooks |
| `src/lib/**` | Technical Director, various specialists | Utilities, config, constants |
| `src/styles/**` | UI/UX Lead, Visual Designer | Global styles, theme config |
| `design/**` | Creative Director, UI/UX Lead | Design docs, wireframes |
| `tests/**` | QA Lead, QA Tester, E2E Tester | All test files |
| `production/**` | Producer | Sprint plans, milestones, releases |
| `.claude/` | Technical Director | Studio configuration |

## Communication Patterns

### 1. Request-Response

Standard task delegation pattern:

```
Lead assigns task → Specialist executes → Specialist returns result → Lead reviews
```

### 2. Broadcast

When a change affects multiple teams:

```
Producer identifies cross-team impact
  → Notifies all affected Leads
  → Each Lead coordinates within their department
  → Producer verifies alignment
```

### 3. Gate Review

Quality checkpoints before progression:

```
Sprint Phase 1 (Foundation)
  → Design Review Gate: Creative Director approval
Sprint Phase 2 (Core Build)
  → Technical Review Gate: Technical Director approval
Sprint Phase 3 (Integration)
  → Integration Test Gate: QA Lead approval
Sprint Phase 4 (Polish & Launch)
  → Launch Gate: All Leads sign off
```

### 4. Advisory

Non-binding guidance across domains:

```
Security Lead advises Frontend Lead on CSP headers
  → Frontend Lead decides implementation approach
  → Security Lead verifies result
```

## Conflict Resolution Rules

1. **Same-domain conflict** — the domain's Lead decides
2. **Cross-domain conflict** — Producer mediates, escalates to Directors if needed
3. **Design vs. Technical** — Producer mediates between Creative Director and Technical Director
4. **Security overrides** — Security Lead can BLOCK any release; cannot be overridden by other Leads
5. **Scope vs. Quality** — Producer decides trade-offs with User input
6. **User always wins** — any conflict the User explicitly resolves is final, no re-escalation

## Team Assembly (Slash Commands)

| Command | Agents Assembled | Purpose |
|---------|-----------------|---------|
| `/team-frontend` | Frontend Lead, React Dev, Animation Dev, Responsive Dev, Performance Opt. | Frontend feature implementation |
| `/team-contract` | Smart Contract Lead, Solidity Dev, Contract Auditor, Token Engineer | Contract development and audit |
| `/team-design` | Creative Director, UI/UX Lead, Visual Designer, Interaction Designer, Design System Dev | Design system and visual direction |
| `/team-web3` | Web3 Lead, Wallet Integration Dev, Blockchain Dev, Subgraph Dev, NFT Dev | Blockchain integration |
| `/team-release` | Producer, DevOps Lead, QA Lead, Security Lead | Release coordination |
| `/team-polish` | QA Lead, E2E Tester, Accessibility Spec., Performance Opt., SEO Spec. | Pre-launch quality pass |
