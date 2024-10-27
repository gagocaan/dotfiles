# Plugins
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Brew
export PATH="/usr/local/sbin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

eval "$(starship init zsh)"

# Created by `pipx` on 2024-07-11 11:33:13
export PATH="$PATH:/Users/carlosandresgarzongonzalez/.local/bin"
