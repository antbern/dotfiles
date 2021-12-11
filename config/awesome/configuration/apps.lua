
local paths = require('configuration.paths')

local editor = os.getenv("EDITOR") or "editor"

return {
    default = {
        -- List of defaults applications

        file_manager = "pcmanfm",
        terminal = "kitty --single-instance",
        editor_cmd= "kitty --single-instance" .. editor,
        code = "code",

        rofi = "rofi -combi-modi run,window,drun -show combi -modi combi -icon-theme Papirus -show-icons",
        calculator = "gnome-calculator",
        insert_character = "rofimoji",
        screenshot_interactive = "gnome-screenshot --interactive",
        process_viewer = "kitty --single-instance htop",

    },

    command = {
        -- Commands for performing various tasks
        bisplay_brightness_up = "xbacklight -perceived +5",
        bisplay_brightness_down = "xbacklight -perceived -5",

        music_play_pause = "playerctl play-pause",
        music_next = "playerctl next",
        music_previous = "playerctl previous",

        exit_screen_lock = "loginctl lock-session",
        exit_screen_suspend = "systemctl suspend",
        exit_screen_poweroff = "systemctl poweroff",
        exit_screen_reboot ="systemctl reboot",

        keyboard_layout_1 = "ibus engine xkb:se::swe",
        keyboard_layout_2 = "ibus engine xkb:us::eng",
        keyboard_layout_3 = "ibus engine xkb:de::ger",

        keyboard_home = "xdotool key --clearmodifiers Home",
        keyboard_end = "xdotool key --clearmodifiers End",
    },

    -- List of apps to start once on start-up unless it is not running
    autostart = {
        "xrdb -merge $HOME/.Xresources", -- load Xresources
        "numlockx on", -- enable numlock on startup
        "setxkbmap -option caps:super",  -- change caps lock to act as Super (Mod4) key
        "picom", -- compositor for transparency (config in ~/.config/picom.conf)
        "nitrogen --restore", -- wallpaper
        "xfce4-power-manager", -- power manager
        "fusuma", -- trackpad gestures
        "pnmixer", -- audio mixer / source selection (+ keyboard shortcuts)
        "indicator-sound-switcher", -- easily select audio input/ouput source
        "nm-applet", -- NetworkManager tray icon
        "blueman-applet", -- Bluetooth Manager
        "redshift-gtk", -- redshift tray icon (for red screen during night)
        "lxpolkit", -- lightweight polkit manager
        "xbindkeys", -- to bind the mouse keys
        "dropbox start", -- dropbox
        "xss-lock -n " .. paths.script_dir .. "dim-screen.sh -- " .. paths.script_dir .. "i3lock-wrapper.sh", -- lock screen on suspend
        -- "$DOTFILES_ROOT/other/sidewinder_x4/sidewinder_x4_hidraw.py", --  Sidewinder X4 keyboard hidraw interface
        "workrave"
    }
}