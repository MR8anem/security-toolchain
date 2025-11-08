#!/bin/sh

TARGET_DIR="$1"
REPORT_DIR="../reports/bandit"

echo "Running Bandit scan on $TARGET_DIR..."

mkdir -p "$REPORT_DIR"

# Run Bandit JSON and HTML reports
../.venv/bin/bandit -r "$TARGET_DIR" -f json -o "$REPORT_DIR/bandit.json"
../.venv/bin/bandit -r "$TARGET_DIR" -f html -o "$REPORT_DIR/bandit.html"

echo "Bandit reports generated at $REPORT_DIR"
