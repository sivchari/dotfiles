#!/bin/bash

# Setup cc-kit (Claude Code Kit)
# Clone/update repository and create symlinks

set -e

# Ensure aqua-managed tools (ghq) are on PATH
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"

CC_KIT_REPO="git@github.com:sivchari/cc-kit.git"
GHQ_ROOT="$(ghq root)"

# Find cc-kit path using ghq list
CC_KIT_PATH=$(ghq list --full-path | grep -E "sivchari/cc-kit$" || true)

if [ -n "$CC_KIT_PATH" ]; then
  echo "Updating cc-kit..."
  git -C "$CC_KIT_PATH" pull --ff-only || true
else
  echo "Cloning cc-kit..."
  ghq get "$CC_KIT_REPO"
  CC_KIT_PATH=$(ghq list --full-path | grep -E "sivchari/cc-kit$")
fi

# Run setup script (ignore errors from missing optional directories)
if [ -f "$CC_KIT_PATH/setup.sh" ]; then
  echo "Running cc-kit setup..."
  bash "$CC_KIT_PATH/setup.sh" || echo "Warning: cc-kit setup had errors (some optional directories may be missing)"
fi

echo "cc-kit setup complete."
