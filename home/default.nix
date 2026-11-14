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
    # Read by the Rex server; apply edits with `rex config reload` (or shift+cmd+r).
    "rex/init.lua".source = ../configs/rex/init.lua;
    # Register this directory once in Raycast: Settings -> Extensions -> Script Commands
    "raycast/scripts" = {
      source = ../configs/raycast/scripts;
      recursive = true;
    };
    "sheldon/plugins.toml".source = ../configs/sheldon/plugins.toml;
    "sheldon/zsh/sync.zsh".source = ../configs/sheldon/zsh/sync.zsh;
    "git/ignore".source = ../configs/git/ignore;
  };

  home.activation.buildSketchybarHelpers = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f "$HOME/.config/sketchybar/helpers/Makefile" ]; then
      cd "$HOME/.config/sketchybar/helpers"
      PATH="${pkgs.llvmPackages.clang}/bin:${pkgs.gnumake}/bin:$PATH" make >/dev/null ||
        echo "warning: sketchybar helpers build failed" >&2
    fi
  '';

  # Free Cmd+Space for Raycast by disabling only Spotlight's hotkey (symbolic
  # hotkey 64). -dict-add keeps the other entries intact. Takes effect after
  # re-login; Raycast's own hotkey is still assigned by hand on first launch.
  home.activation.disableSpotlightHotkey = lib.hm.dag.entryAfter ["writeBoundary"] ''
    /usr/bin/defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
      '<dict><key>enabled</key><false/></dict>'
  '';

  # Rex keeps its appearance in UserDefaults, not in init.lua. These keys were
  # read back after setting them in Rex's Settings; they are not a documented
  # format, so re-check them if a Rex update ignores them. Rex reads them at
  # launch: quit Rex before rebuilding, or it may write its old values back.
  # customThemes is JSON stored as data; configs/rex/acme-theme.json is the
  # Acme palette imported from the former Ghostty config.
  home.activation.rexDefaults = lib.hm.dag.entryAfter ["writeBoundary"] ''
    d() { /usr/bin/defaults write com.superlogical.rex "$@"; }
    d Workspace.customThemes -data \
      "$(${pkgs.jq}/bin/jq -cj . ${../configs/rex/acme-theme.json} | /usr/bin/xxd -p | tr -d '\n')"
    d Workspace.lightThemeID -string custom-24CA9D24-9A08-4045-ABC5-4706505A5960
    d Workspace.terminalFontName -string "Go Mono"
    d Workspace.terminalFontPointSize -float 13
    d Workspace.terminalAllowsLigatures -bool false
    d Workspace.terminalCursorBlinkUsesCustomInterval -bool false
    d Workspace.terminalCursorBlinkIntervalMilliseconds -int 0
    d Workspace.inactivePaneFadeMode -string both
  '';

  home.activation.linkSbarLua = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/.local/share/sketchybar_lua"
    ln -sf "${pkgs.sbarlua}/lib/lua/5.5/sketchybar.so" "$HOME/.local/share/sketchybar_lua/sketchybar.so"
  '';

  programs.home-manager.enable = true;
}
