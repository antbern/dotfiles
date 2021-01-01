# this sets up some default XDG directory variables
# see https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# for more information
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"
