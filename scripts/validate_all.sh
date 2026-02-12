#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

"$SCRIPT_DIR/validate_dependencies.sh"
"$SCRIPT_DIR/validate_assets.sh"
"$SCRIPT_DIR/validate_launchers.sh"

echo "Validation globale: OK"
