#!/bin/sh
# Stop hook: log session accomplishments and show summary
# Logs to production/session-log.md, shows changed files, warns about uncommitted changes
# POSIX-compatible

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SESSION_LOG="$PROJECT_ROOT/production/session-log.md"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
DATE_SLUG="$(date '+%Y-%m-%d')"

# Ensure production directory exists
mkdir -p "$PROJECT_ROOT/production" 2>/dev/null || true

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Web3 Website Studios — Session End"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ---------------------------------------------------------------------------
# 1. Gather session accomplishments
# ---------------------------------------------------------------------------
CHANGED_SUMMARY=""
COMMIT_LOG=""

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  # Get commits made during this approximate session (last 4 hours)
  COMMIT_LOG="$(git log --oneline --since='4 hours ago' --no-decorate 2>/dev/null || true)"

  # Get currently changed files
  MODIFIED="$(git diff --name-only 2>/dev/null || true)"
  STAGED="$(git diff --cached --name-only 2>/dev/null || true)"
  UNTRACKED="$(git ls-files --others --exclude-standard 2>/dev/null || true)"

  ALL_CHANGED=""
  [ -n "$MODIFIED" ] && ALL_CHANGED="$MODIFIED"
  [ -n "$STAGED" ] && ALL_CHANGED="$ALL_CHANGED
$STAGED"
  [ -n "$UNTRACKED" ] && ALL_CHANGED="$ALL_CHANGED
$UNTRACKED"

  # Deduplicate
  ALL_CHANGED="$(echo "$ALL_CHANGED" | sort -u | grep -v '^$')"
fi

# ---------------------------------------------------------------------------
# 2. Log session to production/session-log.md
# ---------------------------------------------------------------------------
{
  echo ""
  echo "## Session: $TIMESTAMP"
  echo ""

  if [ -n "$COMMIT_LOG" ]; then
    echo "### Commits"
    echo '```'
    echo "$COMMIT_LOG"
    echo '```'
    echo ""
  fi

  if [ -n "$ALL_CHANGED" ]; then
    echo "### Changed Files"
    echo "$ALL_CHANGED" | while IFS= read -r f; do
      [ -n "$f" ] && echo "- \`$f\`"
    done
    echo ""
  fi

  echo "---"
} >> "$SESSION_LOG" 2>/dev/null

echo "[Session Log] Saved to production/session-log.md"
echo ""

# ---------------------------------------------------------------------------
# 3. Show changed files summary
# ---------------------------------------------------------------------------
if [ -n "$ALL_CHANGED" ]; then
  CHANGE_COUNT="$(echo "$ALL_CHANGED" | wc -l | tr -d ' ')"
  echo "[Changed Files] $CHANGE_COUNT file(s):"

  # Categorize changes
  SOL_COUNT="$(echo "$ALL_CHANGED" | grep -c '\.sol$' 2>/dev/null || echo 0)"
  TS_COUNT="$(echo "$ALL_CHANGED" | grep -c -E '\.(ts|tsx)$' 2>/dev/null || echo 0)"
  CSS_COUNT="$(echo "$ALL_CHANGED" | grep -c -E '\.(css|scss)$' 2>/dev/null || echo 0)"
  JSON_COUNT="$(echo "$ALL_CHANGED" | grep -c '\.json$' 2>/dev/null || echo 0)"
  MD_COUNT="$(echo "$ALL_CHANGED" | grep -c '\.md$' 2>/dev/null || echo 0)"
  OTHER_COUNT=$((CHANGE_COUNT - SOL_COUNT - TS_COUNT - CSS_COUNT - JSON_COUNT - MD_COUNT))

  [ "$TS_COUNT" -gt 0 ] 2>/dev/null && echo "  TypeScript: $TS_COUNT"
  [ "$SOL_COUNT" -gt 0 ] 2>/dev/null && echo "  Solidity:   $SOL_COUNT"
  [ "$CSS_COUNT" -gt 0 ] 2>/dev/null && echo "  Styles:     $CSS_COUNT"
  [ "$JSON_COUNT" -gt 0 ] 2>/dev/null && echo "  JSON:       $JSON_COUNT"
  [ "$MD_COUNT" -gt 0 ] 2>/dev/null && echo "  Markdown:   $MD_COUNT"
  [ "$OTHER_COUNT" -gt 0 ] 2>/dev/null && echo "  Other:      $OTHER_COUNT"
  echo ""
else
  echo "[Changed Files] No changes detected"
  echo ""
fi

# ---------------------------------------------------------------------------
# 4. Remind about uncommitted changes
# ---------------------------------------------------------------------------
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  UNCOMMITTED="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"

  if [ "$UNCOMMITTED" -gt 0 ] 2>/dev/null; then
    echo "[WARNING] $UNCOMMITTED uncommitted change(s) detected!"
    echo "  Run 'git add . && git commit' to save your work."

    # Extra warning for contract files
    SOL_UNCOMMITTED="$(git status --porcelain 2>/dev/null | grep -c '\.sol' || echo 0)"
    if [ "$SOL_UNCOMMITTED" -gt 0 ] 2>/dev/null; then
      echo "  [!] Includes $SOL_UNCOMMITTED Solidity contract file(s) — commit these!"
    fi
    echo ""
  else
    echo "[Git] All changes committed. Clean working directory."
    echo ""
  fi
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
