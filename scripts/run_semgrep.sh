#!/bin/sh

TARGET_DIR="$1"
RULES_DIR="$2"
REPORT_DIR="../reports/semgrep"

echo "Running Semgrep scan on $TARGET_DIR with rules from $RULES_DIR..."

mkdir -p "$REPORT_DIR"

# Run Semgrep JSON and HTML reports
../.venv/bin/semgrep --config "$RULES_DIR" "$TARGET_DIR" --json > "$REPORT_DIR/semgrep.json"
../.venv/bin/semgrep --config "$RULES_DIR" "$TARGET_DIR" --html > "$REPORT_DIR/semgrep.html"

echo "Semgrep reports generated at $REPORT_DIR"
