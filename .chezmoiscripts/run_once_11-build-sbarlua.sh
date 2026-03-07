#!/bin/bash

# Build SbarLua from source (includes Lua 5.4)
# https://github.com/FelixKratz/SbarLua

set -e

SBARLUA_SRC="$HOME/.local/src/SbarLua"
SBARLUA_LIB="$HOME/.local/share/sketchybar_lua/sketchybar.so"
LUA_BIN="$HOME/.local/bin/lua"

mkdir -p "$HOME/.local/share/sketchybar_lua"
mkdir -p "$HOME/.local/bin"

# Build Lua from SbarLua's bundled source if not installed
LUA_DIR=$(find "$SBARLUA_SRC" -maxdepth 1 -type d -name "lua-*" | head -1)

if [ -n "$LUA_DIR" ] && [ ! -f "$LUA_BIN" ]; then
  echo "Building Lua from $LUA_DIR..."
  cd "$LUA_DIR"
  make macosx
  # Only copy binaries (doc directory may not exist)
  cp src/lua src/luac "$HOME/.local/bin/"
  echo "Lua installed to ~/.local/bin/lua"
fi

# Build SbarLua
if [ -d "$SBARLUA_SRC" ] && [ ! -f "$SBARLUA_LIB" ]; then
  echo "Building SbarLua..."
  cd "$SBARLUA_SRC"
  make
  cp bin/sketchybar.so "$HOME/.local/share/sketchybar_lua/"
  echo "SbarLua installed."
fi
