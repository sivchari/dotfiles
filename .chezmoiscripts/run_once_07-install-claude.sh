#!/bin/bash

# Install Claude Desktop from DMG
# https://claude.ai/download

set -e

CLAUDE_DMG="$HOME/.local/share/Claude.dmg"
CLAUDE_APP="/Applications/Claude.app"

if [ -f "$CLAUDE_DMG" ] && [ ! -d "$CLAUDE_APP" ]; then
  echo "Installing Claude Desktop..."

  # Mount DMG
  MOUNT_POINT=$(hdiutil attach "$CLAUDE_DMG" -nobrowse | grep "/Volumes" | awk '{print $3}')

  # Copy app to Applications
  cp -R "$MOUNT_POINT/Claude.app" /Applications/

  # Unmount DMG
  hdiutil detach "$MOUNT_POINT" -quiet

  # Remove quarantine attribute
  xattr -d com.apple.quarantine "$CLAUDE_APP" 2>/dev/null || true

  echo "Claude Desktop installed."
fi
