#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
LOG_FILE="$REPO_ROOT/projet/CursedWare/launch.log"

{
	echo "[CursedWare] Launch at $(date -Is)"
	echo "[CursedWare] PWD=$PWD"
} >>"$LOG_FILE" 2>&1

exec >>"$LOG_FILE" 2>&1

find_love() {
	if command -v love >/dev/null 2>&1; then
		echo "love"
		return 0
	fi
	if command -v love2d >/dev/null 2>&1; then
		echo "love2d"
		return 0
	fi
	for candidate in /usr/bin/love /usr/local/bin/love /opt/love/love; do
		if [[ -x "$candidate" ]]; then
			echo "$candidate"
			return 0
		fi
	done
	return 1
}

LOVE_CMD=""
if LOVE_CMD="$(find_love)"; then
	echo "[CursedWare] Using LOVE2D: $LOVE_CMD"
else
	echo "love introuvable. Installez LOVE2D (paquet 'love') ou ajoutez-le au PATH." >&2
	exit 1
fi

cd "$REPO_ROOT/projet/CursedWare"
"$LOVE_CMD" .
