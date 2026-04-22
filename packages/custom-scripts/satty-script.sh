#!/bin/sh
set -xe

OUT_FILE="~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
FOCUSED_OUTPUT="$(niri msg focused-output | head -n 1 | grep -oP '\(\K[^)]+')"
grim -o "$FOCUSED_OUTPUT" -t ppm - | satty \
  --filename -                             \
  --fullscreen                             \
  --output-filename "$OUT_FILE"            \
  --early-exit                             \
  --copy-command wl-copy                   \
  --initial-tool crop
