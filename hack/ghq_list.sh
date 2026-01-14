#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ghq list >"${SCRIPT_DIR}/../ghq_list.txt"
