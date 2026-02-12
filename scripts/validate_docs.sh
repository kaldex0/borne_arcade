#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$REPO_ROOT/Documents/Documentation/src"
OUT_DIR="$REPO_ROOT/Documents/Documentation/generated"

missing=0

for f in "$SRC_DIR"/*.md; do
  base="$(basename "$f")"
  if [[ ! -f "$OUT_DIR/$base" ]]; then
    echo "[MANQUANT] $OUT_DIR/$base"
    missing=1
  fi
  if grep -q "{{" "$f"; then
    echo "[INFO] placeholders in $base"
  fi
done

if [[ $missing -ne 0 ]]; then
  echo "Validation docs: ECHEC"
  exit 2
fi

echo "Validation docs: OK"
