# dotfiles

This repository is an attempt to organize and backup my dotfiles. 

## Structure

**config** contains all configration files that exist in `XDG_CONFIG_HOME` (ususally `~/.config`). All files and folders in this folder will be symlinked to the `XDG_CONFIG_HOME` directory upon bootstrapping.

**home** contains all dotfiles that lie directly in the home folder. These will be symlinked to `~/` upon bootstrapping.

**scripts** here lies the bootstrap script