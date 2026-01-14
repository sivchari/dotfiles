#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HOSTNAME_VALUE="${1:-$(scutil --get LocalHostName 2>/dev/null || hostname -s)}"
LOCAL_NIX_PATH="${DOTFILES_LOCAL_NIX:-$HOME/.config/dotfiles/local.nix}"

if [ ! -f "${LOCAL_NIX_PATH}" ]; then
  echo "error: ${LOCAL_NIX_PATH} not found. Run bootstrap.sh first or set DOTFILES_LOCAL_NIX." >&2
  exit 1
fi

DOTFILES_LOCAL_NIX="${LOCAL_NIX_PATH}" \
  sudo --preserve-env=DOTFILES_LOCAL_NIX darwin-rebuild switch --impure --flake "${SCRIPT_DIR}#${HOSTNAME_VALUE}"
