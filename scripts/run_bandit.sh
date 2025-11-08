#!/bin/bash
set -e

TARGET_DIR="$1"
REPORT_DIR="../reports/bandit"

mkdir -p "$REPORT_DIR"

echo "Running Bandit scan..."
../.venv/bin/bandit -r "$TARGET_DIR" -f json -o "$REPORT_DIR/bandit.json"
../.venv/bin/bandit -r "$TARGET_DIR" -f html -o "$REPORT_DIR/bandit.html"

echo "Bandit reports generated at $REPORT_DIR"
