# This is to avoid errors and problems with the terminal arising from having TERM=xterm-kitty when using SSH (eg when SSHing into a newly flashed RPi Zero W)
# Also helps to install xterm-kitty package

# from https://github.com/kovidgoyal/kitty/issues/4164#issuecomment-961326005

alias ssh=TERM=xterm-256color ssh