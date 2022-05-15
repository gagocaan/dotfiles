#!/bin/bash -e

if [[ $(
    . /etc/os-release
    echo "$NAME"
) == "Fedora Linux" ]]; then
    echo "Install requirements for Fedora Linux"
    dnf update
    dnf install -y coreutils curl git neovim nodejs tree lolcat virtualenv zsh
elif [[ $(
    . /etc/os-release
    echo "$NAME"
) == "Alpine Linux" ]]; then
    echo "Install requirements for Alpine Linux"
    apk update
    apk add coreutils curl git git-flow neovim nodejs python3 tree yarn zsh
elif [[ $(
    . /etc/os-release
    echo "$NAME"
) == "Raspbian GNU/Linux" ]]; then
    echo "No actions to perform"
else
    . /etc/os-release
    echo "Install requirements for Linux $NAME"
    sudo apt update
    sudo apt install -y coreutils git git-flow git-core neovim nodejs fonts-powerline curl tree lolcat virtualenv zsh
    sudo apt autoremove
fi

echo "Installation of requirements finished"
