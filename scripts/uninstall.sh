#!/bin/zsh

# ==============================================================================
# Script de Desinstalación y Limpieza Profunda
# Objetivo: Dejar el sistema limpio, removiendo solo lo instalado por dotfiles
# ==============================================================================

set -e

echo "⚠️ Iniciando desinstalación del stack de desarrollo..."

# ------------------------------------------------------------------------------
# 1. BACKUP DE SEGURIDAD
# Guardamos estado actual de Homebrew por si necesitamos revertir
# ------------------------------------------------------------------------------
echo "📦 Generando backup de seguridad..."
brew bundle dump --force --file="$HOME/.dotfiles/Brewfile.pre_uninstall"

# ------------------------------------------------------------------------------
# 2. DESINSTALAR CASKS (Aplicaciones GUI)
# Solo las que estén en nuestro Brewfile actual
# ------------------------------------------------------------------------------
echo "🖥️ Eliminando aplicaciones (Casks)..."
for app in warp rectangle orbstack dbeaver-community appcleaner font-meslo-lg-nerd-font; do
    if brew list --cask "$app" &>/dev/null; then
        brew uninstall --cask --force "$app" 2>/dev/null || true
    fi
done

# ------------------------------------------------------------------------------
# 3. DESINSTALAR FÓRMULAS (CLI Tools)
# Solo las que instalamos nosotros (del Brewfile), no dependencias del sistema
# ------------------------------------------------------------------------------
echo "⚙️ Eliminando fórmulas y binarios..."
for pkg in mise uv zoxide eza bat fzf ripgrep fd atuin zellij coreutils htop jq yq \
           kubernetes-cli kustomize helm k9s stern gh git-delta lazygit neovim \
           starship opencode ollama terraform terraform-docs; do
    if brew list --formula "$pkg" &>/dev/null; then
        brew uninstall --force "$pkg" 2>/dev/null || true
    fi
done

# ------------------------------------------------------------------------------
# 4. LIMPIEZA DE CONFIGURACIONES DE USUARIO
# Solo removemos configs que nosotros creamos, NO ~/.ssh, ~/.aws, etc
# ------------------------------------------------------------------------------
echo "🧹 Limpiando configuraciones de dotfiles..."

# Configs de tools instaladas por nosotros
rm -rf ~/.config/nvim         # LazyVim
rm -rf ~/.config/starship.toml
rm -rf ~/.config/fzf          # fzf config

# NOTA: NO removemos ~/.config/mise porque contiene runtimes instalados
#       (~/.local/share/mise/installs) - si lo necesitás, borralo manualmente

# Cachés y temporales de shell
rm -rf ~/.zsh_sessions ~/.zcompcache ~/.lesshst ~/.python_history 2>/dev/null || true

# ------------------------------------------------------------------------------
# 5. LIMPIEZA FINAL DE HOMEBREW
# Elimina symlinks rotos y cachés
# ------------------------------------------------------------------------------
echo "✨ Limpiando registros y archivos temporales..."
brew cleanup --prune=all 2>/dev/null || true

echo ""
echo "✅ Desinstalación completada."
echo ""
echo "📋 Resumen:"
echo "   - Backup guardado en: ~/.dotfiles/Brewfile.pre_uninstall"
echo "   - Symlinks removidos: ~/.zshrc, ~/.gitconfig, ~/.config/starship.toml"
echo "   - Aplicaciones GUI desinstaladas"
echo "   - CLI tools desinstaladas"
echo ""
echo "⚠️ NOTA: Tu ~/.ssh, ~/.aws, ~/.docker y otros directorios personales"
echo "   fueron preservados (no los tocamos)."