#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$REPO_ROOT/Documents/Documentation/src"

empty=0

for f in "$SRC_DIR"/*.md; do
  if [[ ! -s "$f" ]]; then
    echo "[VIDE] $f"
    empty=1
  fi
  if grep -q $'\t' "$f"; then
    echo "[TAB] $f"
  fi
done

if [[ $empty -ne 0 ]]; then
  echo "Lint docs: ECHEC"
  exit 2
fi

echo "Lint docs: OK"
