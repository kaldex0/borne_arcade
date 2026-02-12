#!/bin/bash
set -euo pipefail

# Usage: DOC_AI=1 ./scripts/doc_ai_patch.sh
# This script only proposes a patch; it never applies changes automatically.

if [[ "${DOC_AI:-}" != "1" ]]; then
  echo "DOC_AI=1 pour activer la generation de patch IA."
  exit 0
fi

if ! command -v ollama >/dev/null 2>&1; then
  echo "ollama introuvable. Installez Ollama localement." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

STYLE="$REPO_ROOT/Documents/Documentation/STYLE_GUIDE.md"
DIFF_FILE="$REPO_ROOT/.tmp_doc_diff.txt"
PATCH_FILE="$REPO_ROOT/docs_ai.patch"

mkdir -p "$REPO_ROOT/.tmp"

{
  echo "STYLE GUIDE:";
  cat "$STYLE";
  echo "\nCODE DIFF:";
  git -C "$REPO_ROOT" diff --cached;
} > "$DIFF_FILE"

echo "Generation patch IA..."
ollama run llama3 "Propose un patch unifie pour mettre a jour la doc. Ne modifie que Documents/Documentation/src et README.\n$(cat "$DIFF_FILE")" > "$PATCH_FILE"

echo "Patch propose: $PATCH_FILE"
