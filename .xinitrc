#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export LANG=en_US.UTF-8

xrandr --setprovideroutputsource modesetting NVIDIA -0
xrandr --auto


if [[ $(hostname) == 'sean-pavilion' ]]; then
  if xrandr | grep "HDMI-0 disconnected"; then
      xrandr --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-1 --off --output HDMI-0 --off
      nvidia-settings --assign CurrentMetaMode="DPY-0: nvidia-auto-select @1920x1080 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  else
      xrandr --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-1 --off --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate normal
      nvidia-settings --assign CurrentMetaMode="DPY-0: nvidia-auto-select @1920x1080 +1920+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  fi
fi

exec bspwm 
