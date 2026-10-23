#!/bin/bash
# Back up Raycast settings into the repo as configs/raycast/Raycast.rayconfig.
#
# Raycast has no headless export, so this is two steps:
#   1. No .rayconfig newer than the repo copy -> open Raycast's export command
#      and exit; export manually, then run this script again.
#   2. A fresh export exists in ~/Downloads -> copy it into the repo.
#
# Export with an empty passphrase and clipboard history excluded: the file is
# then plain gzip JSON (diffable via `gunzip -S .rayconfig -c | jq .`) and free
# of clipboard data. Extension preferences may contain API keys; review the
# diff before committing.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEST="${REPO_DIR}/configs/raycast/Raycast.rayconfig"
EXPORT_DEEPLINK="raycast://extensions/raycast/raycast/export-settings-data"

latest=""
for candidate in "${HOME}/Downloads"/*.rayconfig; do
  [ -e "${candidate}" ] || continue
  if [ -z "${latest}" ] || [ "${candidate}" -nt "${latest}" ]; then
    latest="${candidate}"
  fi
done

if [ -z "${latest}" ] || { [ -e "${DEST}" ] && [ "${DEST}" -nt "${latest}" ]; }; then
  echo "No new export found in ~/Downloads. Opening Raycast's export command..."
  echo "Export with an EMPTY passphrase and WITHOUT clipboard history, then re-run this script."
  open "${EXPORT_DEEPLINK}"
  exit 0
fi

cp "${latest}" "${DEST}"
echo "Saved ${latest}"
echo "  -> ${DEST}"
echo "Review the diff before committing: gunzip -S .rayconfig -c '${DEST}' | jq ."
