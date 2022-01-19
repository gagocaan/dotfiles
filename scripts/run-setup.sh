#!/bin/bash -e

# TODO: Improve for other OS
case $(uname) in
Darwin)
    echo "Install requirements for Mac OS ..."
    which -s brew
    if [[ $? != 0 ]]; then
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew update
    brew install coreutils git-delta git-flow go lolcat neovim poetry powerlevel10k tree virtualenv zsh zsh-autosuggestions zsh-syntax-highlighting
    pip3 install pynvim jedi
    echo "Installation finished."
    ;;
Linux)
    echo "Install requirements for Linux ..."
    apt update
    apt install -y coreutils git delta git-flow neovim curl tree lolcat virtualenv zsh zsh-autosuggestions zsh-syntax-highlighting
    # TODO: Test if has pip
    pip3 install pynvim jedi
    echo "Installation finished."
    ;;
*)
    echo "The Operating System is not recognized."
    ;;
esac
