#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Kill Port
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "port" }

# Optional parameters:
# @raycast.packageName Dotfiles

pids="$(lsof -ti "tcp:$1" || true)"

if [ -z "${pids}" ]; then
  echo "Nothing is listening on port $1"
  exit 1
fi

echo "${pids}" | xargs kill
echo "Killed $(echo "${pids}" | wc -l | tr -d ' ') process(es) on port $1"
