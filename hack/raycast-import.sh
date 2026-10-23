#!/bin/bash
# Import configs/raycast/snippets.json into Raycast via its import deeplink.
#
# The deeplink takes a repeated singular `snippet=` param (one URL-encoded JSON
# object each). Raycast skips snippets whose name/text/keyword already exist,
# so re-running is idempotent. One "Import Snippets" confirmation dialog opens.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SNIPPETS_JSON="${REPO_DIR}/configs/raycast/snippets.json"

if ! open -Ra Raycast 2>/dev/null; then
  echo "error: Raycast.app not found. Run rebuild.sh first." >&2
  exit 1
fi

if [ ! -f "${SNIPPETS_JSON}" ]; then
  echo "error: ${SNIPPETS_JSON} not found." >&2
  exit 1
fi

query="$(jq -r '[.[] | "snippet=" + ({name, text, keyword} | tojson | @uri)] | join("&")' "${SNIPPETS_JSON}")"
url="raycast://snippets/import?${query}"

echo "Importing $(jq 'length' "${SNIPPETS_JSON}") snippet(s) from ${SNIPPETS_JSON}"
echo "Deeplink: ${url}"
open "${url}"
