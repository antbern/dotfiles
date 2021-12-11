# update PATH with scripts if DOTFILES_ROOT exists

if set -q DOTFILES_ROOT
    set PATH $PATH "$DOTFILES_ROOT/scripts"
end

if test -e $HOME/.cargo/bin
    set PATH $PATH "$HOME/.cargo/bin"
end