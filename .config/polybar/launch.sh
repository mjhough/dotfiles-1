#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if xrandr | grep "HDMI-0 connected"
  then polybar top_primary & polybar top_secondary & polybar bottom_primary & polybar bottom_secondary
  else polybar top_single & bottom_single
fi

echo "Polybar Launched"
