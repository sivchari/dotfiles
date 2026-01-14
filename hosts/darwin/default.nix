{
  pkgs,
  username,
  ...
}: let
  btmon = pkgs.callPackage ../../packages/btmon {};
in {
  nix.enable = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" username];
  };

  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = username;
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  launchd.user.agents.sketchybar = {
    serviceConfig = {
      ProgramArguments = ["${pkgs.sketchybar}/bin/sketchybar" "--config" "/Users/${username}/.config/sketchybar/sketchybarrc"];
      WorkingDirectory = "/Users/${username}/.config/sketchybar";
      EnvironmentVariables = {
        CONFIG_DIR = "/Users/${username}/.config/sketchybar";
        HOME = "/Users/${username}";
        USER = username;
        PATH = "/etc/profiles/per-user/${username}/bin:/Users/${username}/.local/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  launchd.user.agents.borders = {
    serviceConfig = {
      ProgramArguments = ["/bin/bash" "/Users/${username}/.config/borders/bordersrc"];
      EnvironmentVariables = {
        PATH = "/etc/profiles/per-user/${username}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  launchd.user.agents.aerospace = {
    serviceConfig = {
      ProgramArguments = ["${pkgs.aerospace}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace"];
      EnvironmentVariables = {
        HOME = "/Users/${username}";
        USER = username;
        PATH = "/etc/profiles/per-user/${username}/bin:/Users/${username}/.local/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  system.activationScripts.extraActivation.text = ''
    if ! xcode-select -p &>/dev/null; then
      xcode-select --install || true
    fi

    # Remove legacy LaunchAgents that conflict with nix-darwin managed ones
    for plist in com.felixkratz.sketchybar com.felixkratz.borders; do
      plist_path="/Users/${username}/Library/LaunchAgents/$plist.plist"
      if [ -f "$plist_path" ]; then
        launchctl bootout "gui/$(id -u ${username})/$plist" 2>/dev/null || true
        rm -f "$plist_path"
      fi
    done

    # Grant TCC Bluetooth permission to nix-managed binaries
    # Nix store paths change on every rebuild, so we re-grant on each activation.
    TCC_DB="/Users/${username}/Library/Application Support/com.apple.TCC/TCC.db"
    for bin in ${pkgs.blueutil}/bin/blueutil ${btmon}/bin/btmon ${pkgs.sketchybar}/bin/sketchybar; do
      ${pkgs.sqlite}/bin/sqlite3 "$TCC_DB" "INSERT OR REPLACE INTO access (service, client, client_type, auth_value, auth_reason, auth_version, indirect_object_identifier, boot_uuid) VALUES ('kTCCServiceBluetoothAlways', '$bin', 1, 2, 2, 1, 'UNUSED', 'UNUSED');" 2>/dev/null || true
    done
  '';
}
