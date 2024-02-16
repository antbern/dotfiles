
# To override the auto activation upon starting the terminal, execute (once):
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

# for attaching to the devcontainer
function dca --description 'Attach to the running devcontainer'
	# first get the ipc file path
	# See https://github.com/microsoft/vscode-remote-release/issues/4202
	set container_name "cryptpayrs_devcontainer-devcontainer-1"
	set IPC_FILE (docker exec --user=vscode $container_name find /tmp -name "vscode-remote-containers-ipc*" | head -1)

	docker exec -e REMOTE_CONTAINERS_IPC=$IPC_FILE -it --user=vscode --workdir "/workspaces/cryptpay.rs" $container_name fish

end


# brew install bat exa lazygit zoxide 

# setup aliases for programs if they exist
if command -q bat
    alias cat="bat"
end

if command -q exa
	alias ls="exa"
	# For showing all files, including hidden ones
	alias ll="exa -la"
	alias tree="exa --tree"
end

if command -q lazygit
    alias lg="lazygit"
end

# better "cd" command
if command -q zoxide
	zoxide init fish --cmd cd | source
	alias zz="cd -"
end

# starship prompt
if command -q starship
	starship init fish | source	
end
