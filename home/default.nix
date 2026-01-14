{
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./ssh.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11";
    sessionVariables = {
      LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [pkgs.libiconv]}";
    };
  };

  xdg.configFile = {
    "nvim" = {
      source = ../configs/nvim;
      recursive = true;
    };
    "aerospace/aerospace.toml".text = builtins.replaceStrings
      ["@USERNAME@"]
      [username]
      (builtins.readFile ../configs/aerospace/aerospace.toml);
    "sketchybar" = {
      source = ../configs/sketchybar;
      recursive = true;
    };
    "sketchybar/sketchybarrc" = {
      source = ../configs/sketchybar/sketchybarrc;
      executable = true;
    };
    "borders/bordersrc" = {
      source = ../configs/borders/bordersrc;
      executable = true;
    };
    "lazygit/config.yml".source = ../configs/lazygit/config.yml;
    # Appends ~/.config/dotfiles/herdr.local.toml when present, so machine-local
    # keybindings stay out of this repo. Needs --impure (rebuild.sh already uses it).
    "herdr/config.toml".text = let
      localToml = "/Users/${username}/.config/dotfiles/herdr.local.toml";
    in
      builtins.readFile ../configs/herdr/config.toml
      + lib.optionalString (builtins.pathExists localToml) ("\n" + builtins.readFile localToml);
    "sheldon/plugins.toml".source = ../configs/sheldon/plugins.toml;
    "sheldon/zsh/sync.zsh".source = ../configs/sheldon/zsh/sync.zsh;
    "git/ignore".source = ../configs/git/ignore;
  };

  home.file."Library/Application Support/com.mitchellh.ghostty/config".source = ../configs/ghostty/config;

  home.activation.buildSketchybarHelpers = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f "$HOME/.config/sketchybar/helpers/Makefile" ]; then
      cd "$HOME/.config/sketchybar/helpers"
      PATH="${pkgs.llvmPackages.clang}/bin:${pkgs.gnumake}/bin:$PATH" make >/dev/null ||
        echo "warning: sketchybar helpers build failed" >&2
    fi
  '';

  home.activation.linkSbarLua = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/.local/share/sketchybar_lua"
    ln -sf "${pkgs.sbarlua}/lib/lua/5.5/sketchybar.so" "$HOME/.local/share/sketchybar_lua/sketchybar.so"
  '';

  programs.home-manager.enable = true;
}
