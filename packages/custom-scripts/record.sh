#!/bin/sh
set -xe
exec 9>/tmp/$(basename "$0").lock
flock -n 9 || exit 1

# Get the focused output name
# We store it in a variable first to check if it's empty
if pkill -x -SIGINT wf-recorder; then
  notify-send -e "Recording Finished!" "Video saved to /tmp/recording.mp4"
  exit 0
fi

FOCUSED_OUTPUT=$(niri msg focused-output | head -n 1 | rg -Po '\((.*)\)' -r '$1')

if [ -z "$FOCUSED_OUTPUT" ]; then
  notify-send -e "Recording Error" "Could not detect focused output."
  exit 1
fi

REGION="$(slurp)"

if [ -z "$REGION" ]; then
  notify-send "Selection Error" "Region empty or invalid."
  exit 1
fi

notify-send -e "Recording Started!" "Click the button again to finish."
wf-recorder -o "$FOCUSED_OUTPUT" -y -f /tmp/recording.mp4 -g "$REGION"
