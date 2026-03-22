#!/bin/sh
# SessionStart hook: detect project gaps and suggest next steps
# Checks for missing config, empty directories, test coverage, and docs
# POSIX-compatible

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

SUGGESTIONS=""
GAP_COUNT=0

add_gap() {
  GAP_COUNT=$((GAP_COUNT + 1))
  SUGGESTIONS="${SUGGESTIONS}  $GAP_COUNT. $1\n"
}

echo ""
echo "[Gap Detection] Scanning project structure..."
echo ""

# ---------------------------------------------------------------------------
# 1. Check if CLAUDE.md exists
# ---------------------------------------------------------------------------
if [ ! -f "$PROJECT_ROOT/CLAUDE.md" ]; then
  add_gap "No CLAUDE.md found — run /start to initialize project configuration"
fi

# ---------------------------------------------------------------------------
# 2. Check if design/ is empty or missing
# ---------------------------------------------------------------------------
if [ ! -d "$PROJECT_ROOT/design" ]; then
  add_gap "No design/ directory — run /brainstorm to start the design phase"
elif [ -z "$(ls -A "$PROJECT_ROOT/design" 2>/dev/null)" ]; then
  add_gap "design/ directory is empty — run /brainstorm to create design docs"
else
  # Check for required design doc sections
  DESIGN_FILES="$(find "$PROJECT_ROOT/design" -name '*.md' -type f 2>/dev/null)"
  if [ -z "$DESIGN_FILES" ]; then
    add_gap "No markdown files in design/ — create design documents (.md)"
  fi
fi

# ---------------------------------------------------------------------------
# 3. Check if package.json exists
# ---------------------------------------------------------------------------
if [ ! -f "$PROJECT_ROOT/package.json" ]; then
  add_gap "No package.json found — run /setup-stack to initialize the project"
else
  # Check if dependencies are installed
  if [ ! -d "$PROJECT_ROOT/node_modules" ]; then
    add_gap "Dependencies not installed — run npm install / yarn / pnpm install"
  fi
fi

# ---------------------------------------------------------------------------
# 4. Check test coverage gaps
# ---------------------------------------------------------------------------
if [ ! -d "$PROJECT_ROOT/tests" ]; then
  add_gap "No tests/ directory — create tests to ensure code quality"
elif [ -z "$(ls -A "$PROJECT_ROOT/tests" 2>/dev/null)" ]; then
  add_gap "tests/ directory is empty — write tests for existing code"
else
  # Count test files vs source files
  TEST_COUNT="$(find "$PROJECT_ROOT/tests" -type f -name '*.test.*' -o -name '*.spec.*' 2>/dev/null | wc -l | tr -d ' ')"

  SRC_COUNT=0
  if [ -d "$PROJECT_ROOT/src" ]; then
    SRC_COUNT="$(find "$PROJECT_ROOT/src" -type f \( -name '*.ts' -o -name '*.tsx' -o -name '*.js' -o -name '*.jsx' \) 2>/dev/null | wc -l | tr -d ' ')"
  fi

  if [ "$SRC_COUNT" -gt 0 ] && [ "$TEST_COUNT" -gt 0 ] 2>/dev/null; then
    RATIO=$((TEST_COUNT * 100 / SRC_COUNT))
    if [ "$RATIO" -lt 30 ] 2>/dev/null; then
      add_gap "Low test coverage (~${RATIO}% file ratio) — aim for 80%+ coverage"
    fi
  elif [ "$SRC_COUNT" -gt 0 ] && [ "$TEST_COUNT" = "0" ] 2>/dev/null; then
    add_gap "No test files found for $SRC_COUNT source file(s)"
  fi

  # Check for contract tests specifically
  if [ -d "$PROJECT_ROOT/src/contracts" ]; then
    SOL_FILES="$(find "$PROJECT_ROOT/src/contracts" -name '*.sol' -type f 2>/dev/null | wc -l | tr -d ' ')"
    CONTRACT_TESTS="$(find "$PROJECT_ROOT/tests" -type f -name '*contract*' -o -name '*Contract*' -o -name '*.sol.test.*' 2>/dev/null | wc -l | tr -d ' ')"

    if [ "$SOL_FILES" -gt 0 ] && [ "$CONTRACT_TESTS" = "0" ] 2>/dev/null; then
      add_gap "$SOL_FILES Solidity contract(s) have no test files — add contract tests"
    fi
  fi
fi

# ---------------------------------------------------------------------------
# 5. Check for missing documentation
# ---------------------------------------------------------------------------
if [ ! -d "$PROJECT_ROOT/docs" ]; then
  add_gap "No docs/ directory — consider adding project documentation"
else
  # Check for API docs if src/dapp exists
  if [ -d "$PROJECT_ROOT/src/dapp" ]; then
    if ! find "$PROJECT_ROOT/docs" -name '*api*' -o -name '*API*' 2>/dev/null | grep -q .; then
      add_gap "dApp exists but no API documentation found in docs/"
    fi
  fi
fi

# Check for README
if [ ! -f "$PROJECT_ROOT/README.md" ]; then
  add_gap "No README.md — add project overview and setup instructions"
fi

# Check for .env.example if .env exists
if [ -f "$PROJECT_ROOT/.env" ] && [ ! -f "$PROJECT_ROOT/.env.example" ]; then
  add_gap "Found .env but no .env.example — create a template for other developers"
fi

# Check for .gitignore
if [ ! -f "$PROJECT_ROOT/.gitignore" ]; then
  add_gap "No .gitignore — add one to exclude node_modules, .env, build artifacts"
fi

# Check src/ subdirectories
if [ -d "$PROJECT_ROOT/src" ]; then
  [ ! -d "$PROJECT_ROOT/src/site" ] && [ ! -d "$PROJECT_ROOT/src/components" ] && \
    add_gap "No src/site/ or src/components/ — create frontend structure"

  [ ! -d "$PROJECT_ROOT/src/hooks" ] && [ -d "$PROJECT_ROOT/src/components" ] && \
    add_gap "No src/hooks/ — extract custom hooks from components"

  [ ! -d "$PROJECT_ROOT/src/lib" ] && \
    add_gap "No src/lib/ — create shared utilities and constants"
fi

# ---------------------------------------------------------------------------
# Output results
# ---------------------------------------------------------------------------
if [ "$GAP_COUNT" -gt 0 ] 2>/dev/null; then
  echo "━━━ $GAP_COUNT Gap(s) Detected ━━━"
  printf "%b" "$SUGGESTIONS"
  echo ""
  echo "Address these gaps to strengthen the project."
else
  echo "[Gap Detection] No gaps found. Project structure looks good."
fi

echo ""
