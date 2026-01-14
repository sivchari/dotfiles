#!/bin/bash

# Build plan9port from source
# https://github.com/9fans/plan9port

set -e

PLAN9_SRC="$HOME/.local/src/plan9port"
PLAN9_DIR="$HOME/plan9"

if [ -d "$PLAN9_SRC" ] && [ ! -d "$PLAN9_DIR" ]; then
  echo "Building plan9port (this may take a while)..."
  cp -R "$PLAN9_SRC" "$PLAN9_DIR"
  cd "$PLAN9_DIR"
  ./INSTALL
  echo "plan9port installed to $PLAN9_DIR"
fi
