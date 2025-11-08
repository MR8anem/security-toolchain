#!/bin/sh

WORKSPACE=$(pwd)/..
TARGET_DIR="$1"
REPORT_DIR="$WORKSPACE/reports/bandit"

echo "Running Bandit scan on $TARGET_DIR..."

mkdir -p "$REPORT_DIR"

# Use absolute path to venv executables
"$WORKSPACE/.venv/bin/bandit" -r "$TARGET_DIR" -f json -o "$REPORT_DIR/bandit.json"
"$WORKSPACE/.venv/bin/bandit" -r "$TARGET_DIR" -f html -o "$REPORT_DIR/bandit.html"

echo "Bandit reports generated at $REPORT_DIR"
