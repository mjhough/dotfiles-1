#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

$HOME/.config/polybar/launch.sh &

feh --bg-tile '/home/sean/Documents/google-drive/walls/forest.png'

xsetroot -cursor_name left_ptr &
sxhkd &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

/usr/lib/geoclue-2.0/demos/agent &
redshift &

compton -b &
numlockx on &
xautolock -detectsleep -time 10 -locker betterlockscreen -l dimblur &
mpDris2 &

fcitx &
