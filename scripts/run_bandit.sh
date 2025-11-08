#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="$1"
OUT="$ROOT/reports/bandit"
mkdir -p "$OUT"
echo "Running Bandit scan..."
bandit -r "$TARGET" -f json -o "$OUT/bandit.json"
bandit -r "$TARGET" -f html -o "$OUT/bandit.html"
echo "Bandit reports generated at $OUT"
