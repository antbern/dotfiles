#!/usr/bin/env fish

# inspired by davatorium's monotor_layout.sh in rofi-sripts
# https://github.com/davatorium/rofi-scripts/blob/master/monitor_layout.sh

# execute with
# `rofi -show monitor -modi "monitor:./rofi_mode_monitor_layout.fish" -icon-theme Papirus -show-icons -no-fixed-num-lines`
# or 
# `./rofi_mode_monitor_layout.fish`

# find xrandr first
if not set -l XRANDR (which xrandr)
    echo "xrandr not found on the system"
    exit 1
end

# get a list of all connected displays
set -l displays ($XRANDR | awk '( $2 == "connected" ){print $1}')
set -l displays_disconnected ($XRANDR | awk '( $2 == "disconnected" ){print $1}')
set -l displays_all ($XRANDR | awk '( $2 == "connected" || $2 == "disconnected" ){print $1}')

set -l tiles "Cancel"
set -l commands "true"

# generate single display commands
for disp_a in $displays

    set cmd "$XRANDR --output $disp_a --auto --primary"
    for disp_b in $displays
        if test "$disp_a" != "$disp_b"
            set -a cmd "--output $disp_b --off"
        end
    end
    # append it to the list of commands (as one string)
    set -a tiles "Only $disp_a"
    set -a commands (echo $cmd)
end

# generate dual display commands
for disp_a in $displays
    for disp_b in $displays
        if test "$disp_a" != "$disp_b"
            set -a tiles "Dual $disp_a | $disp_b"
            set -a commands "$XRANDR --output $disp_a --auto --primary --output $disp_b --auto --right-of $disp_a"
        end
    end
end

# generate clone display commands
for disp_a in $displays
    for disp_b in $displays
        if test "$disp_a" != "$disp_b"
            set -a tiles "Clone $disp_a = $disp_b"
            set -a commands "$XRANDR --output $disp_a --auto --primary --output $disp_b --auto --same-as $disp_a"
        end
    end
end

# add auto all disconnected command
set -a tiles "Auto configure disconnected displays"
set -a commands (echo $XRANDR "--output "$displays_disconnected" --auto")

# add auto all command
set -a tiles "Auto configure all displays"
set -a commands (echo $XRANDR "--output "$displays_all" --auto")


# function to echo the commands to rofi
function create_input
    # echo -en "aap\0icon\x1ffolder\n"
    for i in (seq (count $argv))
        echo -en "$argv[$i]\0info\x1f$i\x1ficon\x1fdisplay\n"
    end
end

# notify-send -a AppName "RETV: $ROFI_RETV, INFO: $ROFI_INFO, ARGV $argv" -t 5000

# discover what mode we are in
set -q ROFI_RETV

if test $status -eq 0
    # ROFI_RETV exists
    # react to rofi mode environment variables
    switch $ROFI_RETV
        case 0 # initial script call
            echo -en "\0prompt\x1fMonitor Layout\n"
            echo -en "\0no-custom\x1ftrue\n"
            create_input $tiles

        case 1 # entry selected 
            eval $commands[$ROFI_INFO]
            exit 0
    end
else
    # does not exist, call rofi with input directly

    set -l result (create_input $tiles | rofi -dmenu -p "Monitor Setup  " -a 0 -i -only-match -format d -no-fixed-num-lines)

    # rofi returns nonzero exit status if the script was aborted via ESC
    if test $status -eq 0 
        eval $commands[$result]
    end
end


