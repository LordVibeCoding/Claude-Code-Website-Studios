#!/bin/sh
# PostToolUse hook for Write|Edit: validate assets and code files
# Checks naming conventions, optimization, validity, and compilation
# POSIX-compatible

set -e

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
WARNINGS=""
ERRORS=""

add_error() {
  ERRORS="${ERRORS}  [ERROR] $1\n"
}

add_warning() {
  WARNINGS="${WARNINGS}  [WARN]  $1\n"
}

# ---------------------------------------------------------------------------
# Determine which files were just written or edited
# If called with arguments, use them; otherwise check recent git changes
# ---------------------------------------------------------------------------
if [ $# -gt 0 ]; then
  CHANGED_FILES="$*"
else
  CHANGED_FILES="$(git diff --name-only HEAD 2>/dev/null || true)"
  UNSTAGED="$(git diff --name-only 2>/dev/null || true)"
  CHANGED_FILES="$CHANGED_FILES
$UNSTAGED"
fi

if [ -z "$CHANGED_FILES" ]; then
  exit 0
fi

# ---------------------------------------------------------------------------
# 1. Image files follow kebab-case naming convention
# ---------------------------------------------------------------------------
echo "$CHANGED_FILES" | while IFS= read -r file; do
  [ -z "$file" ] && continue
  case "$file" in
    *.png|*.jpg|*.jpeg|*.gif|*.webp|*.avif|*.ico)
      BASENAME="$(basename "$file" | sed 's/\.[^.]*$//')"
      # kebab-case: lowercase letters, numbers, hyphens only
      if echo "$BASENAME" | grep -E '[A-Z_\s]' >/dev/null 2>&1; then
        echo "WARN:Image file not kebab-case: $file (rename to $(echo "$BASENAME" | sed 's/[A-Z]/\L&/g; s/_/-/g; s/ /-/g').ext)" >> /tmp/_validate_assets_issues.$$
      fi
      ;;
  esac
done

# ---------------------------------------------------------------------------
# 2. SVG files are optimized (no unnecessary metadata)
# ---------------------------------------------------------------------------
echo "$CHANGED_FILES" | while IFS= read -r file; do
  [ -z "$file" ] && continue
  case "$file" in
    *.svg)
      [ -f "$PROJECT_ROOT/$file" ] || continue
      # Check for common SVG bloat indicators
      SVG_ISSUES=""
      if grep -E '<metadata' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
        SVG_ISSUES="${SVG_ISSUES}metadata block, "
      fi
      if grep -E 'xmlns:dc=|xmlns:cc=|xmlns:rdf=' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
        SVG_ISSUES="${SVG_ISSUES}Dublin Core namespaces, "
      fi
      if grep -E '<!--' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
        SVG_ISSUES="${SVG_ISSUES}HTML comments, "
      fi
      if grep -E 'inkscape:|sodipodi:' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
        SVG_ISSUES="${SVG_ISSUES}Inkscape metadata, "
      fi
      if grep -E 'data-name=' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
        SVG_ISSUES="${SVG_ISSUES}data-name attributes, "
      fi
      if [ -n "$SVG_ISSUES" ]; then
        SVG_ISSUES="$(echo "$SVG_ISSUES" | sed 's/, $//')"
        echo "WARN:SVG not optimized ($SVG_ISSUES): $file — consider running through SVGO" >> /tmp/_validate_assets_issues.$$
      fi

      # Also check kebab-case naming
      BASENAME="$(basename "$file" | sed 's/\.svg$//')"
      if echo "$BASENAME" | grep -E '[A-Z_]' >/dev/null 2>&1; then
        echo "WARN:SVG file not kebab-case: $file" >> /tmp/_validate_assets_issues.$$
      fi
      ;;
  esac
done

# ---------------------------------------------------------------------------
# 3. JSON data files are valid
# ---------------------------------------------------------------------------
echo "$CHANGED_FILES" | while IFS= read -r file; do
  [ -z "$file" ] && continue
  case "$file" in
    *.json)
      [ -f "$PROJECT_ROOT/$file" ] || continue
      VALID=0
      if command -v python3 >/dev/null 2>&1; then
        python3 -m json.tool "$PROJECT_ROOT/$file" >/dev/null 2>&1 && VALID=1
      elif command -v jq >/dev/null 2>&1; then
        jq . "$PROJECT_ROOT/$file" >/dev/null 2>&1 && VALID=1
      else
        VALID=1  # No validator available
      fi
      if [ "$VALID" = "0" ]; then
        echo "ERROR:Invalid JSON: $file" >> /tmp/_validate_assets_issues.$$
      fi
      ;;
  esac
done

# ---------------------------------------------------------------------------
# 4. Solidity files compile without errors (if hardhat available)
# ---------------------------------------------------------------------------
SOL_FILES_CHANGED=""
echo "$CHANGED_FILES" | while IFS= read -r file; do
  [ -z "$file" ] && continue
  case "$file" in
    *.sol)
      echo "SOL:$file" >> /tmp/_validate_assets_issues.$$
      ;;
  esac
done

if [ -f /tmp/_validate_assets_issues.$$ ] && grep -q "^SOL:" /tmp/_validate_assets_issues.$$ 2>/dev/null; then
  if command -v npx >/dev/null 2>&1 && [ -f "$PROJECT_ROOT/hardhat.config.ts" ] || [ -f "$PROJECT_ROOT/hardhat.config.js" ]; then
    echo "Compiling Solidity files..."
    if ! npx hardhat compile 2>/dev/null; then
      echo "ERROR:Solidity compilation failed — check contract syntax" >> /tmp/_validate_assets_issues.$$
    fi
  fi
fi

# ---------------------------------------------------------------------------
# Collect issues
# ---------------------------------------------------------------------------
if [ -f /tmp/_validate_assets_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      ERROR:*) add_error "${line#ERROR:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
      SOL:*)   ;; # Skip sol markers
    esac
  done < /tmp/_validate_assets_issues.$$
  rm -f /tmp/_validate_assets_issues.$$
fi

# ---------------------------------------------------------------------------
# Output results
# ---------------------------------------------------------------------------
if [ -n "$WARNINGS" ]; then
  echo "━━━ Asset Validation Warnings ━━━"
  printf "%b" "$WARNINGS"
fi

if [ -n "$ERRORS" ]; then
  echo "━━━ Asset Validation Errors ━━━"
  printf "%b" "$ERRORS"
fi

if [ -z "$WARNINGS" ] && [ -z "$ERRORS" ]; then
  : # Silent success
fi

exit 0
