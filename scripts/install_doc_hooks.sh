#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
HOOK_DIR="$REPO_ROOT/.git/hooks"

if [[ ! -d "$HOOK_DIR" ]]; then
  echo "Ce dossier n'est pas un depot git: $REPO_ROOT" >&2
  exit 1
fi

cat > "$HOOK_DIR/pre-push" <<'EOF'
#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

"$REPO_ROOT/scripts/generate_docs.sh"
"$REPO_ROOT/scripts/validate_docs.sh"
"$REPO_ROOT/scripts/validate_all.sh"

git diff --exit-code "$REPO_ROOT/Documents/Documentation/generated"
EOF

chmod +x "$HOOK_DIR/pre-push"

echo "Hook pre-push docs installe: $HOOK_DIR/pre-push"
