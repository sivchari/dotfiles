#!/bin/bash

# Bootstrap aqua and install all managed CLI tools
# This must run before other scripts that depend on aqua-managed tools (ghq, etc.)
# https://aquaproj.github.io/

set -e

AQUA_BIN="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin/aqua"

# Install aqua if not present
if [ ! -f "$AQUA_BIN" ]; then
  echo "Installing aqua..."
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.1/aqua-installer | bash
fi

# Set PATH so aqua-managed tools are available for subsequent scripts
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export AQUA_CONFIG="$HOME/.local/share/chezmoi/dot_config/aqua/aqua.yaml"

echo "Running aqua install..."
"$AQUA_BIN" install --all

echo "aqua bootstrap complete."
