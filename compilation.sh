#!/bin/bash
set -euo pipefail

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

echo "Compilation du menu de la borne d'arcade"
echo "Veuillez patienter"

if compgen -G "$REPO_ROOT"/*.java > /dev/null; then
    (cd "$REPO_ROOT" && javac -cp ".:$MG2D_DIR" *.java)
else
    echo "Aucun fichier Java pour le menu."
fi

for game_dir in "$REPO_ROOT/projet"/*/; do
    [[ -d "$game_dir" ]] || continue

    if ! compgen -G "$game_dir"/*.java > /dev/null; then
        continue
    fi

    echo "Compilation du jeu $(basename "$game_dir")"
    echo "Veuillez patienter"
    (cd "$game_dir" && javac -cp ".:$REPO_ROOT:$MG2D_DIR" *.java)
done
