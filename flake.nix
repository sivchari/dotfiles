{
  description = "sivchari's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-claude-code = {
      url = "github:ryoppippi/nix-claude-code";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    neovim-nightly-overlay,
    nix-claude-code,
    ...
  }: let
    system = "aarch64-darwin";
    localPath = builtins.getEnv "DOTFILES_LOCAL_NIX";
    local =
      if localPath == ""
      then throw "Set DOTFILES_LOCAL_NIX and run with --impure."
      else import localPath;

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        neovim-nightly-overlay.overlays.default
        nix-claude-code.overlays.default
        (final: _: {btmon = final.callPackage ./packages/btmon {};})
        # eMudhra CA compromise (2026-10): nixpkgs still ships nodejs 24.21.0,
        # whose bundled root store trusts the compromised intermediates. Ship
        # the official binary as a stopgap; drop nodejs-bin and switch
        # home.packages back to nodejs once nixpkgs reaches >= 24.22.1.
        # https://emudhra.we-have-a-problem.com/
        (final: _: {
          nodejs-bin = final.stdenvNoCC.mkDerivation rec {
            pname = "nodejs-bin";
            version = "24.22.1";
            src = final.fetchurl {
              url = "https://nodejs.org/dist/v${version}/node-v${version}-darwin-arm64.tar.xz";
              sha256 = "654ba79de6155647e22321932b45f2a1ccb705976cc337c9b8e278beb085a628";
            };
            # keep the Apple code signature intact
            dontFixup = true;
            installPhase = ''
              mkdir -p $out
              cp -R bin include lib share $out/
            '';
          };
        })
      ];
      config.allowUnfree = true;
    };

    mkDarwin = {username}:
      nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {inherit username;};
        modules = [
          ./hosts/darwin
          {nixpkgs.pkgs = pkgs;}
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${username} = import ./home;
              extraSpecialArgs = {inherit username;};
            };
          }
        ];
      };
  in {
    darwinConfigurations = {
      ${local.hostname} = mkDarwin {
        username = local.username;
      };
    };
  };
}
