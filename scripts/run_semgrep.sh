#!/bin/bash
set -e

TARGET_DIR="$1"
RULES_DIR="$2"
REPORT_DIR="../reports/semgrep"

mkdir -p "$REPORT_DIR"

echo "Running Semgrep scan..."
../.venv/bin/semgrep --config "$RULES_DIR" "$TARGET_DIR" --json > "$REPORT_DIR/semgrep.json"
../.venv/bin/semgrep --config "$RULES_DIR" "$TARGET_DIR" --html > "$REPORT_DIR/semgrep.html"

echo "Semgrep reports generated at $REPORT_DIR"
