# dotfiles

My personal dotfiles managed with [Nix](https://nixos.org/) (nix-darwin + home-manager + flakes).

## Quick Start

```bash
# 1. Install Nix if needed, generate local.nix for this Mac, and apply configuration
./bootstrap.sh

# 2. Set up SSH key for GitHub
gh auth login -p ssh
gh ssh-key add ~/.ssh/id_rsa.pub --title "$(scutil --get LocalHostName)" --type signing
gh ssh-key add ~/.ssh/id_rsa.pub --title "$(scutil --get LocalHostName)" --type authentication
```

`bootstrap.sh` installs Nix if needed, generates `local.nix` from the current macOS user and `LocalHostName`, and applies the matching flake output. It writes that file to `~/.config/dotfiles/local.nix` so it does not need to be tracked by Git. The bootstrap run enables flakes via `--extra-experimental-features` and passes `DOTFILES_LOCAL_NIX` with `--impure`, so it does not depend on [configs/nix/nix.conf](/Users/takuma.shibuya.001/workspace/sivchari/dotfiles/configs/nix/nix.conf:1) taking effect immediately. If `gh` and `~/.ssh/id_rsa.pub` are present, it adds the SSH key to GitHub only when that key is not already registered.

```nix
{
  username = "your-user";
  hostname = "Your-Mac";
}
```

Pass a host explicitly if needed:

```bash
./bootstrap.sh My-Mac
```

For daily rebuilds, use the wrapper script:

```bash
./rebuild.sh
./rebuild.sh My-Mac
```

## Structure

```
.
├── flake.nix                 # Entry point (single local darwinConfiguration)
├── flake.lock
├── hosts/darwin/             # nix-darwin system config (launchd, pam, etc.)
├── home/                     # home-manager modules
│   ├── default.nix           # xdg.configFile, activation scripts
│   ├── packages.nix          # All packages
│   ├── shell.nix             # Zsh (sheldon integration)
│   ├── git.nix               # Git (SSH signing)
│   └── ssh.nix               # SSH
├── configs/                  # Dotfiles (symlinked via home-manager)
│   ├── nvim/                 # Neovim
│   ├── sketchybar/           # Status bar
│   ├── aerospace/            # Tiling window manager
│   ├── borders/              # Window borders
│   ├── ghostty/              # Terminal
│   ├── sheldon/              # Zsh plugin manager
│   ├── lazygit/              # Git TUI
│   └── git/                  # Git ignore
├── packages/btmon/           # Custom derivation
└── hack/                     # Utility scripts
```

## Daily Usage

```bash
# Apply changes after editing configs
./rebuild.sh

# Update nixpkgs
nix flake update nixpkgs
./rebuild.sh
```

## Key Bindings (AeroSpace)

| Action | Key |
|--------|-----|
| Focus window | `ctrl + hjkl` |
| Move window | `ctrl + shift + hjkl` |
| Resize window | `ctrl + cmd + hjkl` |
| Switch workspace | `ctrl + 1-9` |
| Move to workspace | `ctrl + shift + 1-9` |
| Toggle layout | `ctrl + t/a/f` |
| Reload config | `ctrl + shift + ;` then `esc` |

## Requirements

- macOS (Apple Silicon)
- [Nix](https://nixos.org/download/) is optional for first bootstrapping
