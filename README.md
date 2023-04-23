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
Install packer:

https://github.com/wbthomason/packer.nvim

 git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim


Install `ripgrep`.