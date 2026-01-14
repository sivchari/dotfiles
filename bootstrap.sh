#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
USERNAME="$(id -un)"
HOSTNAME_VALUE="${1:-$(scutil --get LocalHostName 2>/dev/null || hostname -s)}"
LOCAL_NIX_DIR="${HOME}/.config/dotfiles"
LOCAL_NIX_PATH="${LOCAL_NIX_DIR}/local.nix"

# Install Nix if not present
if ! command -v nix &>/dev/null; then
  sh <(curl -L https://nixos.org/nix/install)
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Persist flakes support for later shells, but do not rely on it for this run.
mkdir -p ~/.config/nix
cp "${SCRIPT_DIR}/configs/nix/nix.conf" ~/.config/nix/nix.conf

mkdir -p "${LOCAL_NIX_DIR}"
cat >"$LOCAL_NIX_PATH" <<EOF
{
  username = "${USERNAME}";
  hostname = "${HOSTNAME_VALUE}";
}
EOF

# Apply configuration once so gh and other managed tools are available.
DOTFILES_LOCAL_NIX="${LOCAL_NIX_PATH}" sudo --preserve-env=DOTFILES_LOCAL_NIX nix \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  run nix-darwin -- switch --impure --flake ".#${HOSTNAME_VALUE}"

# Register SSH key with GitHub
if command -v gh &>/dev/null && [ -f ~/.ssh/id_rsa.pub ]; then
  PUBLIC_KEY="$(<~/.ssh/id_rsa.pub)"

  has_github_ssh_key() {
    local key_type="$1"
    local endpoint

    case "$key_type" in
    authentication)
      endpoint="/user/keys"
      ;;
    signing)
      endpoint="/user/ssh_signing_keys"
      ;;
    *)
      return 1
      ;;
    esac

    gh api "${endpoint}" --paginate --jq '.[].key' 2>/dev/null | grep -Fqx "$PUBLIC_KEY"
  }

  gh auth login -p ssh
  gh auth refresh -h github.com -s admin:ssh_signing_key,admin:public_key

  if ! has_github_ssh_key signing; then
    gh ssh-key add ~/.ssh/id_rsa.pub --title "${HOSTNAME_VALUE}" --type signing
  fi

  if ! has_github_ssh_key authentication; then
    gh ssh-key add ~/.ssh/id_rsa.pub --title "${HOSTNAME_VALUE}" --type authentication
  fi
fi

"${SCRIPT_DIR}/setup.sh"
