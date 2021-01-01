#!/usr/bin/env fish

# Inspired by caarlos0's dotfiles.fish repository bootstrapping script
# run from the root of the dotfiles repository

# get the path to the root directory, assumes that this script is in scripts/
# set DOTFILES_ROOT (pwd -P)
set -Ux DOTFILES_ROOT (dirname (dirname (realpath (status filename))))

function success
    echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
end

function success_warn
    echo [(set_color --bold yellow) ' OK ' (set_color normal)] $argv
end

function abort
    echo [(set_color --bold red) 'ABRT' (set_color normal)] $argv
    exit 1
end


function link_file --description "links a file"
    # read arguments into local variables
    echo $argv | read -l src dst

    #echo $src $dst

    if test -e $dst # if destination already exists
        # find out where the existing link points to
        set dst_existing (readlink $dst)
        if test "$dst_existing" = "$src" 
            # link points to the same, skip!
            success "skipped $src"
            return
        else
            # make backup of old file
            mv $dst $dst.backup
                and success_warn "moved $dst to $dst.backup"
                or abort "failed to backup $dst to $dst.backup"
        end
    end

    # perform actual linking
    mkdir -p (dirname $dst)
        and ln -sf $src $dst
        and success "linked $src to $dst"
        or abort "could not link $src to $dst"

end


# first link the files and folders in the config
for src in $DOTFILES_ROOT/config/{.,}*
    link_file $src $HOME/.config/(basename $src)
end

# and then those in the home folder
for src in $DOTFILES_ROOT/home/{.,}*
    link_file $src $HOME/(basename $src)
end