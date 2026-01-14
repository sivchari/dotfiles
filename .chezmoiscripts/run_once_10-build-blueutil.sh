#!/bin/bash

# Build blueutil from source
# https://github.com/toy/blueutil

set -e

BLUEUTIL_SRC="$HOME/.local/src/blueutil"
BLUEUTIL_BIN="$HOME/.local/bin/blueutil"

mkdir -p "$HOME/.local/bin"

if [ -d "$BLUEUTIL_SRC" ] && [ ! -f "$BLUEUTIL_BIN" ]; then
  echo "Building blueutil..."
  cd "$BLUEUTIL_SRC"
  make
  cp blueutil "$BLUEUTIL_BIN"
  echo "blueutil installed."
fi
