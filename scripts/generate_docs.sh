#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$REPO_ROOT/Documents/Documentation/src"
OUT_DIR="$REPO_ROOT/Documents/Documentation/generated"

mkdir -p "$OUT_DIR"

GENERATED_AT="$(date '+%Y-%m-%d %H:%M:%S')"

build_game_list() {
  echo "| Jeu | Script | description.txt | bouton.txt | photo_small.png |"
  echo "| --- | --- | --- | --- | --- |"
  if [[ -d "$REPO_ROOT/projet" ]]; then
    for d in "$REPO_ROOT/projet"/*/; do
      [[ -d "$d" ]] || continue
      name="$(basename "$d")"
      script="$REPO_ROOT/${name}.sh"
      desc="$d/description.txt"
      bouton="$d/bouton.txt"
      photo="$d/photo_small.png"
      s_ok="MANQUANT"
      d_ok="MANQUANT"
      b_ok="MANQUANT"
      p_ok="MANQUANT"
      [[ -f "$script" ]] && s_ok="OK"
      [[ -f "$desc" ]] && d_ok="OK"
      [[ -f "$bouton" ]] && b_ok="OK"
      [[ -f "$photo" ]] && p_ok="OK"
      echo "| $name | $s_ok | $d_ok | $b_ok | $p_ok |"
    done
  fi
}

for src in "$SRC_DIR"/*.md; do
  base="$(basename "$src")"
  out="$OUT_DIR/$base"
  while IFS= read -r line; do
    line="${line//\{\{GENERATED_AT\}\}/$GENERATED_AT}"
    if [[ "$line" == "{{GAME_LIST}}" ]]; then
      build_game_list
    else
      echo "$line"
    fi
  done < "$src" > "$out"
  echo "Généré: $out"
 done

# Copie la doc minimale si utile
if [[ -f "$REPO_ROOT/Documents/Documentation/doc_minimale.md" ]]; then
  cp -f "$REPO_ROOT/Documents/Documentation/doc_minimale.md" "$OUT_DIR/doc_minimale.md"
fi

echo "Documentation générée dans $OUT_DIR"
