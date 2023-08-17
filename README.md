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
├── README.md
├── gitconfig
├── install
├── install.conf.yaml
├── nvim
│   ├── init.lua
│   ├── lua
│   │   └── user
│   │       ├── colorscheme.lua
│   │       ├── keymap.lua
│   │       ├── options.lua
│   │       ├── packer.lua
│   │       └── plugins
│   │           ├── float-term.lua
│   │           ├── lualine.lua
│   │           └── nvim-tree.lua
│   └── plugin
│       └── packer_compiled.lua
├── scripts
│   ├── uninstall.sh
│   └── welcome.sh
└── zshrc
```

## ⚙️ Setup

Make sure your Operating System has the following packages installed.

1. git
2. curl
3. Python

> Most OS have pre-installed with `[1,2,3]`, just make sure!.

## 🍴 Usage

Clone the repository to your `$HOME` directory as `.dotfiles` and then run the installer.

```bash
# Clone
cd ~
git clone https://github.com/gagocaan/dotfiles.git ~/.dotfiles

# Install
~/.dotfiles/install
```

## Uninstall and CleanUp

```bash
~/.dotfiles/scripts/uninstall.sh
```

**Reboot your system for avoiding conflicts.**
