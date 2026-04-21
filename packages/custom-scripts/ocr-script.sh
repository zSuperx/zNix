#!/bin/sh
set -xe
exec 9>/tmp/$(basename "$0").lock
flock -n 9 || exit 1

IMG=$(mktemp --suffix=.png)

# screenshot
grim -g "$(slurp)" "$IMG"

# OCR
TEXT=$(tesseract "$IMG" stdout --oem 1 --psm 6 -l eng 2>/dev/null)

# copy to clipboard
echo "$TEXT" | wl-copy

# notify
notify-send "OCR" "Copied to clipboard"

rm "$IMG"
