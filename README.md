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
├── Brewfile
├── README.md
├── TODO
├── dotbot
│   ├── CHANGELOG.md
│   ├── CONTRIBUTING.md
│   ├── LICENSE.md
│   ├── README.md
│   ├── bin
│   │   └── dotbot
│   ├── dotbot
│   │   ├── cli.py
│   │   ├── config.py
│   │   ├── context.py
│   │   ├── dispatcher.py
│   │   ├── messenger
│   │   ├── plugin.py
│   │   ├── plugins
│   │   └── util
│   ├── lib
│   │   └── pyyaml
│   ├── setup.cfg
│   ├── setup.py
│   ├── test
│   │   ├── README.md
│   │   ├── Vagrantfile
│   │   ├── driver-lib.bash
│   │   ├── test
│   │   ├── test-lib.bash
│   │   └── tests
│   └── tools
│       ├── git-submodule
│       └── hg-subrepo
├── dotbot-brew
│   ├── LICENSE
│   ├── README.md
│   ├── brew.py
│   ├── examples
│   │   ├── linux
│   │   └── macos
│   ├── poetry.lock
│   ├── pyproject.toml
│   └── test
├── dotbot-ifplatform
│   ├── LICENSE
│   ├── README.md
│   ├── example
│   │   └── if.yaml
│   ├── ifplatform.py
│   └── lib
│       └── distro
├── gitconfig
├── install
├── install.conf.yaml
├── nvim
│   ├── coc-settings.json
│   ├── init.vim
│   └── plugins
│       ├── airline.vim
│       ├── auto-pairs.vim
│       ├── coc.vim
│       ├── dracula.vim
│       ├── floaterm.vim
│       ├── fugitive.vim
│       └── nerdtree.vim
├── requirements.txt
├── scripts
│   ├── install-yarn.sh
│   ├── run-setup.sh
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
```
