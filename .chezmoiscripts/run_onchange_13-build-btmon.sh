#!/bin/bash

# Build btmon from source (Rust)
# https://github.com/sivchari/btmon
# Version: 1

set -e

BTMON_SRC="$HOME/.local/src/btmon"
BTMON_BIN="$HOME/.local/bin/btmon"

mkdir -p "$HOME/.local/bin"

if [ -d "$BTMON_SRC" ]; then
  echo "Building btmon..."
  cd "$BTMON_SRC"
  cargo build --release
  cp target/release/btmon "$BTMON_BIN"
  echo "btmon installed."
fi
