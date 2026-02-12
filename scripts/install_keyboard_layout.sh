#!/bin/bash
set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Ce script doit etre execute en root (sudo)." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SRC_LAYOUT="$REPO_ROOT/borne"
DEST_LAYOUT="/usr/share/X11/xkb/symbols/borne"

if [[ ! -f "$SRC_LAYOUT" ]]; then
  echo "Fichier layout introuvable: $SRC_LAYOUT" >&2
  exit 1
fi

cp -f "$SRC_LAYOUT" "$DEST_LAYOUT"
chmod 644 "$DEST_LAYOUT"

setxkbmap borne || true

echo "Layout clavier installe: $DEST_LAYOUT"
