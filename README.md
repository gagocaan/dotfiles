# dotfiles

## 💡 Basic Info

**``$HOME``** sweet home. A modern, high-performance development environment for macOS (2026 Edition).

## 📖 Description

A self-contained, automated setup to rapidly deploy a cutting-edge development environment featuring the latest Rust-based CLI tools, a polyglot version manager, and a fully configured Neovim IDE.

## 🎯 Summary

* **Shell**: ZSH with [Starship](https://starship.rs/) prompt, [zoxide](https://github.com/ajeetdsouza/zoxide) navigation, and [Atuin](https://github.com/atuinsh/atuin) history.
* **Core Utils**: Modern replacements for standard tools (`eza` > ls, `bat` > cat, `ripgrep` > grep, `fd` > find).
* **Package Management**:
    * **[mise](https://mise.jdx.dev/)**: Single source of truth for runtime versions (Node, Go, Terraform, Python). Replaces `nvm`, `pyenv`, `go` brew formulas.
    * **[uv](https://github.com/astral-sh/uv)**: Blazing fast Python package and project manager. Replaces `pip`, `pip-tools`, `pipx`, `virtualenv`.
* **Editor**: [LazyVim](https://www.lazyvim.org/) (Neovim) pre-configured for Python, Go, and Web Development.
* **Terminal**: [Ghostty](https://ghostty.org/) (GPU-accelerated) + [Zellij](https://zellij.dev/) (Multiplexer).
* **DevOps**: Docker (via OrbStack), K9s, Flux, Helm.

### ✨ Git Supercharged
The `.gitconfig` comes with modern defaults and productivity aliases:
* **Workflow**: Auto-setup remote tracking on push, rebase by default on pull, and `zdiff3` conflict style.
* **Visuals**: Uses `delta` for syntax-highlighted diffs with navigation (`n`/`N`).
* **Aliases**:
    * `git lg`: Beautiful graph log.
    * `git st`: Short status.
    * `git undo`: Soft reset last commit.
    * `git amend`: Quick amend.

## 🧬 Project structure

```console
.
├── README.md
├── gitconfig
├── install
├── install.conf.yaml       # Main configuration file (packages & links)
├── scripts
│   └── uninstall.sh
├── starship.toml           # Prompt configuration
└── zshrc                   # ZSH configuration
```

## ⚙️ Setup

Make sure your Operating System has the following packages installed.

1. git
2. curl

> **Note**: This setup relies on `system python` solely for bootstrapping the installer. All development versions of Python are managed by `mise` or `uv`.

## 🍴 Usage

Clone the repository to your `$HOME` directory as `.dotfiles` and then run the installer.

```bash
# Clone
cd ~
git clone https://github.com/gagocaan/dotfiles.git ~/.dotfiles

# Install
~/.dotfiles/install
```

### Post-Install
After installation:
1. Restart your terminal (or run `exec zsh`).
2. **Install Languages**: Since we cleaned up Brew formulas, install your preferred versions globally via `mise`:
   ```bash
   mise use --global python@latest node@lts go@latest terraform@latest
   ```
3. Start **Neovim** (`nvim`) to let LazyVim install its plugins.

## Uninstall and CleanUp

```bash
~/.dotfiles/scripts/uninstall.sh
```

**Reboot your system for avoiding conflicts.**