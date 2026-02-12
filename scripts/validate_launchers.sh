#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

missing=0

check_script() {
  local game_name="$1"
  local script="$REPO_ROOT/${game_name}.sh"

  if [[ ! -f "$script" ]]; then
    echo "[MANQUANT] script: ${game_name}.sh"
    missing=1
    return
  fi

  if [[ ! -x "$script" ]]; then
    echo "[NON-EXEC] ${game_name}.sh"
  fi

  if grep -q "python3" "$script"; then
    if ! command -v python3 >/dev/null 2>&1; then
      echo "[OPTIONNEL] python3 manquant pour $game_name"
    fi
  fi

  if grep -q "love" "$script"; then
    if ! command -v love >/dev/null 2>&1; then
      echo "[OPTIONNEL] love manquant pour $game_name"
    fi
  fi

  if grep -q "java" "$script"; then
    if ! command -v java >/dev/null 2>&1; then
      echo "[MANQUANT] java pour $game_name"
      missing=1
    fi
  fi
}

if [[ ! -d "$REPO_ROOT/projet" ]]; then
  echo "Dossier projet/ introuvable." >&2
  exit 1
fi

for d in "$REPO_ROOT/projet"/*/; do
  [[ -d "$d" ]] || continue
  check_script "$(basename "$d")"
done

if [[ $missing -ne 0 ]]; then
  echo "Validation launchers: ECHEC"
  exit 2
fi

echo "Validation launchers: OK"
