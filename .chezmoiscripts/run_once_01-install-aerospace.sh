#!/bin/bash

# Install AeroSpace.app to /Applications and create CLI symlink
# https://github.com/nikitabobko/AeroSpace

set -e

AEROSPACE_SRC="$HOME/.local/share/AeroSpace/AeroSpace.app"
AEROSPACE_DST="/Applications/AeroSpace.app"
AEROSPACE_CLI="$HOME/.local/share/AeroSpace/bin/aerospace"
LOCAL_BIN="$HOME/.local/bin"

# Install AeroSpace.app
if [ -d "$AEROSPACE_SRC" ] && [ ! -d "$AEROSPACE_DST" ]; then
  echo "Installing AeroSpace.app to /Applications..."
  cp -R "$AEROSPACE_SRC" "$AEROSPACE_DST"
  xattr -d com.apple.quarantine "$AEROSPACE_DST" 2>/dev/null || true
  echo "AeroSpace installed. Please grant Accessibility permission in System Settings."
fi

# Create CLI symlink
if [ -f "$AEROSPACE_CLI" ] && [ ! -L "$LOCAL_BIN/aerospace" ]; then
  mkdir -p "$LOCAL_BIN"
  ln -sf "$AEROSPACE_CLI" "$LOCAL_BIN/aerospace"
  echo "AeroSpace CLI symlinked to $LOCAL_BIN/aerospace"
fi
