{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      npm = "sfw npm";
      npx = "sfw npx";
      yarn = "sfw yarn";
      pnpm = "sfw pnpm";
      pip = "sfw pip";
      uv = "sfw uv";
    };
    initContent = ''
      export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

      cache_dir=''${XDG_CACHE_HOME:-$HOME/.cache}
      sheldon_cache="$cache_dir/sheldon.zsh"
      sheldon_toml="$HOME/.config/sheldon/plugins.toml"
      if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
        mkdir -p $cache_dir
        sheldon source > $sheldon_cache
      fi
      source "$sheldon_cache"
      unset cache_dir sheldon_cache sheldon_toml
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    package = pkgs.direnv.overrideAttrs (old: {
      env = (old.env or {}) // {
        CGO_ENABLED = 1;
      };
    });
  };
}
