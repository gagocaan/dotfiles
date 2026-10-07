# Dotfiles
Personal development environment for macOS (Mac mini M4). Automated with [Dotbot](https://github.com/anishathalye/dotbot).

## What's Installed

| Category | Tools |
| :--- | :--- |
| **Shell** | ZSH + zsh-autosuggestions + zsh-syntax-highlighting |
| **Prompt** | Starship (Git, K8s, Terraform, Python, Node, Go, Rust) |
| **Navigation** | zoxide (`z`), fzf |
| **History** | Atuin |
| **Terminal** | Ghostty + Zellij |
| **Editor** | LazyVim, VS Code |
| **CLI Modern** | eza, bat, ripgrep, fd |
| **Runtimes** | mise (Go, Node, Python), uv |
| **DevOps** | kubectl, k9s, helm, kustomize, stern, OrbStack |
| **IaC** | Terraform |
| **AI** | OpenCode (CLI + desktop), LM Studio |

The full, authoritative list lives in [`install.conf.yaml`](install.conf.yaml).

## Project Structure

```
.dotfiles/
├── install.conf.yaml    # Single source of truth: links, taps, brew, casks, post-install
├── install              # Entry point (initializes submodules, runs Dotbot)
├── zshrc
├── gitconfig
├── starship.toml
├── ghostty/config       # Linked to ~/.config/ghostty/config.ghostty
├── mise/config.toml     # Runtime versions (Go, Python, Node)
├── settings.json        # VS Code settings
├── scripts/uninstall.sh
├── AGENTS.md            # Guidance for AI agents
├── dotbot/              # Submodule
└── dotbot-brew/         # Submodule
```

`Brewfile`, `Brewfile.bak` and `Brewfile.pre_uninstall` may appear locally. They are gitignored backups and are **not** used to decide what gets installed.

## Installation
Follow these steps to set up your environment:

```bash
git clone --recursive https://github.com/gagocaan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install
```

> ⚠️ **`./install` is destructive for Homebrew.** The last step removes every formula, cask and tap that is **not** declared in `install.conf.yaml`. To preview what would be removed, run the dry-run command from [`AGENTS.md`](AGENTS.md).

## Post-Installation
1. Restart terminal (Ghostty)
2. Run `nvim` → LazyVim installs plugins

## Common Commands

| Command | Description |
| :--- | :--- |
| `z <dir>` | Jump to directory (zoxide) |
| `ll` | List files with git status (eza) |
| `cat <file>` | Syntax-highlighted view (bat) |
| `k` | kubectl |
| `k9s` | K8s UI (read-only mode) |
| `git gone` | Force-delete local branches whose remote branch was deleted |

## Maintenance

```bash
cd ~/.dotfiles && ./install       # Reinstall/Update (also syncs Homebrew, see warning above)
~/.dotfiles/scripts/uninstall.sh --dry-run  # Preview the uninstall
~/.dotfiles/scripts/uninstall.sh            # Clean uninstall (requires yq)
```

To add or remove a package, edit `install.conf.yaml` and run `./install`.

---

Maintained by **gagocaan** (2026)
