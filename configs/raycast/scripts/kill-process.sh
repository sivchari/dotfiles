#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Kill Process
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "port or name" }

# Optional parameters:
# @raycast.packageName Dotfiles

if [[ "$1" =~ ^[0-9]+$ ]]; then
  pids="$(lsof -ti "tcp:$1" || true)"
  target="port $1"
else
  # pgrep -f matches full command lines, which includes this script's own
  # invocation (the argument is part of it), so filter out our own PID.
  pids="$(pgrep -if -- "$1" | grep -vx "$$" || true)"
  target="'$1'"
fi

if [ -z "${pids}" ]; then
  echo "No process matching ${target}"
  exit 1
fi

echo "${pids}" | xargs kill
echo "Killed $(echo "${pids}" | wc -l | tr -d ' ') process(es) matching ${target}"
