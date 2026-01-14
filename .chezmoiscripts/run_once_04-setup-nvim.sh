#!/bin/bash

# Create symlink for Neovim nightly
# https://github.com/neovim/neovim

set -e

NVIM_SRC="$HOME/.local/share/nvim-nightly/bin/nvim"
NVIM_BIN="$HOME/.local/bin/nvim"

mkdir -p "$HOME/.local/bin"

if [ -f "$NVIM_SRC" ] && [ ! -L "$NVIM_BIN" ]; then
  echo "Creating Neovim symlink..."
  ln -sf "$NVIM_SRC" "$NVIM_BIN"
  echo "Neovim symlink created."
fi
