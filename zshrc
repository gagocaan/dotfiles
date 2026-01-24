# --- Modern ZSH Configuration (2026) ---

# Plugins (Brew installed)
# Note: Adjust paths if using Intel Mac (/usr/local) vs Apple Silicon (/opt/homebrew)
if [ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# PATH updates
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# --- Tool Initializations ---

# mise: Polyglot tool manager (Replaces nvm, pyenv, go path, etc.)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# zoxide: Smarter cd
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# atuin: Magical shell history
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# starship: Cross-shell prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# --- Modern Aliases ---
if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -l --icons --git --group-directories-first"
  alias lt="eza --tree --icons"
fi

if command -v bat &> /dev/null; then
  alias cat="bat"
fi

if command -v fzf &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Editor
export EDITOR="nvim"
alias vi="nvim"
alias vim="nvim"

# Added by Windsurf
export PATH="/Users/carlosandresgarzongonzalez/.codeium/windsurf/bin:$PATH"