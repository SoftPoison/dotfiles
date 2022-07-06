#!/bin/bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

polybar -q main 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Polybar launched..."
