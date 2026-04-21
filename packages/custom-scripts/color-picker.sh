#!/bin/sh
set -xe
exec 9>/tmp/$(basename "$0").lock
flock -n 9 || exit 1

notify-send -e -a 'Niri' 'Click a color!'
COLOR=$(niri msg pick-color | sed -r 's/(Picked color: |Hex: )//g' | tr '\n' ' ')
echo "$COLOR" | wl-copy
notify-send "$COLOR copied to clipboard"
