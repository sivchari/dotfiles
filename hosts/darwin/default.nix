{
  pkgs,
  username,
  ...
}: let
  home = "/Users/${username}";
  basePath = "/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin:/usr/sbin:/sbin";
  profilePath = "/etc/profiles/per-user/${username}/bin";
  # nix-darwin's services.{sketchybar,jankyborders,aerospace} cannot express the
  # env vars, WorkingDirectory, and external configs we need, so keep hand-written launchd agents
  agentPath = "${profilePath}:${home}/.local/bin:${basePath}";
  bordersPath = "${profilePath}:${basePath}";
in {
  nix.enable = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" username];
  };

  system.stateVersion = 6;
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
        PATH = agentPath;
      };
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  launchd.user.agents.borders = {
    serviceConfig = {
      ProgramArguments = ["/bin/bash" "/Users/${username}/.config/borders/bordersrc"];
      EnvironmentVariables = {
        PATH = bordersPath;
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
        PATH = agentPath;
      };
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  system.activationScripts.extraActivation.text = ''
    if ! xcode-select -p &>/dev/null; then
      xcode-select --install || true
    fi

    # Grant TCC Bluetooth permission to nix-managed binaries
    # Nix store paths change on every rebuild, so we re-grant on each activation.
    TCC_DB="/Users/${username}/Library/Application Support/com.apple.TCC/TCC.db"
    for bin in ${pkgs.blueutil}/bin/blueutil ${pkgs.btmon}/bin/btmon ${pkgs.sketchybar}/bin/sketchybar; do
      ${pkgs.sqlite}/bin/sqlite3 "$TCC_DB" "INSERT OR REPLACE INTO access (service, client, client_type, auth_value, auth_reason, auth_version, indirect_object_identifier, boot_uuid) VALUES ('kTCCServiceBluetoothAlways', '$bin', 1, 2, 2, 1, 'UNUSED', 'UNUSED');" 2>/dev/null || true
    done
  '';
}
