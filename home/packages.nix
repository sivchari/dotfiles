{pkgs, ...}: let
  dendrite = import ../packages {inherit pkgs;};
  # herdr は server restart 後の resume で `claude --resume <id>` を素の環境で再実行するため
  # CLAUDE_CONFIG_DIR が失われ、~/.claude-personal のセッションが "No conversation found" で死ぬ
  # (herdrdev/herdr#1269, closed as not planned)。session ID の transcript がどの profile に
  # あるか探して CLAUDE_CONFIG_DIR を補ってから本体を exec する。
  claude-wrapped = pkgs.writeShellScriptBin "claude" ''
    if [ -z "''${CLAUDE_CONFIG_DIR:-}" ]; then
      sid= prev=
      for arg in "$@"; do
        case $prev in --resume | -r) sid=$arg ;; esac
        case $arg in --resume=*) sid=''${arg#--resume=} ;; esac
        prev=$arg
      done
      if [ -n "$sid" ]; then
        for profile in "$HOME/.claude" "$HOME/.claude-personal"; do
          if [ -n "$(find "$profile/projects" -maxdepth 2 -name "$sid.jsonl" -print -quit 2>/dev/null)" ]; then
            export CLAUDE_CONFIG_DIR=$profile
            break
          fi
        done
      fi
    fi
    exec ${pkgs.claude-code}/bin/claude "$@"
  '';
in {
  home.packages = with pkgs;
    dendrite
    ++ [
      # Kubernetes (nixpkgs)
      kubectx
      docker
      colima

      # Infrastructure (nixpkgs)
      argo-workflows
      google-cloud-sdk
      awscli2
      postgresql

      # Python
      # pipx 1.14.0 tests fail with pytest 9 (upstream nixpkgs breakage);
      # drop the override once nixpkgs ships a fixed pipx
      (pipx.overridePythonAttrs (_: {doCheck = false;}))

      # Languages & Runtimes (nixpkgs)
      go # bootstrap compiler for source builds
      rustup
      zig
      zls
      nodejs
      pnpm
      lua5_5

      # Language Servers & Dev Tools (nixpkgs)
      gopls
      gotools
      lua-language-server
      typescript-language-server

      # CLI Tools (nixpkgs)
      jq
      hugo
      envsubst

      # Desktop Apps
      neovim
      aerospace
      sketchybar
      jankyborders
      ghostty-bin
      blueutil

      # Fonts
      nerd-fonts.hack
      go-font

      # System & Build Tools
      plan9port
      # llvmPackages.clang
      sbarlua
      gnumake
      claude-wrapped
      codex

      # Custom Packages
      (callPackage ../packages/btmon {})
      (callPackage ../packages/sfw {})
    ];
}
