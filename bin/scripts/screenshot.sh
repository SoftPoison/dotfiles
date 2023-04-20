#!/bin/sh


case $1 in
current)
    grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | swappy -f -
    ;;
region)
    grim -g "$(slurp)" - | swappy -f -
    ;;
*)
    grim - | swappy -f -
    ;;
esac
