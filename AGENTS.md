# AGENTS.md - Dotfiles Repository

Dotfiles repository using [Dotbot](https://github.com/anishathalye/dotbot) to manage macOS configuration.

## Quick Commands

```bash
# Install/reinstall all dotfiles
cd ~/.dotfiles && ./install

# Preview what the Homebrew sync would remove (dry run, nothing is removed)
yq -r '.[] | select(has("shell")) | .shell[] | select(.description // "" | test("Homebrew sync")) | .command' ~/.dotfiles/install.conf.yaml | sed 's/ --force//' | zsh

# Clean uninstall (reads packages, taps and symlinks from install.conf.yaml, requires yq)
~/.dotfiles/scripts/uninstall.sh --dry-run   # preview only, changes nothing
~/.dotfiles/scripts/uninstall.sh
```

## Key Files

| File | Purpose |
|------|---------|
| `install.conf.yaml` | **Single source of truth.** Dotbot config: links, taps, tap trust, brew, casks, shell commands |
| `zshrc` | ZSH config, aliases, lazy-loaded tool init |
| `gitconfig` | Git aliases, delta pager |
| `starship.toml` | Prompt config (K8s, Terraform, Python, Node, Go, Rust) |
| `settings.json` | VS Code settings (fonts, terminal, theme) |
| `ghostty/config` | Ghostty terminal config |
| `mise/config.toml` | Runtime versions (Go, Python, Node) |
| `scripts/uninstall.sh` | Deep uninstall; reads casks, formulae, taps and symlinks from `install.conf.yaml` with `yq`. Supports `--dry-run` |
| `Brewfile`, `Brewfile.bak`, `Brewfile.pre_uninstall` | **Gitignored, not a source of truth.** Local backups/dumps only (`Brewfile.bak` is refreshed on every `./install`, `Brewfile.pre_uninstall` by the uninstall script). Nothing should depend on them |

## Conventions

- **`./install` runs Dotbot**: Backs up brew → cleans symlinks → creates dirs → links files → taps → trusts taps → installs brew/casks → runs post-install commands → Homebrew sync (removes unlisted packages)
- **Symlinks created** (`link` defaults: `relink: true`, `create: true`, so missing parent dirs are created):
  - `~/.config/starship.toml`
  - `~/.gitconfig`
  - `~/.zshrc`
  - `~/Library/Application Support/Code/User/settings.json`
  - `~/.config/mise/config.toml`
  - `~/.config/ghostty/config.ghostty` → `ghostty/config`
- **`install.conf.yaml` is the only place to declare packages.** Anything installed but not listed there is removed by the last step of `./install`
- **Homebrew sync**: the last step builds a temporary Brewfile from `install.conf.yaml` (taps, brew, cask, plus `font-meslo-lg-nerd-font`, which is installed in post-install) and runs `brew bundle cleanup --force` against it. It aborts before removing anything if `yq` is missing or the generated Brewfile has no formulae/casks. Taps are emitted with `trusted: true` because `cleanup --force` resets Homebrew's trust store to the Brewfile values
- **Third-party taps**: `hashicorp/tap`, `anomalyco/tap`, `frankea/whisky`. Recent Homebrew refuses to load non-official taps until trusted, so a `brew trust --tap` step runs after `tap:`. Its tap list is hardcoded (it runs before `yq` is installed), so **keep it in sync with the `tap:` section** (the Homebrew sync derives its own list from `tap:` automatically)
- **opencode**: installed as `anomalyco/tap/opencode-v2`, not the core `opencode` formula (they conflict on the `opencode` binary)
- **mise for runtimes**: Go, Node and Python are managed by mise, not Homebrew. Do not add `node`/`go`/`python` formulae to brew. `python@3.14` is installed by brew only as a dependency of `gcloud-cli` and is intentionally not declared. Terraform is declared as `hashicorp/tap/terraform`
- **Shell steps print their output** (`defaults.shell` has `stdout`/`stderr` enabled), so the Homebrew sync shows what it removes
- **No git-flow**: the `git ifi` alias and the `[gitflow]` config were removed because the `git-flow` formula is deprecated upstream. Do not re-add them without a replacement
- **uninstall.sh**: everything (casks, formulae, taps, symlinks) is derived from `install.conf.yaml`, so it needs no manual sync. It only deletes symlinks, never real files; it does not touch `uv tool` installs (it lists them instead); casks that need `sudo` are reported at the end so you can remove them by hand
- **extract()** in `zshrc` uses macOS `tar` (bsdtar) for `.rar` and `.7z`; no extra packages are needed
- **k9s readonly**: `k9s` runs in read-only mode by default
- **eza/bat > ls/cat**: Modern replacements in zshrc
- **SSH keys**: Stored in `~/.ssh/`, copied from old Mac

## Git Aliases

```bash
git gone   # Force-delete local branches whose remote branch was deleted
git undo   # Revert last commit, keep changes
git lg     # Pretty log graph
git summary # Show commit counts by author
gclean     # Alias for git gone
```

## Common Tasks

| Task | Command |
|------|---------|
| Add a formula | Add to `install.conf.yaml` under `- brew:`, then run `./install` |
| Add a cask | Add to `install.conf.yaml` under `- cask:`, then run `./install` |
| Add a third-party tap | Add to `- tap:` **and** to the `brew trust --tap` command in the "TRUST TAPS" step |
| Remove a package | Delete it from `install.conf.yaml`; the Homebrew sync uninstalls it on the next `./install` |
| Check drift vs. the repo | Run the dry-run command from Quick Commands |
| Reinstall | `./install` |

## Submodules

This repo includes git submodules:
- `dotbot/` - Installation tool
- `dotbot-brew/` - Homebrew plugin for Dotbot
- `dotbot/lib/pyyaml/` - YAML library

The `./install` script auto-initializes all submodules (`git submodule update --init --recursive`). When cloning, use `git clone --recursive`.

## Notes for AI Agents

- **Do not modify system files** outside of `~/.dotfiles/`
- **Do not commit secrets** (SSH keys, credentials, tokens)
- **Always backup** before running uninstall script
- **Do not run `./install` or `brew bundle cleanup --force` without confirming first**: the Homebrew sync uninstalls every package not declared in `install.conf.yaml`. Preview it with the dry-run command first
- **Keep `install.conf.yaml` as the single source of truth**: never use `Brewfile` to decide what should be installed
- **Files edited by hand** (e.g. `ghostty/config`, `zshrc`, `starship.toml`, `settings.json`, `mise/config.toml`) may have staged changes; do not modify them unless asked
- **Casks that need `sudo`** (e.g. `dotnet-sdk`) cannot be uninstalled from the agent shell; ask the user to run the command in their own terminal
