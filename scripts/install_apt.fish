#!/usr/bin/env fish

# if 

# general
sudo add-apt-repository ppa:aslatter/ppa

sudo apt-get install \
    awesome \
    qt5-style-plugins \
    lxappearance \
    picom \ # sudo add-apt-repository ppa:regolith-linux/unstable
    lxpolkit \ 
    alacritty \ # also need ppa
    redshift \
    redshift-gtk \
    pcmanfm \
    xfce4-power-manager \
    nitrogen \
    pnmixer \
    playerctl \
    i3lock-fancy \
    numlockx \
    xdotool \
	flameshot
    
# sound-switcher-indicator / indicator-sound-switcher

XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2

# additional for laptop
# sudo apt-get install \
#     blueman \
#     fusuma

awesome qt5-style-plugins lxappearance picom lxpolkit alacritty redshift redshift-gtk pcmanfm xfce4-power-manager nitrogen pnmixer playerctl i3lock-fancy numlockx
