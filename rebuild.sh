#!/bin/bash
set -euo pipefail

HOSTNAME_VALUE="${1:-$(scutil --get LocalHostName 2>/dev/null || hostname -s)}"
LOCAL_NIX_PATH="${DOTFILES_LOCAL_NIX:-$HOME/.config/dotfiles/local.nix}"

DOTFILES_LOCAL_NIX="${LOCAL_NIX_PATH}" \
  sudo --preserve-env=DOTFILES_LOCAL_NIX darwin-rebuild switch --impure --flake ".#${HOSTNAME_VALUE}"
