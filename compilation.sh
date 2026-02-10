#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"

MG2D_PATH=""
if [[ -d "$REPO_ROOT/../MG2D" ]]; then
    MG2D_PATH="$REPO_ROOT/../MG2D"
elif [[ -d "$REPO_ROOT/MG2D" ]]; then
    MG2D_PATH="$REPO_ROOT/MG2D"
elif [[ -d "$HOME/MG2D" ]]; then
    MG2D_PATH="$HOME/MG2D"
elif [[ -d "/home/pi/git/MG2D" ]]; then
    MG2D_PATH="/home/pi/git/MG2D"
fi

if [[ -z "$MG2D_PATH" ]]; then
    echo "Erreur: MG2D introuvable. Placez MG2D a cote du repo (../MG2D)." >&2
    exit 1
fi

echo "Compilation du menu de la borne d'arcade"
echo "Veuillez patienter"
javac -cp ".:$MG2D_PATH" *.java

cd projet


#PENSER A REMETTRE COMPILATION JEUX!!!
for i in *
do
    cd $i
    echo "Compilation du jeu "$i
    echo "Veuillez patienter"
    javac -cp ".:../..:$MG2D_PATH" *.java
    cd ..
done

cd ..
