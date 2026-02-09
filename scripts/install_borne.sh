#!/bin/bash
set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Ce script doit être exécuté en root (sudo)." >&2
  exit 1
fi

USER_NAME="${SUDO_USER:-pi}"
USER_HOME="$(getent passwd "$USER_NAME" | cut -d: -f6)"

if [[ -z "$USER_HOME" ]]; then
  echo "Impossible de déterminer le home de l'utilisateur." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# 1) Dépendances système
"$SCRIPT_DIR/setup_rpi_os.sh"

# 2) Installation du service systemd
"$SCRIPT_DIR/install_systemd.sh"

# 3) Installation du hook git post-merge
"$SCRIPT_DIR/install_git_hook.sh"

# 4) Compilation initiale
cd "$REPO_ROOT"
./compilation.sh

# 5) Redémarrage service
systemctl restart borne-arcade.service

echo "Installation terminée."
