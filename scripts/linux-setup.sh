#!/bin/bash -e

if [[ $(uname) == "Linux" ]]; then
    echo "Install requirements for Linux ..."
    apt update
    apt install -y git delta neovim curl tree lolcat
    echo "Installation finished."
else
    echo "A Linux Operating System was not detected, the installation of require   ments cannot be performed."

fi
