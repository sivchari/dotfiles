#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Repo
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "repo" }

# Optional parameters:
# @raycast.packageName Dotfiles

# Raycast runs scripts with a minimal PATH; ghq lives in the nix profile.
PATH="/etc/profiles/per-user/${USER}/bin:${PATH}"

match="$(ghq list | grep -i -m1 -- "$1" || true)"

if [ -z "${match}" ]; then
  echo "No ghq repo matching '$1'"
  exit 1
fi

# A ghq root without the host directory lists repos as owner/repo, so add
# the default host back when the first path segment is not a hostname.
case "${match%%/*}" in
  *.*) url="https://${match}" ;;
  *) url="https://github.com/${match}" ;;
esac

open "${url}"
echo "Opened ${url}"
