#!/usr/bin/bash

FORMAT=$(echo -ne '{{mpris:artUrl}}\t{{title}}\t{{artist}}')

function notify {
    img_url=$(echo "$1" | awk -F'\t' '{print $1}')
    title=$(echo "$1" | awk -F'\t' '{print $2}')
    artist=$(echo "$1" | awk -F'\t' '{print $3}')

    dunstify -r "507" -u low -t 4000 -i "$img_url" "$title"$'\n'"$artist"
}

function getmeta {
    metadata=$(playerctl metadata -f "$FORMAT")
    notify "$metadata"
}

case $1 in
play-pause)
    playerctl play-pause
    getmeta
    ;;
next)
    playerctl next
    getmeta
    ;;
previous)
    playerctl previous
    getmeta
    ;;
display)
    getmeta
    ;;
follow)
    playerctl metadata -F -f "$FORMAT" | while read -r line; do notify "$line"; done
    ;;
*)
    echo "Usage: $0 play-pause|next|previous|display|follow"
    ;;
esac
