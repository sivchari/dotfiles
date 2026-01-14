#!/bin/bash
# Import configs/raycast/{snippets,quicklinks}.json into Raycast via deeplinks.
#
# Snippets use the repeated singular `snippet=` param (one URL-encoded JSON
# object each); Raycast skips snippets whose name/text/keyword already exist,
# so re-running is idempotent. Quicklinks go through the import-quicklinks
# command's `context` param (the deeplink ray.so uses); re-running can
# duplicate quicklinks, so review the confirmation dialog before accepting.
#
# Each import opens its own confirmation dialog, and a second deeplink would
# replace the first one's window, so we wait for Enter in between.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SNIPPETS_JSON="${REPO_DIR}/configs/raycast/snippets.json"
QUICKLINKS_JSON="${REPO_DIR}/configs/raycast/quicklinks.json"

if ! open -Ra Raycast 2>/dev/null; then
  echo "error: Raycast.app not found. Run 'make rebuild' first." >&2
  exit 1
fi

for json in "${SNIPPETS_JSON}" "${QUICKLINKS_JSON}"; do
  if [ ! -f "${json}" ]; then
    echo "error: ${json} not found." >&2
    exit 1
  fi
done

snippet_query="$(jq -r '[.[] | "snippet=" + ({name, text, keyword} | tojson | @uri)] | join("&")' "${SNIPPETS_JSON}")"
echo "Importing $(jq 'length' "${SNIPPETS_JSON}") snippet(s) from ${SNIPPETS_JSON}"
open "raycast://snippets/import?${snippet_query}"

read -rp "Confirm the snippets dialog in Raycast, then press Enter to import quicklinks..."

quicklink_context="$(jq -r 'map({name, link}) | tojson | @uri' "${QUICKLINKS_JSON}")"
echo "Importing $(jq 'length' "${QUICKLINKS_JSON}") quicklink(s) from ${QUICKLINKS_JSON}"
open "raycast://extensions/raycast/quicklinks/import-quicklinks?context=${quicklink_context}"
