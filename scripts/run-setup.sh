#!/bin/bash -e

case $(uname) in
Darwin)
    echo "Install requirements for Mac OS ..."
    which -s brew
    if [[ $? != 0 ]]; then
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew upgrade
    brew cleanup
    brew install coreutils git-delta git-flow go lolcat neovim node poetry powerlevel10k tree virtualenv zsh zsh-autosuggestions zsh-syntax-highlighting
    pip3 install pynvim black flake8 isort
    echo "Installation finished."
    ;;
Linux)
    if [[ $(
        . /etc/os-release
        echo "$NAME"
    ) == "Fedora Linux" ]]; then
        echo "Install requirements for Fedora Linux"
        dnf update
        dnf install -y coreutils curl git neovim nodejs python3-pip tree lolcat virtualenv zsh zsh-autosuggestions zsh-syntax-highlighting
        # TODO: Test if has pip
        pip3 install pynvim black flake8 isort
        echo "Installation finished"
    elif [[ $(
        . /etc/os-release
        echo "$NAME"
    ) == "Alpine Linux" ]]; then
        echo "Install requirements for Alpine Linux"
        apk update
        apk add coreutils curl git git-flow neovim python3 py3-pip tree zsh zsh-autosuggestions zsh-syntax-highlighting
        # TODO: Test if has pip
        pip3 install pynvim black flake8 isort
    else
        echo "Install requirements for Linux $NAME"
        sudo apt update
        sudo apt install -y coreutils git git-flow git-core neovim nodejs fonts-powerline python3-pip curl tree lolcat virtualenv zsh zsh-autosuggestions zsh-syntax-highlighting
        # TODO: Test if has pip
        pip3 install pynvim black flake8 isort

        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "Installation finished."
    fi
    ;;
*)
    echo "The Operating System is not recognized."
    ;;
esac
