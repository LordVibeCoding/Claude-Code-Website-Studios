#!/bin/sh
# SessionStart hook: display project context at session start
# Shows sprint info, recent activity, TODOs, and project stage
# POSIX-compatible

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Web3 Website Studios — Session Start"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ---------------------------------------------------------------------------
# 1. Display current sprint info
# ---------------------------------------------------------------------------
SPRINT_FILE="$PROJECT_ROOT/production/current-sprint.md"

if [ -f "$SPRINT_FILE" ]; then
  echo "[Sprint]"
  # Show first 15 lines of sprint file (header + key info)
  head -n 15 "$SPRINT_FILE" 2>/dev/null | sed 's/^/  /'
  echo ""
else
  echo "[Sprint] No sprint file found at production/current-sprint.md"
  echo ""
fi

# ---------------------------------------------------------------------------
# 2. Show recent git activity (last 5 commits)
# ---------------------------------------------------------------------------
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[Recent Commits]"
  COMMITS="$(git log --oneline --no-decorate -n 5 2>/dev/null || true)"
  if [ -n "$COMMITS" ]; then
    echo "$COMMITS" | sed 's/^/  /'
  else
    echo "  (no commits yet)"
  fi
  echo ""

  # Show current branch
  BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")"
  echo "[Branch] $BRANCH"

  # Show uncommitted changes count
  UNCOMMITTED="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$UNCOMMITTED" -gt 0 ] 2>/dev/null; then
    echo "[Uncommitted Changes] $UNCOMMITTED file(s) modified"
  fi
  echo ""
else
  echo "[Git] Not a git repository"
  echo ""
fi

# ---------------------------------------------------------------------------
# 3. Show unfinished TODOs count
# ---------------------------------------------------------------------------
TODO_COUNT=0

if [ -d "$PROJECT_ROOT/src" ]; then
  SRC_TODOS="$(grep -r -E 'TODO|FIXME|HACK|XXX' "$PROJECT_ROOT/src" 2>/dev/null | wc -l | tr -d ' ')"
  TODO_COUNT=$((TODO_COUNT + SRC_TODOS))
fi

if [ -d "$PROJECT_ROOT/design" ]; then
  DESIGN_TODOS="$(grep -r -E 'TODO|FIXME' "$PROJECT_ROOT/design" 2>/dev/null | wc -l | tr -d ' ')"
  TODO_COUNT=$((TODO_COUNT + DESIGN_TODOS))
fi

if [ "$TODO_COUNT" -gt 0 ] 2>/dev/null; then
  echo "[TODOs] $TODO_COUNT unfinished TODO/FIXME items found"
  # Show top 5 most recent
  if [ -d "$PROJECT_ROOT/src" ]; then
    grep -r -n -E 'TODO|FIXME' "$PROJECT_ROOT/src" 2>/dev/null | head -n 5 | sed 's/^/  /'
  fi
  echo ""
else
  echo "[TODOs] None found"
  echo ""
fi

# ---------------------------------------------------------------------------
# 4. Display project stage
# ---------------------------------------------------------------------------
echo "[Project Stage]"

# Detect stage based on directory structure and file presence
HAS_DESIGN=0
HAS_SRC=0
HAS_CONTRACTS=0
HAS_TESTS=0
HAS_DEPLOY=0
HAS_PACKAGE=0

[ -d "$PROJECT_ROOT/design" ] && [ "$(ls -A "$PROJECT_ROOT/design" 2>/dev/null)" ] && HAS_DESIGN=1
[ -d "$PROJECT_ROOT/src" ] && [ "$(ls -A "$PROJECT_ROOT/src" 2>/dev/null)" ] && HAS_SRC=1
[ -d "$PROJECT_ROOT/src/contracts" ] && [ "$(ls -A "$PROJECT_ROOT/src/contracts" 2>/dev/null)" ] && HAS_CONTRACTS=1
[ -d "$PROJECT_ROOT/tests" ] && [ "$(ls -A "$PROJECT_ROOT/tests" 2>/dev/null)" ] && HAS_TESTS=1
[ -f "$PROJECT_ROOT/package.json" ] && HAS_PACKAGE=1

# Check for deployment configs
if [ -f "$PROJECT_ROOT/vercel.json" ] || [ -f "$PROJECT_ROOT/netlify.toml" ] || [ -f "$PROJECT_ROOT/Dockerfile" ]; then
  HAS_DEPLOY=1
fi

if [ "$HAS_DEPLOY" = "1" ]; then
  echo "  Stage: DEPLOYMENT — Ready for or in production"
elif [ "$HAS_TESTS" = "1" ]; then
  echo "  Stage: TESTING — Tests in place, validating functionality"
elif [ "$HAS_CONTRACTS" = "1" ]; then
  echo "  Stage: DEVELOPMENT (Web3) — Smart contracts under development"
elif [ "$HAS_SRC" = "1" ]; then
  echo "  Stage: DEVELOPMENT — Source code in progress"
elif [ "$HAS_PACKAGE" = "1" ]; then
  echo "  Stage: SETUP — Project initialized, ready for development"
elif [ "$HAS_DESIGN" = "1" ]; then
  echo "  Stage: DESIGN — Design phase, no implementation yet"
else
  echo "  Stage: INIT — Fresh project, needs setup"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
