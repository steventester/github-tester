#!/bin/sh

if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

if [ -f $HOME/.Xresources ]; then
    /usr/bin/xrdb $HOME/.Xresources
fi

mpd &
urxvt &
exec i3
