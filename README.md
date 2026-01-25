# Dotfiles

## 💡 Basic Info

`$HOME` sweet home. A modern, high-performance development environment for macOS (**2026 Edition**).

## 📖 Description

A self-contained, automated setup to rapidly deploy a cutting-edge development environment. This stack prioritizes Rust-based CLI tools, a unified polyglot version manager, and a cloud-native workflow optimized for DevOps and Cloud Cost Analysis.

## 🎯 Summary

- **Shell & Prompt**: [ZSH](https://www.zsh.org/) with [Starship](https://starship.rs/) (K8s & Terraform aware), [zoxide](https://github.com/ajeetdsouza/zoxide) for smart navigation, and [Atuin](https://atuin.sh/) for synced, searchable history.
- **Terminal**: [Warp](https://www.warp.dev/) (AI-integrated) + [Zellij](https://zellij.dev/) for high-productivity multiplexing.
- **Core Utils (The Rust Stack)**: Modern replacements for legacy tools:
  - `eza` > `ls`
  - `bat` > `cat`
  - `ripgrep` > `grep`
  - `fd` > `find`
  - `bottom` > `top`
- **Package Management**:
  - **[mise](https://mise.jdx.dev/)**: Single source of truth for runtime versions (Node, Go, Terraform, Python). Eliminates version manager sprawl.
  - **[uv](https://docs.astral.sh/uv/)**: Blazing fast Python project manager. Replaces pip, pipx, and virtualenv.
- **Editor**: [LazyVim](https://www.lazyvim.org/) (Neovim) optimized for performance and modern LSP features.
- **DevOps & Cloud**: OrbStack (Docker/K8s), K9s, FluxCD, Helm, and Terraform-docs.

## ✨ Git & Workflow

The `.gitconfig` is tuned for professional collaboration:

- **git-flow**: Integrated and pre-configured for `main`/`develop` branches.
- **Visuals**: [Delta](https://github.com/dandavison/delta) for side-by-side, syntax-highlighted diffs.
- **Productivity Aliases**:
  - `git ifi`: Initialize git-flow instantly with defaults.
  - `git gone`: Prune local branches that no longer exist on remote.
  - `git lg`: Professional graph visualization of the commit history.

## 🧬 Project Structure

```text
.
├── README.md
├── Brewfile                # Snapshot of all Homebrew packages
├── gitconfig               # Git aliases, delta, and git-flow config
├── install                 # Dotbot bootstrap script
├── install.conf.yaml       # Main orchestrator (links, taps, brew, shell)
├── starship.toml           # Prompt configuration
└── zshrc                   # ZSH configuration
```

## ⚙️ Setup

Ensure your system has **Homebrew** installed, then:

```bash
# Verify requirements
brew --version
git --version
curl --version
```

> [!NOTE]
> This setup relies on `mise` to manage development runtimes. It automatically cleans up legacy Homebrew formulas to avoid `$PATH` conflicts.

## 🍴 Usage

Clone the repository as `.dotfiles` in your `$HOME` and run the installer.

```bash
# Clone
git clone https://github.com/gagocaan/dotfiles.git ~/.dotfiles

# Install (Automated via Dotbot)
cd ~/.dotfiles
./install
```

### Post-Install

1. **Restart your terminal** (Warp).
2. **Install Runtimes**: Run `mise install -y` to deploy all languages defined in `install.conf.yaml`.
3. **Set Global Versions**:

   ```bash
   mise use --global python@3.12 node@latest terraform@latest
   ```

4. **Open Neovim** (`nvim`) to trigger the LazyVim plugin installation.

## 🚀 Cheat Sheet (Quick Start)

### 📂 Navigation & Files

| Command | Action |
| :--- | :--- |
| `z <path>` | Jump to directory (zoxide) |
| `ls` / `ll` | List files with icons and git status (eza) |
| `lt` | View directory tree (eza) |
| `cat <file>` | Syntax-highlighted view (bat) |

### ☸️ Kubernetes & Cloud

| Command | Action |
| :--- | :--- |
| `k` | Alias for `kubectl` |
| `k9s` | Launch K9s (Read-only by default for safety) |
| `stern <pattern>` | Tail logs from multiple pods |
| `starship explain` | See what each prompt symbol means |

### 🐍 Python & Runtimes (mise/uv)

| Command | Action |
| :--- | :--- |
| `uv sync` | Fast install of project dependencies |
| `uv run <script>` | Run script in isolated environment |
| `mise ls` | List all installed runtimes and versions |
| `mise upgrade` | Upgrade managed languages (Node, Go, etc.) |

### 󰊢 Git & Flow

| Command | Action |
| :--- | :--- |
| `git ifi` | Initialize Git-Flow with standard prefixes |
| `git gone` | Delete local branches already merged/deleted in remote |
| `git undo` | Revert the last commit keeping changes |
| `gclean` | Run `git gone` (custom alias) |

### 🛠️ Maintenance

| Command | Action |
| :--- | :--- |
| `./install` | Re-sync everything and clean up unused Brew formulas |
| `check-stack` | Run health checks for Brew, Mise, and Starship |

## 🧹 Uninstall and CleanUp

```bash
~/.dotfiles/scripts/uninstall.sh
```

Reboot your system to ensure all session variables and path changes are cleared.

---
Maintained by **gagocaan** (2026)
