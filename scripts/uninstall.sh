#!/bin/zsh

# --- Script de Desinstalación y Limpieza Profunda ---
# Objetivo: Dejar el sistema limpio respetando los dotfiles.

set -e

echo "⚠️ Iniciando desinstalación completa del stack..."

# 1. Backup de seguridad antes de destruir
# Esto te permite volver a este estado exacto con 'brew bundle'
echo "📦 Generando backup de seguridad en ~/.dotfiles/Brewfile.pre_uninstall"
brew bundle dump --force --file="$HOME/.dotfiles/Brewfile.pre_uninstall"

# 2. Desinstalar Casks (Aplicaciones con GUI)
echo "🖥️ Eliminando aplicaciones (Casks)..."
brew list --cask | xargs -I{} brew uninstall --cask --force {}

# 3. Desinstalar Fórmulas (Binarios)
echo "⚙️ Eliminando fórmulas y binarios..."
brew uninstall --force $(brew list --formula)

# 4. Limpieza de Taps (Repositorios de terceros)
echo "🚰 Eliminando taps..."
brew untap $(brew tap)

# 5. Mantenimiento final de Homebrew
echo "🧹 Limpiando registros y archivos temporales de Homebrew..."
brew cleanup --prune=all --scrub

# 6. LIMPIEZA DE DIRECTORIO DE USUARIO (El stack 2026)
# Solo borramos configuraciones que sabemos que Dotbot puede recrear.
echo "📂 Limpiando configuraciones de usuario (opcional)..."
rm -rf ~/.config/nvim ~/.config/starship.toml ~/.config/mise ~/.config/atuin

# 7. Limpieza de cachés de sistema que suelen ensuciar
echo "✨ Eliminando cachés de sesión y temporales..."
rm -rf ~/.zsh_sessions ~/.zcompcache ~/.lesshst ~/.python_history

echo "✅ Stack desinstalado. Tu sistema está limpio."
