# dotfiles

This repository is an attempt to organize and backup my dotfiles. 

## Structure

**config** contains all configration files that exist in `XDG_CONFIG_HOME` (ususally `~/.config`). All files and folders in this folder will be symlinked to the `XDG_CONFIG_HOME` directory upon bootstrapping.

**home** contains all dotfiles that lie directly in the home folder. These will be symlinked to `~/` upon bootstrapping.

**scripts** here lies the bootstrap script

## Notes

* Since I am using `kitty` as terminal emulator, you neeed to have the `kitty-terminfo` package installed on any remote machines you SSH into for the terminal to work correctly with programs such as `htop` and `fish`.

For using NVM with Fish shell, install: https://github.com/FabioAntunes/fish-nvm
- Requires [`fisher`](https://github.com/jorgebucaran/fisher). After installation, the plugins can be installed using `fisher update` (will also fetch `fish-nvm`)

Also assumes `fzf` is installed on the system (`sudo apt install fzf`)

## Neovim
For python:
- Install pylsp plugins through the command provided by mason:
  ``:PylspInstall pyls-black`
Install `ripgrep` and `fzf`.
## Tmux

Video: https://www.youtube.com/watch?v=DzNmUNvnB04

Install TPM: https://github.com/tmux-plugins/tpm

## Updating `kitty`
From [the docs](https://sw.kovidgoyal.net/kitty/binary/):
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

## Installing `starship` prompts
From [the docs](https://starship.rs/guide/#%F0%9F%9A%80-installation):
```bash
curl -sS https://starship.rs/install.sh | sh
```

# Graphics drivers on laptop:

Enable focal-proposed and install `libgl1-amber-dri`, `libegl-amber0`, `libglx-amber0` packages.
This link: https://wiki.ubuntu.com/Testing/EnableProposed also describes how to make it so that apt wont automatically update all packages to `-proposed` versions.
