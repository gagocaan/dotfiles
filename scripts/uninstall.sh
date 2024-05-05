#!/bin/zsh

set -e

# Remove Python libraries
pip3 freeze --exclude wheel >requirements.txt # Backup Python dependencies
pip3 freeze --exclude wheel | xargs pip3 uninstall -y --break-system-packages

pyenv shell system  # Switch to system python
pyenv global system # Switch to system python
PYENV_ROOT=$(pyenv root)
source $HOME/.zshrc # Reload the source

# Remove Poetry
pipx uninstall poetry

# Remove Brew formulas
brew bundle dump --force # Backup formulas
brew tap >Brewtap        # Taps (Third-Party Repositories)
brew uninstall --force $(brew list)
brew untap $(brew tap)
brew upgrade && brew autoremove && brew cleanup --prune=all

# Comment the lines in your `.zshrc`
sed -i '' 's/\(^# Pyenv$\)/#\1/' $HOME/.dotfiles/zshrc
sed -i '' 's/\(^export PYENV_ROOT.*\)/#\1/' $HOME/.dotfiles/zshrc
sed -i '' 's/\(^command -v pyenv .*$\)/#\1/' $HOME/.dotfiles/zshrc
sed -i '' 's/\(^eval "$(pyenv init -)"$\)/#\1/' $HOME/.dotfiles/zshrc
sed -i '' 's/\(^alias brew=.*\)/#\1/' $HOME/.dotfiles/zshrc

# Remove Pyenv
rm -rf $PYENV_ROOT
rm -rf ~/.pyenv
