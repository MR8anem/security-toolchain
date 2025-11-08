#!/bin/sh

WORKSPACE=$(pwd)

TARGET_DIR="$1"
RULES_DIR="$2"
REPORT_DIR="$WORKSPACE/reports/semgrep"

echo "Running Semgrep scan on $TARGET_DIR with rules from $RULES_DIR..."

mkdir -p "$REPORT_DIR"

# Run Semgrep and output JSON
"$WORKSPACE/.venv/bin/semgrep" --config "$RULES_DIR" "$TARGET_DIR" --json > "$REPORT_DIR/semgrep.json"

echo "Semgrep reports generated at $REPORT_DIR"
