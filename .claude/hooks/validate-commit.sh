#!/bin/sh
# PreToolUse hook: validate before git commit
# Intercepts git commit commands and checks for common issues
# POSIX-compatible — uses grep -E, not grep -P

set -e

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ERRORS=""
WARNINGS=""
EXIT_CODE=0

# ---------------------------------------------------------------------------
# Helper: append error / warning
# ---------------------------------------------------------------------------
add_error() {
  ERRORS="${ERRORS}  [BLOCK] $1\n"
  EXIT_CODE=1
}

add_warning() {
  WARNINGS="${WARNINGS}  [WARN]  $1\n"
}

# ---------------------------------------------------------------------------
# Get staged files (fall back to all tracked files if not in a git repo)
# ---------------------------------------------------------------------------
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  STAGED_FILES="$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null || true)"
else
  STAGED_FILES=""
fi

if [ -z "$STAGED_FILES" ]; then
  # Nothing staged — nothing to validate
  exit 0
fi

# ---------------------------------------------------------------------------
# 1. No hardcoded private keys, mnemonics, or API keys
# ---------------------------------------------------------------------------
SECRETS_PATTERN='(0x[0-9a-fA-F]{64}|-----BEGIN (RSA |EC )?PRIVATE KEY-----|PRIVATE_KEY\s*=\s*["\x27]|MNEMONIC\s*=\s*["\x27]|["\x27][a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+["\x27]|sk_live_[0-9a-zA-Z]+|AKIA[0-9A-Z]{16}|xox[bpoas]-[0-9a-zA-Z-]+)'

echo "$STAGED_FILES" | while IFS= read -r file; do
  [ -f "$PROJECT_ROOT/$file" ] || continue
  if grep -E -n "$SECRETS_PATTERN" "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
    # Output to stderr so the while-subshell issue is avoided; we use a tmpfile instead
    echo "BLOCK:Hardcoded secret detected in $file" >> /tmp/_validate_commit_issues.$$
  fi
done

# Collect issues from subshell
if [ -f /tmp/_validate_commit_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      BLOCK:*) add_error "${line#BLOCK:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
    esac
  done < /tmp/_validate_commit_issues.$$
  rm -f /tmp/_validate_commit_issues.$$
fi

# ---------------------------------------------------------------------------
# 2. No hardcoded contract addresses without constants
# ---------------------------------------------------------------------------
echo "$STAGED_FILES" | while IFS= read -r file; do
  [ -f "$PROJECT_ROOT/$file" ] || continue
  case "$file" in
    *.ts|*.tsx|*.js|*.jsx|*.sol)
      # Look for 0x addresses that are NOT in a const/let/var declaration or UPPER_SNAKE assignment
      if grep -E -n '"0x[0-9a-fA-F]{40}"' "$PROJECT_ROOT/$file" | grep -E -v '(const |let |var |UPPER_|ADDRESS|address =)' >/dev/null 2>&1; then
        echo "WARN:Hardcoded contract address without constant in $file" >> /tmp/_validate_commit_issues.$$
      fi
      ;;
  esac
done

if [ -f /tmp/_validate_commit_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      BLOCK:*) add_error "${line#BLOCK:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
    esac
  done < /tmp/_validate_commit_issues.$$
  rm -f /tmp/_validate_commit_issues.$$
fi

# ---------------------------------------------------------------------------
# 3. All TODO/FIXME have attribution: TODO(name)
# ---------------------------------------------------------------------------
echo "$STAGED_FILES" | while IFS= read -r file; do
  [ -f "$PROJECT_ROOT/$file" ] || continue
  # Match TODO or FIXME not followed by (name)
  if grep -E -n '(TODO|FIXME)(?!\()' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
    # grep -E doesn't support lookahead; use a two-pass approach
    if grep -E -n 'TODO|FIXME' "$PROJECT_ROOT/$file" | grep -E -v '(TODO|FIXME)\(' >/dev/null 2>&1; then
      echo "WARN:TODO/FIXME without attribution in $file (use TODO(name))" >> /tmp/_validate_commit_issues.$$
    fi
  fi
done

if [ -f /tmp/_validate_commit_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      BLOCK:*) add_error "${line#BLOCK:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
    esac
  done < /tmp/_validate_commit_issues.$$
  rm -f /tmp/_validate_commit_issues.$$
fi

# ---------------------------------------------------------------------------
# 4. JSON files in src/ are valid
# ---------------------------------------------------------------------------
echo "$STAGED_FILES" | while IFS= read -r file; do
  case "$file" in
    src/*.json)
      [ -f "$PROJECT_ROOT/$file" ] || continue
      VALID=0
      if command -v python3 >/dev/null 2>&1; then
        python3 -m json.tool "$PROJECT_ROOT/$file" >/dev/null 2>&1 && VALID=1
      elif command -v jq >/dev/null 2>&1; then
        jq . "$PROJECT_ROOT/$file" >/dev/null 2>&1 && VALID=1
      else
        VALID=1  # No validator available — skip
      fi
      if [ "$VALID" = "0" ]; then
        echo "BLOCK:Invalid JSON file: $file" >> /tmp/_validate_commit_issues.$$
      fi
      ;;
  esac
done

if [ -f /tmp/_validate_commit_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      BLOCK:*) add_error "${line#BLOCK:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
    esac
  done < /tmp/_validate_commit_issues.$$
  rm -f /tmp/_validate_commit_issues.$$
fi

# ---------------------------------------------------------------------------
# 5. Solidity files don't have hardcoded gas values
# ---------------------------------------------------------------------------
echo "$STAGED_FILES" | while IFS= read -r file; do
  case "$file" in
    *.sol)
      [ -f "$PROJECT_ROOT/$file" ] || continue
      if grep -E -n '\.gas\([0-9]+\)|gasLimit\s*[:=]\s*[0-9]+' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
        echo "WARN:Hardcoded gas value in $file — use estimates instead" >> /tmp/_validate_commit_issues.$$
      fi
      ;;
  esac
done

if [ -f /tmp/_validate_commit_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      BLOCK:*) add_error "${line#BLOCK:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
    esac
  done < /tmp/_validate_commit_issues.$$
  rm -f /tmp/_validate_commit_issues.$$
fi

# ---------------------------------------------------------------------------
# 6. No console.log in production code (src/site/, src/dapp/)
# ---------------------------------------------------------------------------
echo "$STAGED_FILES" | while IFS= read -r file; do
  case "$file" in
    src/site/*|src/dapp/*)
      [ -f "$PROJECT_ROOT/$file" ] || continue
      case "$file" in
        *.ts|*.tsx|*.js|*.jsx)
          if grep -E -n 'console\.(log|debug|info)\(' "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
            echo "WARN:console.log found in production code: $file" >> /tmp/_validate_commit_issues.$$
          fi
          ;;
      esac
      ;;
  esac
done

if [ -f /tmp/_validate_commit_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      BLOCK:*) add_error "${line#BLOCK:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
    esac
  done < /tmp/_validate_commit_issues.$$
  rm -f /tmp/_validate_commit_issues.$$
fi

# ---------------------------------------------------------------------------
# 7. Design docs in design/ have required sections
# ---------------------------------------------------------------------------
REQUIRED_SECTIONS="Overview User Persona User Flow"

echo "$STAGED_FILES" | while IFS= read -r file; do
  case "$file" in
    design/*.md)
      [ -f "$PROJECT_ROOT/$file" ] || continue
      for section in $REQUIRED_SECTIONS; do
        SECTION_LABEL=$(echo "$section" | sed 's/_/ /g')
        if ! grep -E -i "^#+ .*${SECTION_LABEL}" "$PROJECT_ROOT/$file" >/dev/null 2>&1; then
          echo "WARN:Design doc $file missing required section: $SECTION_LABEL" >> /tmp/_validate_commit_issues.$$
        fi
      done
      ;;
  esac
done

if [ -f /tmp/_validate_commit_issues.$$ ]; then
  while IFS= read -r line; do
    case "$line" in
      BLOCK:*) add_error "${line#BLOCK:}" ;;
      WARN:*)  add_warning "${line#WARN:}" ;;
    esac
  done < /tmp/_validate_commit_issues.$$
  rm -f /tmp/_validate_commit_issues.$$
fi

# ---------------------------------------------------------------------------
# Output results
# ---------------------------------------------------------------------------
if [ -n "$WARNINGS" ]; then
  echo "━━━ Commit Validation Warnings ━━━"
  printf "%b" "$WARNINGS"
fi

if [ -n "$ERRORS" ]; then
  echo "━━━ Commit Validation BLOCKED ━━━"
  printf "%b" "$ERRORS"
  echo ""
  echo "Fix the issues above before committing."
  exit 1
fi

if [ -n "$WARNINGS" ]; then
  echo ""
  echo "Commit allowed with warnings. Consider fixing them."
fi

exit 0
