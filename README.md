# Dotfiles
Personal development environment for macOS (Mac mini M4). Automated with [Dotbot](https://github.com/anishathalye/dotbot).

## What's Installed

| Category | Tools |
| :--- | :--- |
| **Shell** | ZSH + zsh-autosuggestions + zsh-syntax-highlighting |
| **Prompt** | Starship (Git, K8s, Terraform, Python, Node, Go, Rust) |
| **Navigation** | zoxide (`z`), fzf |
| **History** | Atuin |
| **Terminal** | Warp + Zellij |
| **Editor** | LazyVim |
| **CLI Modern** | eza, bat, ripgrep, fd |
| **Runtimes** | mise, uv |
| **DevOps** | kubectl, k9s, helm, kustomize, stern |
| **IaC** | Terraform |
| **AI** | Ollama |

## Project Structure

```
.dotfiles/
├── Brewfile
├── install.conf.yaml
├── install
├── zshrc
├── gitconfig
├── starship.toml
├── mise/config.toml     # Runtime versions (Go, Python, Node)
├── settings.json        # VSCode settings
└── scripts/uninstall.sh
```

## Installation
Follow these steps to set up your environment:

```bash
git clone https://github.com/gagocaan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install
```

## Post-Installation
1. Restart terminal (Warp)
2. Run `nvim` → LazyVim installs plugins

## Common Commands

| Command | Description |
| :--- | :--- |
| `z <dir>` | Jump to directory (zoxide) |
| `ll` | List files with git status (eza) |
| `cat <file>` | Syntax-highlighted view (bat) |
| `k` | kubectl |
| `k9s` | K8s UI (read-only mode) |
| `git ifi` | Init git-flow |
| `git gone` | Delete merged branches |

## Maintenance

```bash
cd ~/.dotfiles && ./install    # Reinstall/Update
~/.dotfiles/scripts/uninstall.sh  # Clean uninstall
```

---

Maintained by **gagocaan** (2026)