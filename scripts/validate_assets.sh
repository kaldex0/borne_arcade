#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

missing=0

check_game_dir() {
  local game_dir="$1"
  local game_name
  game_name="$(basename "$game_dir")"

  if [[ ! -f "$REPO_ROOT/${game_name}.sh" ]]; then
    echo "[MANQUANT] script: ${game_name}.sh"
    missing=1
  fi

  if [[ ! -f "$game_dir/description.txt" ]]; then
    echo "[MANQUANT] description.txt: $game_name"
    missing=1
  fi

  if [[ ! -f "$game_dir/bouton.txt" ]]; then
    echo "[MANQUANT] bouton.txt: $game_name"
    missing=1
  elif [[ ! -s "$game_dir/bouton.txt" ]]; then
    echo "[VIDE] bouton.txt: $game_name"
  fi

  if [[ ! -f "$game_dir/photo_small.png" ]]; then
    echo "[MANQUANT] photo_small.png: $game_name"
    missing=1
  fi
}

if [[ ! -d "$REPO_ROOT/projet" ]]; then
  echo "Dossier projet/ introuvable." >&2
  exit 1
fi

for d in "$REPO_ROOT/projet"/*/; do
  [[ -d "$d" ]] || continue
  check_game_dir "$d"
done

if [[ $missing -ne 0 ]]; then
  echo "Validation assets: ECHEC"
  exit 2
fi

echo "Validation assets: OK"
