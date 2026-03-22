#!/bin/sh
# SubagentStart hook: log agent invocations
# Records timestamp, agent name, and task description
# POSIX-compatible

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
AGENT_LOG="$PROJECT_ROOT/production/agent-log.md"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

# Ensure production directory exists
mkdir -p "$PROJECT_ROOT/production" 2>/dev/null || true

# ---------------------------------------------------------------------------
# Parse arguments
# ---------------------------------------------------------------------------
AGENT_NAME="${1:-unknown-agent}"
TASK_DESC="${2:-no description provided}"

# If additional args exist, join them into task description
if [ $# -gt 2 ]; then
  shift 2
  TASK_DESC="$TASK_DESC $*"
fi

# ---------------------------------------------------------------------------
# Initialize log file if it doesn't exist
# ---------------------------------------------------------------------------
if [ ! -f "$AGENT_LOG" ]; then
  {
    echo "# Agent Invocation Log"
    echo ""
    echo "Automatic log of all sub-agent invocations during Claude Code sessions."
    echo ""
    echo "| Timestamp | Agent | Task |"
    echo "|-----------|-------|------|"
  } > "$AGENT_LOG" 2>/dev/null
fi

# ---------------------------------------------------------------------------
# Log the invocation
# ---------------------------------------------------------------------------
# Sanitize task description (escape pipes for markdown table)
SAFE_DESC="$(echo "$TASK_DESC" | sed 's/|/\\|/g' | head -c 200)"

echo "| $TIMESTAMP | \`$AGENT_NAME\` | $SAFE_DESC |" >> "$AGENT_LOG" 2>/dev/null

# ---------------------------------------------------------------------------
# Also log in a more detailed format below the table
# ---------------------------------------------------------------------------
{
  echo ""
  echo "### $TIMESTAMP — $AGENT_NAME"
  echo ""
  echo "**Task:** $TASK_DESC"
  echo ""

  # Add context: current branch and recent file
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")"
    echo "**Context:** Branch \`$BRANCH\`"

    # Show what files are currently being worked on
    RECENT="$(git diff --name-only HEAD 2>/dev/null | head -n 5 || true)"
    if [ -n "$RECENT" ]; then
      echo ""
      echo "**Active files:**"
      echo "$RECENT" | while IFS= read -r f; do
        [ -n "$f" ] && echo "- \`$f\`"
      done
    fi
  fi

  echo ""
  echo "---"
} >> "$AGENT_LOG" 2>/dev/null

echo "[Agent Log] Recorded: $AGENT_NAME — $TASK_DESC"
