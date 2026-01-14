#!/bin/bash
set -euo pipefail

AGENT_KIT_DIR="${HOME}/workspace/sivchari/agent-kit"

if [ ! -d "${AGENT_KIT_DIR}" ]; then
  mkdir -p "$(dirname "${AGENT_KIT_DIR}")"
  git clone https://github.com/sivchari/agent-kit "${AGENT_KIT_DIR}"
fi

# Go source build
GO_DIR="${HOME}/workspace/go/go"
GO_BOOTSTRAP_DIR="${HOME}/workspace/go/go-darwin-arm64-bootstrap"

if [ ! -d "${GO_DIR}" ]; then
  mkdir -p "${HOME}/workspace/go"
  git clone https://go.googlesource.com/go "${GO_DIR}"
fi

if [ ! -d "${GO_BOOTSTRAP_DIR}" ]; then
  cd "${GO_DIR}/src"
  GOROOT_BOOTSTRAP="$(go env GOROOT)" GOOS=darwin GOARCH=arm64 ./bootstrap.bash
fi

cd "${GO_DIR}/src"
GOROOT_BOOTSTRAP="${GO_BOOTSTRAP_DIR}" ./make.bash
