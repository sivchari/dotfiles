#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

while IFS= read -r repo; do
  [ -n "$repo" ] || continue
  ghq get "$repo"
done <"${SCRIPT_DIR}/../ghq_list.txt"
