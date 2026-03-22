# Sprint Plan: [Sprint Name / Number]

**Sprint Goal:** [One sentence describing what this sprint delivers]
**Duration:** YYYY-MM-DD to YYYY-MM-DD ([X] weeks)
**Producer:** [Name]
**Status:** Planning | Active | Complete | Cancelled

---

## Sprint Goal

_What is the single most important outcome of this sprint?_

[Clear, measurable goal — e.g., "Users can connect wallet, view token balance, and execute a swap on BSC Testnet"]

---

## User Stories

### Story 1: [Story Title]

**As a** [user type],
**I want to** [action],
**So that** [benefit].

**Acceptance Criteria:**
- [ ] [Criterion 1 — specific, testable]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

**Priority:** P0 (Must) | P1 (Should) | P2 (Nice to have)
**Estimate:** [X] story points / [X] hours

---

### Story 2: [Story Title]

**As a** [user type],
**I want to** [action],
**So that** [benefit].

**Acceptance Criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Priority:** P0 | P1 | P2
**Estimate:** [X] story points

---

## Tasks

### Frontend Tasks

| # | Task | Story | Agent Assignment | Estimate | Status |
|---|------|-------|-----------------|----------|--------|
| F1 | [Task description] | Story 1 | React Developer | [X]h | TODO |
| F2 | [Task description] | Story 1 | Animation Developer | [X]h | TODO |
| F3 | [Task description] | Story 2 | Responsive Developer | [X]h | TODO |

### Smart Contract Tasks

| # | Task | Story | Agent Assignment | Estimate | Status |
|---|------|-------|-----------------|----------|--------|
| C1 | [Task description] | Story 1 | Solidity Developer | [X]h | TODO |
| C2 | [Task description] | Story 1 | Contract Auditor | [X]h | TODO |

### Web3 Integration Tasks

| # | Task | Story | Agent Assignment | Estimate | Status |
|---|------|-------|-----------------|----------|--------|
| W1 | [Task description] | Story 1 | Wallet Integration Dev | [X]h | TODO |
| W2 | [Task description] | Story 2 | Blockchain Developer | [X]h | TODO |

### Design Tasks

| # | Task | Story | Agent Assignment | Estimate | Status |
|---|------|-------|-----------------|----------|--------|
| D1 | [Task description] | Story 1 | Visual Designer | [X]h | TODO |
| D2 | [Task description] | Story 1 | Design System Developer | [X]h | TODO |

### QA Tasks

| # | Task | Story | Agent Assignment | Estimate | Status |
|---|------|-------|-----------------|----------|--------|
| Q1 | [Task description] | Story 1 | QA Tester | [X]h | TODO |
| Q2 | [Task description] | Story 2 | E2E Tester | [X]h | TODO |

---

## Agent Team Assignments

| Team | Lead | Specialists | Focus |
|------|------|-------------|-------|
| `/team-frontend` | Frontend Lead | React Dev, Animation Dev, Responsive Dev | UI implementation |
| `/team-contract` | Smart Contract Lead | Solidity Dev, Contract Auditor | Contract development |
| `/team-web3` | Web3 Lead | Wallet Dev, Blockchain Dev | Chain integration |
| `/team-design` | UI/UX Lead | Visual Designer, Design System Dev | Design execution |

---

## Dependencies

| Task | Depends On | Blocking | Notes |
|------|-----------|----------|-------|
| W1 (wallet connect) | C1 (contract deployed to testnet) | Yes | Cannot test integration without contract |
| F2 (animations) | D1 (design specs) | Yes | Need design specs before animating |
| Q2 (E2E tests) | F1 + W1 (feature complete) | Yes | E2E requires working feature |
| [Task] | [Dependency] | Yes/No | [Notes] |

### Critical Path

```
D1 (design) → F1 (implement) → W1 (integrate) → Q2 (test) → Release
                                     ↑
C1 (contract) ───────────────────────┘
```

---

## Risks

| Risk | Probability | Impact | Mitigation | Owner |
|------|-----------|--------|------------|-------|
| [Risk 1: e.g., BSC testnet instability] | Medium | Medium | Use local Hardhat fork as fallback | DevOps Lead |
| [Risk 2: e.g., Design changes mid-sprint] | Low | High | Lock design specs by Day 2 | Creative Director |
| [Risk 3: e.g., Contract audit findings] | Medium | High | Budget time for fixes in sprint | Smart Contract Lead |

---

## Definition of Done

A story is "Done" when:
- [ ] Code is implemented and passes linting
- [ ] Unit tests written and passing (80%+ coverage)
- [ ] Code reviewed by relevant Lead
- [ ] Works on mobile and desktop
- [ ] Wallet connected and disconnected states handled
- [ ] Error states handled with user-friendly messages
- [ ] Accessibility checked (keyboard nav, contrast)
- [ ] Merged to development branch

---

## Daily Standup Format

Each team reports:
1. **Done yesterday:** [Completed tasks]
2. **Doing today:** [Planned tasks]
3. **Blockers:** [What's preventing progress]

---

## Sprint Velocity

| Sprint | Planned Points | Completed Points | Velocity |
|--------|---------------|-----------------|----------|
| Previous | [X] | [X] | [X]% |
| This Sprint | [X] | — | — |

---

## Sprint Review Notes

_[Filled at end of sprint]_

### Completed
- [ ] [Story/Task completed]

### Carried Over
- [ ] [Story/Task not completed — reason]

### Unplanned Work
- [ ] [Unplanned tasks added during sprint — reason]

### Retrospective Action Items
1. [What to improve next sprint]
2. [Process change]
3. [Tool/resource need]

---

_Plan created by: [Producer]_
_Approved by: [Technical Director]_
