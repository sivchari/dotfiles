#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local"
DOTFILES_REPO="sivchari/dotfiles"
GPG_NAME="Takuma Shibuya"
GPG_EMAIL="shibuuuu5@gmail.com"

echo '***************************************************'
echo 'GPG Key Setup'
echo '***************************************************'
if ! command -v gpg &> /dev/null; then
  echo "GPG not found. Please install GPG first."
  echo "  macOS: Install GPG Suite from https://gpgtools.org/"
  exit 1
fi

GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$GPG_EMAIL" 2>/dev/null | grep sec | head -1 | sed 's/.*\/\([A-F0-9]*\).*/\1/' || true)

if [ -z "$GPG_KEY_ID" ]; then
  echo "No GPG key found for $GPG_EMAIL. Creating new key..."

  cat > /tmp/gpg-key-config << EOF
%echo Generating GPG key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: $GPG_NAME
Name-Email: $GPG_EMAIL
Expire-Date: 0
%commit
%echo Done
EOF

  gpg --batch --generate-key /tmp/gpg-key-config
  rm /tmp/gpg-key-config

  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$GPG_EMAIL" 2>/dev/null | grep sec | head -1 | sed 's/.*\/\([A-F0-9]*\).*/\1/')
fi

echo "Using GPG key: $GPG_KEY_ID"

echo '***************************************************'
echo 'chezmoi + dotfiles'
echo '***************************************************'
if ! command -v chezmoi &> /dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi
export PATH="$HOME/.local/bin:$PATH"

mkdir -p "$HOME/.config/chezmoi"
cat > "$HOME/.config/chezmoi/chezmoi.toml" << EOF
[data]
    gpg_signing_key = "$GPG_KEY_ID"
EOF

if [ ! -d "$HOME/.local/share/chezmoi" ]; then
  chezmoi init --apply "$DOTFILES_REPO"
else
  chezmoi apply
fi

echo '***************************************************'
echo 'aqua'
echo '***************************************************'
if ! command -v aqua &> /dev/null; then
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.0/aqua-installer | bash
fi
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
AQUA_GLOBAL_CONFIG=$HOME/.config/aqua/aqua.yaml aqua i -a

echo '***************************************************'
echo 'rustup + sheldon'
echo '***************************************************'
if ! command -v rustup &> /dev/null; then
  rustup-init -y --no-modify-path
fi
export PATH="$HOME/.cargo/bin:$PATH"
if ! command -v sheldon &> /dev/null; then
  export OPENSSL_DIR="$INSTALL_DIR/openssl"
  export PKG_CONFIG_PATH="$OPENSSL_DIR/lib64/pkgconfig"
  cargo install sheldon
else
  echo 'sheldon already installed, skipping...'
fi

echo '***************************************************'
echo 'Cleanup'
echo '***************************************************'
rm -f "$HOME/.local/bin/chezmoi"

echo '***************************************************'
echo 'Done!'
echo '***************************************************'
echo ''
echo 'GPG public key for GitHub registration:'
echo '***************************************************'
gpg --armor --export "$GPG_KEY_ID"
echo '***************************************************'
echo ''
echo 'Register this key at: https://github.com/settings/gpg/new'
echo ''
echo 'Then run: exec zsh'
