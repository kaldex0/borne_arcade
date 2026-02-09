#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

HOOK_DIR="$REPO_ROOT/.git/hooks"
if [[ ! -d "$HOOK_DIR" ]]; then
  echo "Ce dossier n'est pas un dépôt git: $REPO_ROOT" >&2
  exit 1
fi

HOOK_PATH="$HOOK_DIR/post-merge"
cat > "$HOOK_PATH" <<'EOF'
#!/bin/bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
"$REPO_ROOT/scripts/update_from_git.sh"
EOF

chmod +x "$HOOK_PATH"

echo "Hook post-merge installé: $HOOK_PATH"
