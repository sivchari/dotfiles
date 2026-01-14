#!/bin/bash

# Build JankyBorders from source
# https://github.com/FelixKratz/JankyBorders

set -e

BORDERS_SRC="$HOME/.local/src/JankyBorders"
BORDERS_BIN="$HOME/.local/bin/borders"

mkdir -p "$HOME/.local/bin"

if [ -d "$BORDERS_SRC" ] && [ ! -f "$BORDERS_BIN" ]; then
  echo "Building JankyBorders..."
  cd "$BORDERS_SRC"
  make
  cp bin/borders "$BORDERS_BIN"
  echo "JankyBorders installed."
fi
