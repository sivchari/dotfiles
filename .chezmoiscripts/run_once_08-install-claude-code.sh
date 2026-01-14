#!/bin/bash

# Install Claude Code CLI
# https://code.claude.com/docs/en/setup

set -e

if ! command -v claude &> /dev/null; then
  echo "Installing Claude Code CLI..."
  curl -fsSL https://claude.ai/install.sh | bash
  echo "Claude Code CLI installed."
fi
