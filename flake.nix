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
