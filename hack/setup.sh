#!/bin/bash
set -euo pipefail

# Go source build
GO_DIR="${HOME}/workspace/go/go"
GO_BOOTSTRAP_DIR="${HOME}/workspace/go/go-darwin-arm64-bootstrap"

if [ ! -d "${GO_DIR}" ]; then
  mkdir -p "${HOME}/workspace/go"
  git clone https://go.googlesource.com/go "${GO_DIR}"
fi

GO_PROFILE_BIN="/etc/profiles/per-user/$(id -un)/bin/go"

if [ ! -d "${GO_BOOTSTRAP_DIR}" ]; then
  cd "${GO_DIR}/src"
  GOROOT_BOOTSTRAP="$("${GO_PROFILE_BIN}" env GOROOT)" GOOS=darwin GOARCH=arm64 ./bootstrap.bash
fi

if [ ! -x "${GO_DIR}/bin/go" ]; then
  cd "${GO_DIR}/src"
  GOROOT_BOOTSTRAP="${GO_BOOTSTRAP_DIR}" ./make.bash
fi

# gokui: Claude Code の skills / agents / rules / hooks を配るバイナリ。
# GOBIN は sync.zsh と同じ ${GO_DIR}/bin。両方の Claude profile に展開する。
GOBIN="${GO_DIR}/bin" "${GO_DIR}/bin/go" install github.com/sivchari/gokui/cmd/gokui@latest

for profile in "${HOME}/.claude" "${HOME}/.claude-personal"; do
  CLAUDE_CONFIG_DIR="${profile}" "${GO_DIR}/bin/gokui" install
done
