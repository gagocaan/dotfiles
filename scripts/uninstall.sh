#!/usr/bin/env bash

# Remove Python libraries
pip3 freeze >requirements.txt # Backup Python dependencies
pip3 freeze | xargs pip3 uninstall -y

# Remove Brew formulas
brew bundle dump # Backup formulas
brew uninstall --force $(brew list)
brew autoremove && brew cleanup

# Remove Pyenv
rm -rf $(pyenv root)
rm -rf ~/.pyenv
