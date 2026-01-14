#!/bin/bash

# Build SketchyBar from source (arm64)
# https://github.com/FelixKratz/SketchyBar

set -e

SKETCHYBAR_SRC="$HOME/.local/src/SketchyBar"
SKETCHYBAR_BIN="$HOME/.local/bin/sketchybar"

mkdir -p "$HOME/.local/bin"

if [ -d "$SKETCHYBAR_SRC" ] && [ ! -f "$SKETCHYBAR_BIN" ]; then
  echo "Building SketchyBar..."
  cd "$SKETCHYBAR_SRC"
  make arm64
  cp bin/sketchybar "$SKETCHYBAR_BIN"
  echo "SketchyBar installed."
fi
