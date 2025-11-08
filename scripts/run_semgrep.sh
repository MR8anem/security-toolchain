#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="$1"
RULES_DIR="$2"
OUT="$ROOT/reports/semgrep"
mkdir -p "$OUT"
echo "Running Semgrep built-in rules..."
semgrep --config p/ci --json --output "$OUT/semgrep_builtin.json" "$TARGET"
if [ -d "$RULES_DIR" ]; then
  echo "Running Semgrep custom rules..."
  semgrep --config "$RULES_DIR" --json --output "$OUT/semgrep_custom.json" "$TARGET" || true
fi
echo "Semgrep reports generated at $OUT"
