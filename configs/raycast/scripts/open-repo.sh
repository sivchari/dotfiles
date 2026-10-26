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

open "https://${match}"
echo "Opened ${match}"
