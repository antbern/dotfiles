
# To override the auto activation upon starting the terminal, execute:
# conda config --set auto_activate_base false


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -e $HOME/miniconda3/bin/conda
    eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end

# had to add this too for normal anaconda
if test -e $HOME/anaconda3/bin/conda
    eval $HOME/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

