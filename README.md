# dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/sivchari/dotfiles/master/install.sh | bash
```

After installation:
```bash
exec zsh
```

## What's Installed

### Via chezmoi external (automatic download)

| Tool | Description |
|------|-------------|
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | Tiling window manager |
| [JankyBorders](https://github.com/FelixKratz/JankyBorders) | Window borders |
| [SketchyBar](https://github.com/FelixKratz/SketchyBar) | Custom status bar |
| [Neovim](https://github.com/neovim/neovim) | Nightly build |
| [OpenSSL](https://github.com/openssl/openssl) | Built from source |
| [plan9port](https://github.com/9fans/plan9port) | Plan 9 userspace tools |
| [Claude Desktop](https://claude.ai/download) | AI assistant |
| [Claude Code](https://code.claude.com) | AI coding CLI |

### Via install.sh (bootstrap)

- chezmoi (dotfiles manager)
- aqua (CLI version manager)
- Rust + sheldon (zsh plugin manager)
- GPG key setup

### CLI Tools (via aqua)

- kubectl, kubectx, kustomize, kind, krew
- gh (GitHub CLI)
- fzf, ripgrep, jnv, yq
- lazygit, difftastic
- terraform, helm
- buf, protoc
- and more...

### Zsh Plugins (via sheldon)

- zsh-autosuggestions
- zsh-syntax-highlighting
- carapace (completion)

## File Structure

```
~/.local/share/chezmoi/
├── .chezmoiexternal.toml     # External resources (downloads)
├── .chezmoiscripts/          # Post-apply scripts
│   ├── run_after_01-install-aerospace.sh
│   ├── run_after_02-build-borders.sh
│   ├── run_after_03-build-sketchybar.sh
│   ├── run_after_04-setup-nvim.sh
│   ├── run_after_05-build-openssl.sh
│   ├── run_after_06-build-plan9port.sh
│   ├── run_after_07-install-claude.sh
│   ├── run_after_08-install-claude-code.sh
│   └── run_after_99-set-permissions.sh
├── dot_config/               # ~/.config/
│   ├── aerospace/            # Window manager config
│   ├── borders/              # Window borders config
│   ├── sketchybar/           # Status bar config
│   ├── aqua/                 # CLI tools
│   ├── nvim/                 # Neovim config
│   └── sheldon/              # Zsh plugins
└── dot_zshrc                 # ~/.zshrc
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

## Daily Usage

```bash
# Apply changes
chezmoi apply

# Edit config
chezmoi edit ~/.zshrc

# Push to GitHub
chezmoi cd
git add -A && git commit -m "update" && git push

# Pull and apply on another machine
chezmoi update
```

## GPG Setup

The install script automatically:
1. Creates a GPG key if none exists
2. Configures git to use the key
3. Outputs the public key for GitHub registration

After installation, copy the displayed public key and register it at:
https://github.com/settings/gpg/new

## Requirements

- macOS (Apple Silicon)
- Git
- Xcode Command Line Tools (`xcode-select --install`)
- GPG Suite (https://gpgtools.org/)
