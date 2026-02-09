#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

# Met à jour depuis le dépôt distant si un remote est configuré
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git remote -v >/dev/null 2>&1; then
    git pull --rebase
  fi
fi

# Recompile si besoin
./compilation.sh

# Redémarre le service si présent
if systemctl is-enabled borne-arcade.service >/dev/null 2>&1; then
  systemctl restart borne-arcade.service
fi

echo "Mise à jour terminée."
