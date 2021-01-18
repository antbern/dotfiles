#!/bin/bash

brightness_file=/tmp/last_brightness

# if the file exists, read the brightness and reset it once
# this script exits (ie after computer being unlocked)
if [[ -f "$brightness_file" ]]; then
    BRIGHTNESS=$(cat $brightness_file)
    trap "xbacklight -set $BRIGHTNESS" EXIT

    # TODO maybe also raise backlight a bit for easier reading
fi

# launch i3lock with a static background picture
i3lock -n -i $HOME/.local/share/backgrounds/lockscreen.png

