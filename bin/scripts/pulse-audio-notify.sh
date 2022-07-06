#!/usr/bin/bash

# Volume notification: Pulseaudio and dunst
# inspired by gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

source ~/Programs/scripts/status-notify.sh

function get_volume_icon {
    if [ "$1" -lt 10 ]; then
        echo -n "audio-volume-muted-symbolic.svg"
    elif [ "$1" -lt 34 ]; then
        echo -n "audio-volume-low-symbolic.svg"
    elif [ "$1" -lt 67 ]; then
        echo -n "audio-volume-medium-symbolic.svg"
    elif [ "$1" -le 100 ]; then
        echo -n "audio-volume-high-symbolic.svg"
    else
        echo -n "audio-volume-overamplified-symbolic.svg"
    fi
}

function volume_notification {
    volume=`pamixer --get-volume`
    vol_icon=`get_volume_icon $volume`
    dashes=$(python3 -c "print(f'{34*float($volume)/100:.0f}', end='')")
    bar=$(seq -s "─" $dashes | sed 's/[0-9]//g')
    if [ "$volume" -lt 10 ]; then
        bar="mute"
    fi
    notify "$icon_path$vol_icon" "$bar"
}

function mute_notification {
    if [ $(pamixer --get-mute) == 'true' ]; then
        notify "${icon_path}audio-volume-muted-symbolic.svg" "mute"
    else
        notify "${icon_path}`get_volume_icon $(pamixer --get-volume)`" "unmute"
    fi
}

function toggle_mute {
    if [ $(pamixer --get-mute) == 'true' ]; then
        pamixer -u
    else
        pamixer -m
    fi
}

case $1 in
up)
    pamixer -i 10
    volume_notification
    ;;
down)
    pamixer -d 10
    volume_notification
    ;;
mute)
    toggle_mute
    mute_notification
    ;;
*)
    echo "Usage: $0 up | down | mute"
    ;;
esac
