# add fly.io cli to path
if test -e "$HOME/.fly"
	set -x FLYCTL_INSTALL "$HOME/.fly"
    set PATH $PATH "$FLYCTL_INSTALL/bin"
end
