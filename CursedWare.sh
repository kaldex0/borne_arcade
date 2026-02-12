#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

if ! command -v love >/dev/null 2>&1; then
	echo "love introuvable. Installez LOVE2D." >&2
	exit 1
fi

cd "$REPO_ROOT/projet/CursedWare"
love .
