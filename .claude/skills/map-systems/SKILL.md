---
name: map-systems
description: "Map system dependencies — analyze codebase, create dependency graph, identify coupling"
tools: Read, Glob, Grep, Bash
---

# Map Systems — System Dependency Mapping

## Purpose
Analyze the Web3 website codebase to create a comprehensive dependency graph: module relationships, contract-to-frontend bindings, shared state, and coupling analysis.

## When to Use
- Understanding a new or unfamiliar codebase
- Before major refactoring
- Identifying impact radius of changes
- Detecting circular dependencies or tight coupling
- Architecture documentation

## Step-by-Step Workflow

### 1. File Structure Inventory
Scan the project structure:
```bash
find src/ -type f -name "*.ts" -o -name "*.tsx" | head -200
find contracts/ -type f -name "*.sol" 2>/dev/null | head -50
```
Categorize files by domain:
- Pages (`src/app/`)
- Components (`src/components/`)
- Hooks (`src/hooks/`)
- Contract integration (`src/contracts/`)
- Utilities (`src/lib/`)
- Config (`src/config/`)
- Contracts (`contracts/`)

### 2. Import Analysis
For each key file, trace imports to build dependency graph:
- Which components does each page import?
- Which hooks do components depend on?
- Which contract hooks do features use?
- Which utilities are shared across features?

Detect patterns:
```
Page → Components → Hooks → Contract Hooks → ABIs
  ↓        ↓          ↓
Layout   Design    Web3 Lib
Tokens   Utilities
```

### 3. Contract-Frontend Binding Map
Trace the full chain from contract to UI:
```markdown
| Contract | ABI File | Hook | Component | Page |
|----------|----------|------|-----------|------|
| Token.sol | token.json | useTokenBalance | TokenStats | / |
| Staking.sol | staking.json | useStake | StakeForm | /staking |
| NFT.sol | nft.json | useMint | MintCard | /mint |
```

### 4. Shared State Map
Identify shared state and data flow:
- wagmi config → all Web3 components
- React Query cache → all data-fetching hooks
- Design tokens → all styled components
- User wallet state → conditional rendering everywhere

### 5. Coupling Analysis
Identify problematic coupling:

**Tight Coupling (RED)**:
- Component directly reads contract ABI
- Page contains business logic
- Multiple components reading same contract independently (should share hook)
- Hardcoded addresses in components

**Moderate Coupling (YELLOW)**:
- Component depends on specific data shape from hook
- Page imports from multiple feature domains
- Shared utilities with feature-specific logic

**Loose Coupling (GREEN)**:
- Components accept data via props
- Hooks encapsulate all Web3 logic
- Features communicate through well-defined interfaces

### 6. Circular Dependency Detection
Check for circular imports:
```bash
# Look for potential circular patterns
npx madge --circular src/
```
Or manually trace import chains that form loops.

### 7. Impact Radius Analysis
For key files, determine blast radius if changed:
```markdown
| File Changed | Direct Dependents | Indirect Dependents | Risk |
|-------------|-------------------|---------------------|------|
| design-tokens.ts | 45 components | All pages | HIGH |
| wagmi.ts | 12 hooks | 30 components | HIGH |
| Token ABI | 3 hooks | 8 components | MEDIUM |
| Button.tsx | 0 | 0 | LOW |
```

### 8. Generate System Map
```markdown
## System Dependency Map — {date}

### Architecture Layers
```
┌─────────────────────────────────────┐
│ Pages (src/app/)                    │
├─────────────────────────────────────┤
│ Feature Components (src/components/)│
├──────────────┬──────────────────────┤
│ UI Components│ Web3 Components      │
├──────────────┼──────────────────────┤
│ Custom Hooks │ Contract Hooks       │
├──────────────┼──────────────────────┤
│ Utilities    │ Web3 Lib + ABIs      │
├──────────────┴──────────────────────┤
│ Config (wagmi, chains, tokens)      │
└─────────────────────────────────────┘
```

### Contract-Frontend Bindings
[Table from step 3]

### Coupling Report
| Area | Score | Issues |

### Circular Dependencies
[List or "None found"]

### High-Impact Files (change carefully)
[Table from step 7]

### Recommendations
1. Decouple suggestions
2. Missing abstraction layers
3. Refactoring opportunities
```

## Output Format
- Layer diagram of system architecture
- Contract-to-UI binding map
- Coupling analysis with scores
- Impact radius for key files
- Refactoring recommendations

## Related Skills
`code-review`, `tech-debt`, `sprint-plan`, `team-frontend`, `team-web3`
