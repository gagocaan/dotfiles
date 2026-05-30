# ==============================================================================
# ZSH CONFIGURATION 2026 - macOS Development Environment
# User: Carlos Andres Garzon Gonzalez
# ==============================================================================

# ==============================================================================
# 1. ENVIRONMENT SETUP
# ==============================================================================

# PATH: Prioritize Homebrew and local binaries over system defaults
# ~/.local/bin -> Homebrew (Apple Silicon) -> Homebrew (Intel) -> System bins
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Editor: Neovim as default editor (not native vim)
export EDITOR="nvim"
export VISUAL="nvim"

# Locale: UTF-8 to avoid encoding issues
export LANG="en_US.UTF-8"

# XDG Base Directory: standard paths for configs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ==============================================================================
# 2. TOOL INITIALIZATIONS (Lazy Load)
# Only loaded if the tool is installed — prevents errors on clean systems
# ==============================================================================

# --- mise: Polyglot Runtime Manager ---
# Manages runtime versions for Node, Go, Python, Ruby, Rust, etc.
# "mise activate" adds the binaries to PATH automatically
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# --- zoxide: Smarter "cd" ---
# Learns your most visited directories and allows navigation with "z <fuzzy>"
# Alias 'z' to avoid breaking scripts that use native 'cd'
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# --- atuin: Magical Shell History ---
# History with sync, advanced search, and cross-machine sharing.
# --disable-up-arrow: Warp handles arrow keys natively, avoids conflict
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# --- starship: Cross-shell Prompt ---
# Shows Git status, K8s context, runtime versions, etc.
# Disabled in Warp (uses its native prompt) but enabled in Zellij/SSH
if [[ $TERM_PROGRAM != "WarpTerminal" ]] && command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# --- fzf: Fuzzy Finder ---
# Ctrl+T: search files, Ctrl+R: search history, Alt+C: interactive cd
if command -v fzf &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_R_OPTS='--preview="echo {}" --preview-window=up:3'

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# ==============================================================================
# 3. MODERN ALIASES (CLI Replacements)
# Modern replacements for classic Unix tools
# ==============================================================================

# --- eza: Modern "ls" ---
# Icons, git status, colors — replacement for "ls"
if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -lh --icons --git --group-directories-first"
  alias la="eza -a --icons --group-directories-first"
  alias lt="eza --tree --icons --level=2"
  alias l.="eza -d .* --icons"  # Hidden files only
fi

# --- bat: Modern "cat" ---
# Syntax highlighting, line numbers, git diffs
if command -v bat &> /dev/null; then
  alias cat="bat --paging=never"
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

# k9s in readonly mode for safety (prevents accidents in production)
alias k9s="k9s --readonly"

# Remove already-merged git branches from remote
alias gclean="git gone"

# ==============================================================================
# 4. CUSTOM FUNCTIONS
# ==============================================================================

# extract: Extract any compressed file
# Usage: extract archivo.tar.gz
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

# mkcd: Create directory and navigate to it
# Usage: mkcd new_folder
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ==============================================================================
# 5. COMPLETIONS & PERFORMANCE
# ==============================================================================

# Enable brew autocomplete
if command -v brew &> /dev/null; then
  autoload -Uz compinit
  compinit
fi

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# ==============================================================================
# 6. ZSH PLUGINS (Require additional installation)
# ==============================================================================

# Uncomment if installed via brew:
# ZSH Plugins — Syntax highlighting and autosuggestions
# These activate automatically after brew install
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/cagarzon/.lmstudio/bin"
# End of LM Studio CLI section