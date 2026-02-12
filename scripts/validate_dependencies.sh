#!/bin/bash
set -euo pipefail

required=(git java)
optional=(python3 love xdotool)

missing=0

for bin in "${required[@]}"; do
  if ! command -v "$bin" >/dev/null 2>&1; then
    echo "[MANQUANT] $bin"
    missing=1
  fi
done

for bin in "${optional[@]}"; do
  if ! command -v "$bin" >/dev/null 2>&1; then
    echo "[OPTIONNEL] $bin"
  fi
done

if [[ $missing -ne 0 ]]; then
  echo "Validation dependances: ECHEC"
  exit 2
fi

echo "Validation dependances: OK"
