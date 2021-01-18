
function generate-lockscreen-background -d "generates an appropriate lockscreen background image for use with i3lock"
    # argv[1] is the image to use
    set -l target "$HOME/.local/share/backgrounds/lockscreen.png"
    set -l screen_dimensions 1920x1080
    convert $argv[1] -resize $screen_dimensions^ -gravity center -extent $screen_dimensions $target
    # convert $target -blur 0x6 $target
end