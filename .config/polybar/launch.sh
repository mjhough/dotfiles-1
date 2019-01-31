#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
if [[ $(hostname) == 'sean-pavilion' ]]; then
  if xrandr | grep "HDMI-0 connected"; then 
    polybar top_primary & 
    polybar top_secondary & 
    polybar bottom_primary & 
    polybar bottom_secondary
  else polybar top_single & 
       polybar bottom_single
  fi
elif [[ $(hostname) == 'sean-desktop' ]]; then
  polybar top_desktop_primary & 
  polybar top_desktop_secondary & 
  polybar bottom_desktop_primary & 
  polybar bottom_desktop_secondary
fi
echo "Polybar Launched"
