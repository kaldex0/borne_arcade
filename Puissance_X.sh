#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

resolve_mg2d() {
	if [[ -n "${MG2D_PATH:-}" && -d "$MG2D_PATH" ]]; then
		echo "$MG2D_PATH"
		return 0
	fi

	if [[ -d "$REPO_ROOT/../MG2D" ]]; then
		echo "$REPO_ROOT/../MG2D"
		return 0
	fi

	if [[ -d "/home/pi/git/MG2D" ]]; then
		echo "/home/pi/git/MG2D"
		return 0
	fi

	return 1
}

if ! MG2D_DIR="$(resolve_mg2d)"; then
	echo "MG2D introuvable. Definir MG2D_PATH ou placer MG2D a cote du repo." >&2
	exit 1
fi

xdotool mousemove 1280 1024 2>/dev/null || true
cd "$REPO_ROOT/projet/Puissance_X"
java -cp ".:$REPO_ROOT:$MG2D_DIR" -Dsun.java2d.pmoffscreen=false Main

# -Dsun.java2d.pmoffscreen=false : Améliore les performances sur les système Unix utilisant X11 (donc Raspbian est concerné).
# -Dsun.java2d.opengl=true : Utilise OpenGL (peut améliorer les performances).
