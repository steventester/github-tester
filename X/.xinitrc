#!/bin/sh

if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

if [ -f $HOME/.Xresources ]; then
    /usr/bin/xrdb $HOME/.Xresources
fi

xsetroot -cursor_name left_ptr
mpd &
# nm-applet &
sxhkd & 
urxvt &
exec bspwm
