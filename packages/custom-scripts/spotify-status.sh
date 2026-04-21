#!/bin/sh
set -xe

playerctl -p spotify status -F | while read -r STATUS FILLER; do
  STATUS=$(playerctl -p spotify status || echo "Stopped")
  echo "{\"class\": \"$STATUS\"}"
done
