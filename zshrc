# ==============================================================================
# ZSH CONFIGURATION 2026 - macOS Development Environment
# User: Carlos Andres Garzon Gonzalez
# ==============================================================================

# ==============================================================================
# 1. ENVIRONMENT SETUP
# ==============================================================================

# PATH: Priorizar Homebrew y binarios locales sobre system defaults
# ~/.local/bin -> Homebrew (Apple Silicon) -> Homebrew (Intel) -> System bins
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Editor: Neovim como editor por defecto (no vim nativo)
export EDITOR="nvim"
export VISUAL="nvim"

# Locale: UTF-8 para evitar encoding issues
export LANG="en_US.UTF-8"

# XDG Base Directory: стандартные rutas para configs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ==============================================================================
# 2. TOOL INITIALIZATIONS (Lazy Load)
# Solo se cargan si la herramienta está instalada - evita errores en sistemas limpios
# ==============================================================================

# --- mise: Polyglot Runtime Manager ---
# Gestiona versiones de Node, Go, Python, Ruby, Rust, etc.
# "mise activate" agrega los binarios al PATH automáticamente
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# --- zoxide: Smarter "cd" ---
# Aprende tus directorios más visitados y permite navegar con "z <fuzzy>"
# Alias 'z' para no romper scripts que usen 'cd' nativo
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# --- atuin: Magical Shell History ---
# Historial con sync, búsqueda avanzada y share entre machines.
# --disable-up-arrow: Warp maneja arrows nativamente, evitamos conflicto
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# --- starship: Cross-shell Prompt ---
# Muestra Git status, K8s context, runtime versions, etc.
# Desactivamos en Warp (usa su prompt nativo) pero activamos en Zellij/SSH
if [[ $TERM_PROGRAM != "WarpTerminal" ]] && command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# --- fzf: Fuzzy Finder ---
# Ctrl+T: buscar archivos, Ctrl+R: buscar en historial, Alt+C: cd interactivo
if command -v fzf &> /dev/null; then
  # Configuración de búsqueda de archivos
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_R_OPTS='--preview="echo {}" --preview-window=up:3'

  # Cargar key bindings de fzf (Ctrl+T, Ctrl+R, etc)
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# ==============================================================================
# 3. MODERN ALIASES (CLI Replacements)
# Reemplazos modernos de herramientas Unix classics
# ==============================================================================

# --- eza: Modern "ls" ---
# Iconos, git status, colors - reemplazo de "ls" con superpoderes
if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -lh --icons --git --group-directories-first"
  alias la="eza -a --icons --group-directories-first"
  alias lt="eza --tree --icons --level=2"
  alias l.="eza -d .* --icons"  # Solo archivos ocultos
fi

# --- bat: Modern "cat" ---
# Syntax highlighting, line numbers, git diffs
if command -v bat &> /dev/null; then
  alias cat="bat --paging=never"
  # "help" como wrapper para mostrar help con syntax highlighting
  alias help='f() { "$@" --help 2>&1 | bat --plain --language=help }; f'
fi

# --- Common Aliases ---
alias vi="nvim"
alias vim="nvim"
alias v="nvim"

# Git short commands
alias g="git"

# Kubernetes short commands
alias k="kubectl"

# k9s en modo readonly por seguridad (evita accidentes en producción)
alias k9s="k9s --readonly"

# Limpiar ramas git ya mergeadas en remote
alias gclean="git gone"

# ==============================================================================
# 4. CUSTOM FUNCTIONS
# ==============================================================================

# extract: Extraer cualquier archivo comprimido
# Uso: extract archivo.tar.gz
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2) tar xf $1 ;;
      *.tar.gz)  tar xf $1 ;;
      *.bz2)     bunzip2 $1 ;;
      *.rar)     unrar x $1 ;;
      *.gz)      gunzip $1 ;;
      *.tar)     tar xf $1 ;;
      *.tbz2)    tar xf $1 ;;
      *.tgz)     tar xf $1 ;;
      *.zip)     unzip $1 ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1 ;;
      *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# mkcd: Crear directorio y navegar a él
# Uso: mkcd nueva_carpeta
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ==============================================================================
# 5. COMPLETIONS & PERFORMANCE
# ==============================================================================

# Habilitar autocomplete para brew
if command -v brew &> /dev/null; then
  autoload -Uz compinit
  compinit
fi

# Historial mejor配置的
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# ==============================================================================
# 6. ZSH PLUGINS (Requieren instalación adicional)
# ==============================================================================

# Descomenta si instalaste estos via brew:
# ZSH Plugins - Syntax highlighting y autosuggestions
# Estos se activan automáticamente después de brew install
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/cagarzon/.lmstudio/bin"
# End of LM Studio CLI section

