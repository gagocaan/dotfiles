#!/bin/zsh

# ==============================================================================
# Script de Desinstalación y Limpieza Profunda
# Objetivo: Dejar el sistema limpio, removiendo solo lo instalado por dotfiles
#
# Uso:
#   scripts/uninstall.sh             # desinstala de verdad
#   scripts/uninstall.sh --dry-run   # muestra qué haría, sin tocar nada
#
# Single source of truth: install.conf.yaml
# Casks, fórmulas, taps y symlinks se leen dinámicamente desde el YAML usando yq,
# así que no hace falta sincronizar este script cuando cambias el install.
# ==============================================================================

set -e

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG="$DOTFILES_DIR/install.conf.yaml"

DRY_RUN=""
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=1
    echo "🔍 Modo dry-run: no se modificará nada."
fi

# Ejecuta el comando, o solo lo muestra en dry-run
run() {
    if [[ -n "$DRY_RUN" ]]; then
        echo "  [dry-run] $*"
    else
        "$@"
    fi
}

echo "⚠️ Iniciando desinstalación del stack de desarrollo..."

# ------------------------------------------------------------------------------
# 0. PRE-REQUISITOS
# yq es necesario para parsear install.conf.yaml
# ------------------------------------------------------------------------------
if ! command -v yq &>/dev/null; then
    echo "❌ Error: yq no está instalado. Instalalo primero: brew install yq"
    exit 1
fi

if [ ! -f "$CONFIG" ]; then
    echo "❌ Error: no se encontró $CONFIG"
    exit 1
fi

# Leemos todo el YAML ANTES de desinstalar nada: yq es una de las fórmulas
# que se van a remover más abajo.
CASKS=$(yq -r '.[] | select(has("cask")) | .cask[]' "$CONFIG")
# Nerd Font se instala como cask en post-install (fuera de la sección cask:)
CASKS="$CASKS font-meslo-lg-nerd-font"
FORMULAE=$(yq -r '.[] | select(has("brew")) | .brew[]' "$CONFIG")
TAPS=$(yq -r '.[] | select(has("tap")) | .tap[]' "$CONFIG")
LINKS=$(yq -r '.[] | select(has("link")) | .link | keys | .[]' "$CONFIG")
# Herramientas de uv: se consultan ahora porque uv se desinstala más abajo
UV_TOOLS=""
if command -v uv &>/dev/null; then
    UV_TOOLS=$(uv tool list 2>/dev/null | grep -v '^-' | grep -v '^$' || true)
fi

if [[ -z "$CASKS" || -z "$FORMULAE" ]]; then
    echo "❌ Error: no se pudieron leer casks/fórmulas desde $CONFIG"
    exit 1
fi

# ------------------------------------------------------------------------------
# 1. BACKUP DE SEGURIDAD
# Guardamos estado actual de Homebrew por si necesitamos revertir
# ------------------------------------------------------------------------------
echo "📦 Generando backup de seguridad..."
run brew bundle dump --force --file="$DOTFILES_DIR/Brewfile.pre_uninstall"

# ------------------------------------------------------------------------------
# 2. DESINSTALAR CASKS (Aplicaciones GUI)
# Lista leída dinámicamente desde install.conf.yaml.
# Si un cask pide sudo (ej. dotnet-sdk), falla sin terminal: lo avisamos.
# ------------------------------------------------------------------------------
echo "🖥️ Eliminando aplicaciones (Casks)..."
FAILED=()

for app in ${=CASKS}; do
    if brew list --cask "$app" &>/dev/null; then
        echo "  ↳ $app"
        run brew uninstall --cask --force "$app" || FAILED+=("cask $app")
    fi
done

# ------------------------------------------------------------------------------
# 3. DESINSTALAR FÓRMULAS (CLI Tools)
# Lista leída dinámicamente desde install.conf.yaml
# ------------------------------------------------------------------------------
echo "⚙️ Eliminando fórmulas y binarios..."

for pkg in ${=FORMULAE}; do
    if brew list --formula "$pkg" &>/dev/null; then
        echo "  ↳ $pkg"
        run brew uninstall --force "$pkg" || FAILED+=("fórmula $pkg")
    fi
done

# ------------------------------------------------------------------------------
# 4. QUITAR TAPS DE TERCEROS
# Lista leída desde install.conf.yaml. Se hace después de desinstalar casks y
# fórmulas porque brew no permite untap mientras quede algo instalado del tap.
# ------------------------------------------------------------------------------
echo "🚰 Quitando taps..."
for tap in ${=TAPS}; do
    if brew tap | grep -qx "$tap"; then
        echo "  ↳ $tap"
        run brew untap "$tap" || FAILED+=("tap $tap")
    fi
done

# ------------------------------------------------------------------------------
# 5. HERRAMIENTAS DE UV (informativo)
# El YAML no declara herramientas de "uv tool install", así que no las tocamos.
# Pero al desinstalar uv quedan binarios huérfanos en ~/.local/bin: avisamos.
# ------------------------------------------------------------------------------
if [[ -n "$UV_TOOLS" ]]; then
    echo "🧰 Herramientas de uv que NO se tocaron (quedan huérfanas porque se removió uv):"
    echo "$UV_TOOLS" | sed 's/^/     /'
    echo "   Sus binarios en ~/.local/bin pueden borrarse a mano."
fi

# ------------------------------------------------------------------------------
# 6. LIMPIEZA DE CONFIGURACIONES DE USUARIO
# Solo removemos configs que nosotros creamos, NO ~/.ssh, ~/.aws, etc
# ------------------------------------------------------------------------------
echo "🧹 Limpiando configuraciones de dotfiles..."

# Symlinks creados por Dotbot (leídos de la sección link: del YAML).
# Solo se borran si realmente son symlinks: un archivo real nunca se toca.
REMOVED_LINKS=()
while IFS= read -r target; do
    [[ -z "$target" ]] && continue
    # Expandir ~ y $HOME al inicio de la ruta
    path="${target/#\~/$HOME}"
    path="${path/#\$HOME/$HOME}"
    if [[ -L "$path" ]]; then
        echo "  ↳ $path"
        run rm -f "$path"
        REMOVED_LINKS+=("$path")
    fi
done <<< "$LINKS"

# Directorios de config que quedan vacíos tras quitar los symlinks
for dir in ~/.config/ghostty ~/.config/mise; do
    [[ -d "$dir" ]] && run rmdir "$dir" 2>/dev/null || true
done

# Configs de tools instaladas por nosotros
run rm -rf ~/.config/nvim         # LazyVim
run rm -rf ~/.config/fzf

# NOTA: NO removemos ~/.local/share/mise/installs porque contiene los runtimes
#       (Go, Node, Python) bajados por mise. Si querés liberar ese espacio,
#       borralo manualmente con: rm -rf ~/.local/share/mise

# Cachés y temporales de shell
run rm -rf ~/.zsh_sessions ~/.zcompcache ~/.lesshst ~/.python_history

# ------------------------------------------------------------------------------
# 7. LIMPIEZA FINAL DE HOMEBREW
# Elimina symlinks rotos y cachés
# ------------------------------------------------------------------------------
echo "✨ Limpiando registros y archivos temporales..."
run brew cleanup --prune=all || true

echo ""
if [[ -n "$DRY_RUN" ]]; then
    echo "🔍 Dry-run completado. No se modificó nada."
else
    echo "✅ Desinstalación completada."
fi
echo ""
echo "📋 Resumen:"
echo "   - Backup guardado en: $DOTFILES_DIR/Brewfile.pre_uninstall"
if [[ -n "$DRY_RUN" ]]; then
    echo "   - Symlinks que se removerían (${#REMOVED_LINKS[@]}): ${(j:, :)REMOVED_LINKS}"
else
    echo "   - Symlinks removidos (${#REMOVED_LINKS[@]}): ${(j:, :)REMOVED_LINKS}"
fi
echo "   - Aplicaciones GUI, CLI tools y taps leídos desde install.conf.yaml"

if (( ${#FAILED[@]} > 0 )); then
    echo ""
    echo "⚠️ Estos elementos no se pudieron remover (¿piden sudo?). Corrélos a mano en tu terminal:"
    for item in "${FAILED[@]}"; do
        echo "   - $item"
    done
fi

echo ""
echo "⚠️ NOTA: Tu ~/.ssh, ~/.aws, ~/.docker y otros directorios personales"
echo "   fueron preservados (no los tocamos)."
