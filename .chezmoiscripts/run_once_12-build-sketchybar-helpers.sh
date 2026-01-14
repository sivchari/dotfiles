#!/bin/bash

# Build SketchyBar helpers (network_load event provider)
# Built from sketchybar config directory

set -e

HELPERS_DIR="$HOME/.config/sketchybar/helpers"
NETWORK_LOAD_BIN="$HELPERS_DIR/event_providers/network_load/bin/network_load"

if [ -d "$HELPERS_DIR/event_providers/network_load" ] && [ ! -f "$NETWORK_LOAD_BIN" ]; then
  echo "Building sketchybar helpers..."
  cd "$HELPERS_DIR"
  make
  echo "SketchyBar helpers installed."
fi
