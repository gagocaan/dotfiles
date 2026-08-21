#!/bin/zsh

# ==============================================================================
# Deep Uninstall & Cleanup Script
# Goal: Leave the system clean, removing only what was installed by dotfiles
# ==============================================================================

set -e

echo "⚠️ Starting development stack uninstall..."

# ------------------------------------------------------------------------------
# 1. SAFETY BACKUP
# Save current Homebrew state in case we need to revert
# ------------------------------------------------------------------------------
echo "📦 Generating safety backup..."
brew bundle dump --force --file="$HOME/.dotfiles/Brewfile.pre_uninstall"

# ------------------------------------------------------------------------------
# 2. UNINSTALL CASKS (GUI Applications)
# Only those listed in our current Brewfile
# ------------------------------------------------------------------------------
echo "🖥️ Removing applications (Casks)..."
for app in ghostty rectangle orbstack dbeaver-community appcleaner font-meslo-lg-nerd-font; do
    if brew list --cask "$app" &>/dev/null; then
        brew uninstall --cask --force "$app" 2>/dev/null || true
    fi
done

# ------------------------------------------------------------------------------
# 3. UNINSTALL FORMULAE (CLI Tools)
# Only those we installed (from Brewfile), not system dependencies
# ------------------------------------------------------------------------------
echo "⚙️ Removing formulae and binaries..."
for pkg in mise uv zoxide eza bat fzf ripgrep fd atuin zellij coreutils htop jq yq \
           kubernetes-cli kustomize helm k9s stern gh git-delta lazygit neovim \
           starship opencode ollama terraform terraform-docs; do
    if brew list --formula "$pkg" &>/dev/null; then
        brew uninstall --force "$pkg" 2>/dev/null || true
    fi
done

# ------------------------------------------------------------------------------
# 4. USER CONFIGURATION CLEANUP
# Only remove configs we created — NOT ~/.ssh, ~/.aws, etc.
# ------------------------------------------------------------------------------
echo "🧹 Cleaning dotfile configurations..."

# Configs for tools installed by us
rm -rf ~/.config/nvim          # LazyVim
rm -rf ~/.config/starship.toml
rm -rf ~/.config/fzf           # fzf config

# NOTE: We do NOT remove ~/.config/mise because it contains installed runtimes
#       (~/.local/share/mise/installs) — if needed, delete it manually

# Shell caches and temp files
rm -rf ~/.zsh_sessions ~/.zcompcache ~/.lesshst ~/.python_history 2>/dev/null || true

# ------------------------------------------------------------------------------
# 5. FINAL HOMEBREW CLEANUP
# Remove broken symlinks and caches
# ------------------------------------------------------------------------------
echo "✨ Cleaning up records and temporary files..."
brew cleanup --prune=all 2>/dev/null || true

echo ""
echo "✅ Uninstall complete."
echo ""
echo "📋 Summary:"
echo "   - Backup saved to: ~/.dotfiles/Brewfile.pre_uninstall"
echo "   - Symlinks removed: ~/.zshrc, ~/.gitconfig, ~/.config/starship.toml"
echo "   - GUI applications uninstalled"
echo "   - CLI tools uninstalled"
echo ""
echo "⚠️ NOTE: Your ~/.ssh, ~/.aws, ~/.docker and other personal directories"
echo "   were preserved (left untouched)."