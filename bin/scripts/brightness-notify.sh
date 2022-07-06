#!/usr/bin/bash

source ~/Programs/scripts/status-notify.sh

icon="${icon_path}display-brightness-symbolic.svg"

function brightness_notification {
    brightness=`printf "%.0f" $(xbacklight -get)`
    brightness=$(($brightness + $1))
    if (($brightness > 100)); then
        brightness=100
    elif (($brightness < 0)); then
        brightness=0
    fi

    dashes=$(python3 -c "print(f'{34*float($brightness)/100:.0f}', end='')")
    bar=$(seq -s "─" "$dashes" | sed 's/[0-9]//g')

    notify "$icon" "$bar"
}

case $1 in
up)
    brightness_notification 10
    xbacklight -inc 10
    ;;
down)
    brightness_notification -10
    xbacklight -dec 10
    ;;
*)
    echo "Usage: $0 up | down"
    ;;
esac
