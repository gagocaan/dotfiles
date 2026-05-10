# AGENTS.md - Dotfiles Repository

Dotfiles repository using [Dotbot](https://github.com/anishathalye/dotbot) to manage macOS configuration.

## Quick Commands

```bash
# Install/reinstall all dotfiles
cd ~/.dotfiles && ./install

# Update Brewfile from current system
brew bundle dump --force --file=~/.dotfiles/Brewfile

# Clean uninstall
~/.dotfiles/scripts/uninstall.sh
```

## Key Files

| File | Purpose |
|------|---------|
| `install.conf.yaml` | Main Dotbot config (links, taps, brew, casks, shell commands) |
| `zshrc` | ZSH config, aliases, lazy-loaded tool init |
| `gitconfig` | Git aliases, delta pager, git-flow config |
| `starship.toml` | Prompt config (K8s, Terraform, Python, Node, Go, Rust) |
| `settings.json` | IDE settings (fonts, terminal, theme) |
| `Brewfile` | Pinned Homebrew packages |

## Conventions

- **`./install` runs Dotbot**: Cleans symlinks → creates dirs → links files → installs brew/casks → runs post-install commands
- **Symlinks created**: `~/.config/starship.toml`, `~/.gitconfig`, `~/.zshrc`
- **mise for runtimes**: Languages (Node, Go, Python, Terraform) managed by mise, not Homebrew
- **k9s readonly**: `k9s` runs in read-only mode by default
- **eza/bat > ls/cat**: Modern replacements in zshrc
- **SSH keys**: Stored in `~/.ssh/`, copied from old Mac

## Git Aliases

```bash
git ifi    # Initialize git-flow with defaults
git gone   # Delete local branches already merged on remote
git undo   # Revert last commit, keep changes
git lg     # Pretty log graph
git summary # Show commit counts by author
gclean     # Alias for git gone
```

## Common Tasks

| Task | Command |
|------|---------|
| Add new package | Add to `install.conf.yaml` under `- brew:` or `- cask:`, then run `./install` |
| Update Brewfile | `brew bundle dump --force --file=~/.dotfiles/Brewfile` |
| Reinstall | `./install` |
| Cleanup | Last step of `./install` runs `brew bundle cleanup` automatically |

## Submodules

This repo includes git submodules:
- `dotbot/` - Installation tool
- `dotbot-brew/` - Homebrew plugin for Dotbot
- `dotbot/lib/pyyaml/` - YAML library

The `./install` script auto-initializes submodules.

## Notes for AI Agents

- **Do not modify system files** outside of `~/.dotfiles/`
- **Do not commit secrets** (SSH keys, credentials, tokens)
- **Always backup** before running uninstall script
- **Verify brew packages** match between `Brewfile` and `install.conf.yaml`