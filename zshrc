# --- Modern ZSH Configuration (2026) ---

# 1. PATH Updates (Priorizar binarios locales y de Homebrew)
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# 2. Editor & Environment
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"

# --- Tool Initializations (Lazy Load / Warp Optimized) ---

# mise: Polyglot tool manager
# Lo activamos primero porque gestiona los binarios de los lenguajes
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# zoxide: Smarter cd (Alias 'z' es preferible para no romper scripts que usen 'cd' nativo)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# atuin: Magical shell history
# Nota: En Warp, atuin se usa principalmente para búsqueda profunda (UP arrow suele ser Warp).
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# starship: Prompt universal
# Si usas el prompt nativo de Warp, podrías desactivar esto, pero para Zellij/SSH es vital.
if [[ $TERM_PROGRAM != "WarpTerminal" ]] && command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# --- Modern Aliases & Tools ---

# eza: ls replacement
if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -lh --icons --git --group-directories-first"
  alias la="eza -a --icons --group-directories-first"
  alias lt="eza --tree --icons --level=2"
fi

# bat: cat replacement
if command -v bat &> /dev/null; then
  alias cat="bat --paging=never"
  alias help='f() { "$@" --help 2>&1 | bat --plain --language=help }; f'
fi

# fzf: Fuzzy finder configuration
if command -v fzf &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# Aliases de conveniencia
alias vi="nvim"
alias vim="nvim"
alias v="nvim"
alias g="git"
alias k="kubectl"
alias k9s="k9s --readonly" # Seguridad por defecto en clusters de producción

# --- Custom Functions ---

# Limpieza rápida de ramales git (mencionada en el gitconfig)
alias gclean="git gone"

# Función para extraer cualquier archivo comprimido
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xf $1    ;;
      *.tar.gz)    tar xf $1    ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xf $1    ;;
      *.tgz)       tar xf $1    ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}