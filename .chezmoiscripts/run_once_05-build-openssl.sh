#!/bin/bash

# Build OpenSSL from source
# https://github.com/openssl/openssl
# Required for building sheldon

set -e

OPENSSL_SRC="$HOME/.local/src/openssl"
OPENSSL_DIR="$HOME/.local/openssl"

if [ -d "$OPENSSL_SRC" ] && [ ! -d "$OPENSSL_DIR" ]; then
  echo "Building OpenSSL (this may take a while)..."
  cd "$OPENSSL_SRC"
  ./Configure --prefix="$OPENSSL_DIR" --openssldir="$OPENSSL_DIR"
  make -j$(sysctl -n hw.ncpu)
  make install
  echo "OpenSSL installed to $OPENSSL_DIR"
fi
