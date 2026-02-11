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

if ! setxkbmap borne; then
    echo "Avertissement: layout 'borne' introuvable."
fi

cd "$REPO_ROOT"
echo "nettoyage des répertoires"
echo "Veuillez patienter"
./clean.sh
./compilation.sh

echo "Lancement du Menu"
echo "Veuillez patienter"

java -cp ".:$MG2D_DIR" Main

./clean.sh

for i in {30..1}
do
    echo Extinction de la borne dans $i secondes
    sleep 1
done

sudo halt
