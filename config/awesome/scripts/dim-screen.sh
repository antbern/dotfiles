#!/bin/bash

# Based on xss-lock example in /usr/share/doc/xss-lock/dim-screen2.sh
# is run as part of xxs-lock to dim the screen before locking the computer

# Fade the screen and wait. Needs xbacklight.
# When receiving SIGHUP, stop fading and set backlight to original brightness.
# When receiving SIGTERM, wait a bit, and set backlight to original brightness
# (this prevents the screen from flashing before it is turned completely off
# by DPMS in the locker command).

min_brightness=5
fade_time=2000
fade_steps=70
brightness_file=/tmp/last_brightness

BRIGHTNESS=$(xbacklight -get)
echo "$BRIGHTNESS" > $brightness_file
# trap "xbacklight -set $BRIGHTNESS" EXIT

# always delete the file on exit
trap "rm $brightness_file" EXIT

# only reset brightness upon SIGHUP (ie xss-lock aborting locking due to activity)
trap 'kill %%; xbacklight -set $BRIGHTNESS; exit 0' HUP

# if terminated (ie screen was locked), don't return screen brightness
trap 'sleep 1s; kill %%; exit 0' TERM

xbacklight -time $fade_time -steps $fade_steps -set $min_brightness &
wait
sleep infinity & # No, sleeping in the foreground does not work
wait
