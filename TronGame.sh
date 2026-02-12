#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

if ! command -v python3 >/dev/null 2>&1; then
	echo "python3 introuvable. Installez Python 3." >&2
	exit 1
fi

cd "$REPO_ROOT/projet/TronGame"
python3 main.py