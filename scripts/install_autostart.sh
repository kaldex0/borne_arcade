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

AUTOSTART_DIR="$USER_HOME/.config/autostart"
mkdir -p "$AUTOSTART_DIR"

cp -f "$(dirname "$0")/../borne.desktop" "$AUTOSTART_DIR/borne.desktop"
chown "$USER_NAME":"$USER_NAME" "$AUTOSTART_DIR/borne.desktop"

echo "Autostart installé pour l'utilisateur $USER_NAME."