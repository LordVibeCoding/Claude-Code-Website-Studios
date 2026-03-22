# Hooks Reference — All 8 Hooks

## Overview

Hooks are shell scripts that run at specific lifecycle events in the Claude Code session. They enforce quality gates, load context, and maintain audit trails.

Configured in `.claude/settings.json` under the `hooks` key.

---

## Hook List

### 1. validate-commit.sh

| Field | Value |
|-------|-------|
| **Trigger** | PreToolUse (Bash) — intercepts `git commit` commands |
| **File** | `.claude/hooks/validate-commit.sh` |
| **Status** | Implemented |

**What it validates:**

| Check | Severity | Description |
|-------|----------|-------------|
| Hardcoded secrets | BLOCK | Private keys (0x + 64 hex), mnemonics (12-word phrases), API keys (sk_live_, AKIA), PEM keys |
| Hardcoded addresses | WARN | Contract addresses (0x + 40 hex) not assigned to a constant |
| TODO attribution | WARN | `TODO` or `FIXME` without `(name)` format — e.g., `TODO(alice)` |
| JSON validity | BLOCK | Invalid JSON files in `src/` (validated via python3 or jq) |
| Hardcoded gas | WARN | `.gas(number)` or `gasLimit: number` in Solidity files |
| console.log | WARN | `console.log/debug/info` in `src/site/` and `src/dapp/` production code |
| Design doc sections | WARN | Design docs in `design/` missing required sections: Overview, User Persona, User Flow |

**Customizing strictness:**
- Change WARN to BLOCK by replacing `add_warning` with `add_error` for the relevant check
- Change BLOCK to WARN by replacing `add_error` with `add_warning`
- Disable a check by commenting out its section (lines between `# ---` separators)

**Disabling:**
- Remove the PreToolUse hook entry from `.claude/settings.json`
- Or rename the file: `mv validate-commit.sh validate-commit.sh.disabled`

---

### 2. validate-push.sh

| Field | Value |
|-------|-------|
| **Trigger** | PreToolUse (Bash) — intercepts `git push` commands |
| **File** | `.claude/hooks/validate-push.sh` |
| **Status** | Implemented |

**What it validates:**

| Check | Severity | Description |
|-------|----------|-------------|
| Protected branch push | WARN | Pushing directly to `main` or `master` |
| Unreviewed contracts | WARN | `.sol` files changed but not listed in `production/contract-reviews.md` |
| Test pass | BLOCK | Runs `pnpm test` (or npm/yarn) before allowing push |
| Hardhat tests | BLOCK | If `.sol` files changed and `hardhat.config.*` exists, runs `npx hardhat test` |

**Customizing:**
- Add more protected branches by extending the `case` statement
- Disable test running by commenting out section 3
- Change the review marker path from `production/contract-reviews.md`

---

### 3. validate-assets.sh

| Field | Value |
|-------|-------|
| **Trigger** | PostToolUse (Write/Edit) — after writing or editing files |
| **File** | `.claude/hooks/validate-assets.sh` |
| **Status** | Referenced in settings.json |

**What it validates:**
- Asset file naming conventions (kebab-case for images, fonts)
- Image optimization warnings (large file sizes)
- Correct file extensions for assets in `src/assets/`

---

### 4. session-start.sh

| Field | Value |
|-------|-------|
| **Trigger** | SessionStart — when Claude Code session begins |
| **File** | `.claude/hooks/session-start.sh` |
| **Status** | Referenced in settings.json |

**What it does:**
- Load sprint context from `production/` directory
- Display recent git activity (last 5 commits)
- Show current branch and uncommitted changes
- Load project brief from `.claude/project-brief.md` if it exists
- Display active sprint plan summary

---

### 5. session-stop.sh

| Field | Value |
|-------|-------|
| **Trigger** | Stop — when session ends |
| **File** | `.claude/hooks/session-stop.sh` |
| **Status** | Referenced in settings.json |

**What it does:**
- Log session accomplishments
- Save progress notes to `production/session-logs/`
- Summarize files modified during session
- Flag any uncommitted changes
- Suggest next steps based on work completed

---

### 6. detect-gaps.sh

| Field | Value |
|-------|-------|
| **Trigger** | SessionStart — alongside session-start.sh |
| **File** | `.claude/hooks/detect-gaps.sh` |
| **Status** | Referenced in settings.json |

**What it does:**
- Flag missing documentation (design docs without required sections)
- Identify uncovered code (files without corresponding tests)
- Check for TODO/FIXME items that need attention
- Warn about stale branches (no commits in 7+ days)
- Report missing environment variables

---

### 7. pre-compact.sh

| Field | Value |
|-------|-------|
| **Trigger** | PreCompact — before context window compaction |
| **File** | `.claude/hooks/pre-compact.sh` |
| **Status** | Referenced in settings.json |

**What it does:**
- Preserve session progress notes before context compression
- Save current task state to avoid losing context
- Write a compact summary of decisions made this session
- Store file modification history

---

### 8. log-agent.sh

| Field | Value |
|-------|-------|
| **Trigger** | SubagentStart — when a subagent is spawned |
| **File** | `.claude/hooks/log-agent.sh` |
| **Status** | Referenced in settings.json |

**What it does:**
- Create audit trail for subagent invocations
- Log agent name, timestamp, and invoking context
- Track agent chaining (which agent spawned which)
- Write to `production/agent-logs/` for session review

---

## Hook Configuration in settings.json

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/validate-commit.sh \"$TOOL_INPUT\"" }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/validate-assets.sh \"$TOOL_INPUT\"" }
        ]
      }
    ],
    "SessionStart": [
      {
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/session-start.sh" },
          { "type": "command", "command": "bash .claude/hooks/detect-gaps.sh" }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/session-stop.sh" }
        ]
      }
    ],
    "PreCompact": [
      {
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/pre-compact.sh" }
        ]
      }
    ],
    "SubagentStart": [
      {
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/log-agent.sh \"$AGENT_NAME\"" }
        ]
      }
    ]
  }
}
```

## Troubleshooting

### Hook script not executing

1. Check the script has execute permissions: `chmod +x .claude/hooks/<script>.sh`
2. Verify the script path is correct relative to project root
3. Check `settings.json` syntax — JSON must be valid

### validate-commit.sh false positives

- **Secret detection too aggressive**: The regex `0x[0-9a-fA-F]{64}` may match test data. Add test files to an ignore list or wrap test data in a marker comment: `// nosecret`
- **JSON validation fails**: Ensure `python3` or `jq` is installed. Install via `brew install jq`.
- **console.log blocked in tests**: The check only applies to `src/site/` and `src/dapp/` — test files are not affected.

### validate-push.sh blocks push

- **Tests failing**: Fix the tests. The hook runs `pnpm test` — check test output.
- **Contract review missing**: Create `production/contract-reviews.md` and document reviewed contracts.
- **No upstream branch**: The hook falls back to checking last 5 commits for `.sol` files.

### Hook runs but output is empty

- Scripts use `set -e` — an early error silently exits
- Add `set -x` temporarily for debug output
- Check `/tmp/_validate_commit_issues.$$` temp files aren't stale
