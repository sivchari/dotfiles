#!/bin/bash

# Install Hack Nerd Font
# https://github.com/ryanoasis/nerd-fonts

set -e

FONT_DIR="$HOME/Library/Fonts"
FONT_CHECK="$FONT_DIR/HackNerdFont-Regular.ttf"

if [ ! -f "$FONT_CHECK" ]; then
  echo "Installing Hack Nerd Font..."

  TEMP_DIR=$(mktemp -d)
  cd "$TEMP_DIR"

  # Download from GitHub releases
  curl -sLO "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip"

  # Extract to Fonts directory
  unzip -o Hack.zip -d "$FONT_DIR"

  # Cleanup
  cd -
  rm -rf "$TEMP_DIR"

  echo "Hack Nerd Font installed."
else
  echo "Hack Nerd Font already installed."
fi
