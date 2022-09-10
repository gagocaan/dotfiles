# dotfiles

## 💡 Basic Info

**``$HOME``** sweet home

## 📖 Description

A self-contained technology is used to rapidly obtain a development environment.

## 🎯 Summary

* Install and pre-configure ZSH.
* Install and configure NeoVim to develop in Python. (Also supports other programming languages).
* Configure git.

## 🧬 Project structure

```console
.
|-- README.md
|-- gitconfig
|-- install
|-- install.conf.yaml
|-- nvim
|   |-- coc-settings.json
|   |-- init.vim
|   `-- plugins
|       |-- airline.vim
|       |-- auto-pairs.vim
|       |-- coc.vim
|       |-- dracula.vim
|       |-- floaterm.vim
|       |-- fugitive.vim
|       `-- nerdtree.vim
`-- scripts
    |-- run-setup.sh
    `-- welcome.sh
```

## ⚙️ Setup

Make sure your Operating System has the following packages installed.

1. git
2. curl
3. Python

> Most OS have pre-installed with `[1,2,3]`, just make sure!.

## 🍴 Usage

Clone the repository to your `$HOME` directory as `.dotfiles` and then run the installer.

```zsh
# Clone
cd ~
git clone https://github.com/gagocaan/dotfiles.git ~/.dotfiles

# Install
~/.dotfiles/install
```

## Uninstall and CleanUp

```zsh
# pyenv
rm -rf $(pyenv root)
# brew formulas
brew uninstall --force $(brew list)
brew autoremove && brew cleanup
# python libraries
pip3 freeze | xargs pip3 uninstall -y
```
