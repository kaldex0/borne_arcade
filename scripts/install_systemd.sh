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

# Détermine la racine du repo à partir de l'emplacement du script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SERVICE_PATH="/etc/systemd/system/borne-arcade.service"

cat > "$SERVICE_PATH" <<EOF
[Unit]
Description=Borne Arcade
After=network.target

[Service]
Type=simple
User=$USER_NAME
WorkingDirectory=$REPO_ROOT
ExecStart=$REPO_ROOT/lancerBorne.sh
Restart=on-failure
RestartSec=5

[Install]
WantedBy=graphical.target
EOF

systemctl daemon-reload
systemctl enable borne-arcade.service
systemctl restart borne-arcade.service

# Désactive l'autostart LXDE pour éviter un double lancement
AUTOSTART_FILE="$USER_HOME/.config/autostart/borne.desktop"
if [[ -f "$AUTOSTART_FILE" ]]; then
  mv -f "$AUTOSTART_FILE" "$AUTOSTART_FILE.disabled"
  chown "$USER_NAME":"$USER_NAME" "$AUTOSTART_FILE.disabled"
fi

echo "Service systemd installé et démarré. Autostart LXDE désactivé si présent."