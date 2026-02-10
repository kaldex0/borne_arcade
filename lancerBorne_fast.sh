#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

MG2D_PATH=""
if [[ -d "$REPO_ROOT/../MG2D" ]]; then
  MG2D_PATH="$REPO_ROOT/../MG2D"
elif [[ -d "$REPO_ROOT/MG2D" ]]; then
  MG2D_PATH="$REPO_ROOT/MG2D"
elif [[ -d "$HOME/MG2D" ]]; then
  MG2D_PATH="$HOME/MG2D"
fi

if [[ -z "$MG2D_PATH" ]]; then
  echo "Erreur: MG2D introuvable. Placez MG2D a cote du repo (../MG2D) ou dans $HOME/MG2D." >&2
  exit 1
fi

setxkbmap borne || true

cd "$REPO_ROOT"

./clean.sh || true
./compilation_fast.sh

echo "Lancement du Menu (fast)"
java -cp ".:$MG2D_PATH" Main

./clean.sh || true

if [[ "${DISABLE_AUTO_HALT:-0}" != "1" ]]; then
  for i in {30..1}
  do
      echo Extinction de la borne dans $i secondes
      sleep 1
  done

  sudo halt
fi
