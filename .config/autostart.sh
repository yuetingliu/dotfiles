#!/usr/bin/env sh

# window compositor
picom -b

# set up dual display
#if [[ -f /home/yueting/.screenlayout/arrange.sh ]]; then
#    source $HOME/.screenlayout/arrange.sh
#fi
#xrandr --output eDP1 --auto --primary --output DP2 --auto --same-as eDP1
#/usr/bin/xrandr --output DP2 --auto --right-of eDP1 --scale 1.5
#/usr/bin/xrandr --output eDP1 --auto --primary --mode 1920x1200 --output DP2 --auto --mode 3440x1440 --right-of eDP1 --scale 1
#autorandr -c

# set background on startup
nitrogen --restore &

# autostart applications for system level and user level
dex -a -s $HOME/.config/autostart/

#[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
