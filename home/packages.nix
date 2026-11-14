{pkgs, ...}: let
  dendrite = import ../packages {inherit pkgs;};
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
      nodejs-bin # TODO: back to nodejs once nixpkgs reaches >= 24.22.1 (eMudhra CA compromise)
      pnpm
      lua5_5

      # Language Servers & Dev Tools (nixpkgs)
      gopls
      gotools
      lua-language-server
      typescript-language-server
      pyright
      clang-tools
      graphql-language-service-cli

      # CLI Tools (nixpkgs)
      jq
      hugo
      envsubst

      # Desktop Apps
      neovim
      aerospace
      raycast
      sketchybar
      jankyborders
      blueutil

      # Fonts
      nerd-fonts.hack
      go-font

      # System & Build Tools
      plan9port
      sbarlua
      gnumake
      claude-code
      codex

      # Custom Packages
      btmon
      (callPackage ../packages/sfw {})
    ];
}
