#!/usr/bin/bash

source ~/bin/scripts/status-notify.sh

icon="${icon_path}display-brightness-symbolic.svg"

function brightness_notification {
    brightness=`printf "%.0f" $(brightnessctl g)`
    brightness=$(($brightness + $1))
    if (($brightness > 512)); then
        brightness=512
    elif (($brightness < 0)); then
        brightness=0
    fi

    dashes=$(python3 -c "print(f'{32*float($brightness)/512:.0f}', end='')")
    bar=$(seq -s "─" "$dashes" | sed 's/[0-9]//g')

    notify "$icon" "$bar"
}

case $1 in
up)
    brightness_notification 10
    brightnessctl s +5%
    ;;
down)
    brightness_notification -10
    brightnessctl s 5%-
    ;;
*)
    echo "Usage: $0 up | down"
    ;;
esac
