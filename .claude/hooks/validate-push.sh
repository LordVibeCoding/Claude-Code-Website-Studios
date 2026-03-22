#!/bin/sh
# PreToolUse hook: validate before git push
# Warns about risky push targets and unreviewed changes
# POSIX-compatible

set -e

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
WARNINGS=""
ERRORS=""
EXIT_CODE=0

add_error() {
  ERRORS="${ERRORS}  [BLOCK] $1\n"
  EXIT_CODE=1
}

add_warning() {
  WARNINGS="${WARNINGS}  [WARN]  $1\n"
}

# ---------------------------------------------------------------------------
# 1. Warn if pushing to main/master branch
# ---------------------------------------------------------------------------
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")"

case "$CURRENT_BRANCH" in
  main|master)
    add_warning "Pushing directly to '$CURRENT_BRANCH' branch. Consider using a feature branch and PR workflow."
    ;;
esac

# ---------------------------------------------------------------------------
# 2. Warn if pushing unreviewed contract changes
# ---------------------------------------------------------------------------
# Check if any .sol files have been modified since last push
UPSTREAM="$(git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null || echo "")"

if [ -n "$UPSTREAM" ]; then
  UNPUSHED_SOL="$(git diff --name-only "$UPSTREAM"..HEAD 2>/dev/null | grep -E '\.sol$' || true)"
else
  # No upstream — check last 5 commits for .sol files
  UNPUSHED_SOL="$(git diff --name-only HEAD~5..HEAD 2>/dev/null | grep -E '\.sol$' || true)"
fi

if [ -n "$UNPUSHED_SOL" ]; then
  # Check if there's a review marker (a file or git note indicating review)
  REVIEW_MARKER="$PROJECT_ROOT/production/contract-reviews.md"
  if [ ! -f "$REVIEW_MARKER" ]; then
    add_warning "Pushing contract changes without documented review:"
    for sol_file in $UNPUSHED_SOL; do
      add_warning "  - $sol_file"
    done
    add_warning "Consider documenting review in production/contract-reviews.md"
  else
    # Check if the specific files are mentioned in the review log
    for sol_file in $UNPUSHED_SOL; do
      BASENAME="$(basename "$sol_file")"
      if ! grep -q "$BASENAME" "$REVIEW_MARKER" 2>/dev/null; then
        add_warning "Contract $sol_file not found in review log"
      fi
    done
  fi
fi

# ---------------------------------------------------------------------------
# 3. Check if tests pass before push
# ---------------------------------------------------------------------------
TEST_PASSED=1

if [ -f "$PROJECT_ROOT/package.json" ]; then
  # Check if test script exists
  if grep -q '"test"' "$PROJECT_ROOT/package.json" 2>/dev/null; then
    if command -v npm >/dev/null 2>&1; then
      echo "Running tests before push..."
      if ! npm test --prefix "$PROJECT_ROOT" --silent 2>/dev/null; then
        TEST_PASSED=0
      fi
    elif command -v yarn >/dev/null 2>&1; then
      echo "Running tests before push..."
      if ! yarn --cwd "$PROJECT_ROOT" test --silent 2>/dev/null; then
        TEST_PASSED=0
      fi
    elif command -v pnpm >/dev/null 2>&1; then
      echo "Running tests before push..."
      if ! pnpm --dir "$PROJECT_ROOT" test --silent 2>/dev/null; then
        TEST_PASSED=0
      fi
    fi
  fi
fi

# Also check hardhat tests if contracts are changed
if [ -n "$UNPUSHED_SOL" ] && [ -f "$PROJECT_ROOT/hardhat.config.ts" ] || [ -f "$PROJECT_ROOT/hardhat.config.js" ]; then
  if command -v npx >/dev/null 2>&1; then
    echo "Running contract tests..."
    if ! npx hardhat test --no-compile 2>/dev/null; then
      TEST_PASSED=0
    fi
  fi
fi

if [ "$TEST_PASSED" = "0" ]; then
  add_error "Tests failed. Fix failing tests before pushing."
fi

# ---------------------------------------------------------------------------
# Output results
# ---------------------------------------------------------------------------
if [ -n "$WARNINGS" ]; then
  echo "━━━ Push Validation Warnings ━━━"
  printf "%b" "$WARNINGS"
fi

if [ -n "$ERRORS" ]; then
  echo "━━━ Push Validation BLOCKED ━━━"
  printf "%b" "$ERRORS"
  echo ""
  echo "Fix the issues above before pushing."
  exit 1
fi

if [ -n "$WARNINGS" ]; then
  echo ""
  echo "Push allowed with warnings. Consider addressing them."
fi

exit 0
