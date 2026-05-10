# AGENTS.md - Dotfiles Repository

This is a **dotfiles** repository using [Dotbot](https://github.com/anishathalye/dotbot) to manage configuration on macOS.

## Quick Commands

```bash
# Install/reinstall all dotfiles
cd ~/.dotfiles && ./install

# Check health of dev stack
check-stack

# Sync Homebrew packages (updates Brewfile)
brew bundle dump --force --file=~/.dotfiles/Brewfile
```

## Key Files

| File | Purpose |
|------|---------|
| `install.conf.yaml` | Main Dotbot config (links, taps, brew, shell commands) |
| `zshrc` | ZSH configuration, aliases, lazy-loaded tool init |
| `gitconfig` | Git aliases, delta pager, git-flow config |
| `starship.toml` | Prompt configuration |
| `Brewfile` | Pinned Homebrew packages (generated) |

## Important Conventions

- **`./install` runs Dotbot**: It cleans home, creates symlinks, installs Homebrew packages, and runs post-install shell commands
- **Symlinks created**: `~/.config/starship.toml`, `~/.gitconfig`, `~/.zshrc`
- **mise for runtimes**: Languages (Node, Go, Python, Terraform) are managed by `mise`, not Homebrew
- **k9s default**: `k9s` runs in read-only mode by default (`alias k9s="k9s --readonly"`)
- **eza/bat over ls/cat**: Modern replacements configured in zshrc

## Non-Obvious Git Aliases

```bash
git ifi    # Initialize git-flow with defaults
git gone   # Delete local branches already merged on remote
git undo   # Revert last commit, keep changes
```

## Common Tasks

- Reinstall after system change: `./install`
- Add new Homebrew package: Add to `install.conf.yaml` under `- brew:` or `- cask:`, then run `./install`
- Update Brewfile: `brew bundle dump --force --file=~/.dotfiles/Brewfile`
- Cleanup removed packages: `./install` runs cleanup automatically (last step)

## Submodules

This repo includes git submodules:
- `dotbot/` - Installation tool
- `dotbot-brew/` - Homebrew plugin for Dotbot
- `dotbot/lib/pyyaml/` - YAML library

Run `git submodule update --init --recursive` after cloning to get all submodules.