#!/bin/sh
# PreCompact hook: save progress context before context compaction
# Preserves sprint context, progress notes, and decisions
# POSIX-compatible

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
COMPACT_NOTES="$PROJECT_ROOT/production/compact-notes.md"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

# Ensure production directory exists
mkdir -p "$PROJECT_ROOT/production" 2>/dev/null || true

echo "[Pre-Compact] Saving session context before compaction..."

# ---------------------------------------------------------------------------
# 1. Save current progress notes
# ---------------------------------------------------------------------------
{
  echo ""
  echo "## Compact Checkpoint: $TIMESTAMP"
  echo ""

  # Current branch
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")"
    echo "### Branch: \`$BRANCH\`"
    echo ""

    # Recent commits (since last compact or last 2 hours)
    echo "### Recent Commits"
    echo '```'
    git log --oneline --since='2 hours ago' --no-decorate 2>/dev/null || echo "(no recent commits)"
    echo '```'
    echo ""

    # Current working state
    echo "### Working State"
    MODIFIED="$(git diff --name-only 2>/dev/null | head -n 20 || true)"
    STAGED="$(git diff --cached --name-only 2>/dev/null | head -n 20 || true)"

    if [ -n "$STAGED" ]; then
      echo "**Staged:**"
      echo "$STAGED" | while IFS= read -r f; do
        [ -n "$f" ] && echo "- \`$f\`"
      done
      echo ""
    fi

    if [ -n "$MODIFIED" ]; then
      echo "**Modified (unstaged):**"
      echo "$MODIFIED" | while IFS= read -r f; do
        [ -n "$f" ] && echo "- \`$f\`"
      done
      echo ""
    fi
  fi

  # Active TODOs in recently modified files
  echo "### Active TODOs in Recent Files"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    RECENT_FILES="$(git diff --name-only HEAD~3..HEAD 2>/dev/null | head -n 10 || true)"
    if [ -n "$RECENT_FILES" ]; then
      echo "$RECENT_FILES" | while IFS= read -r f; do
        [ -z "$f" ] && continue
        [ -f "$PROJECT_ROOT/$f" ] || continue
        TODOS="$(grep -n -E 'TODO|FIXME|HACK' "$PROJECT_ROOT/$f" 2>/dev/null || true)"
        if [ -n "$TODOS" ]; then
          echo "**$f:**"
          echo "$TODOS" | head -n 5 | while IFS= read -r line; do
            echo "- $line"
          done
        fi
      done
    else
      echo "(no recently changed files)"
    fi
  fi
  echo ""

} >> "$COMPACT_NOTES" 2>/dev/null

# ---------------------------------------------------------------------------
# 2. Preserve active sprint context
# ---------------------------------------------------------------------------
SPRINT_FILE="$PROJECT_ROOT/production/current-sprint.md"

if [ -f "$SPRINT_FILE" ]; then
  {
    echo "### Sprint Context (at compact time)"
    echo '```'
    head -n 30 "$SPRINT_FILE" 2>/dev/null
    echo '```'
    echo ""
  } >> "$COMPACT_NOTES" 2>/dev/null
fi

# ---------------------------------------------------------------------------
# 3. Log important decisions made this session
# ---------------------------------------------------------------------------
# Look for decision markers in recently committed files
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  DECISION_PATTERNS="DECISION|DECIDED|CHOSEN|RATIONALE|WHY:"

  RECENT_CHANGES="$(git diff HEAD~3..HEAD 2>/dev/null || true)"
  DECISIONS="$(echo "$RECENT_CHANGES" | grep -E "^\+" | grep -E -i "$DECISION_PATTERNS" 2>/dev/null | head -n 10 || true)"

  if [ -n "$DECISIONS" ]; then
    {
      echo "### Decisions Made"
      echo "$DECISIONS" | sed 's/^+//' | while IFS= read -r d; do
        [ -n "$d" ] && echo "- $d"
      done
      echo ""
    } >> "$COMPACT_NOTES" 2>/dev/null
  fi
fi

# Add separator
{
  echo "---"
  echo ""
} >> "$COMPACT_NOTES" 2>/dev/null

echo "[Pre-Compact] Context saved to production/compact-notes.md"
echo "[Pre-Compact] After compaction, review compact-notes.md to restore context."
