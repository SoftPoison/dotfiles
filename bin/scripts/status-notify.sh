#!/usr/bin/bash

icon_path="/usr/share/icons/Papirus/symbolic/status/"
notify_id=506

# notify <icon> <text>
function notify {
    dunstify -r "$notify_id" -u low -t 2000 -i "$1" "$2"
}

