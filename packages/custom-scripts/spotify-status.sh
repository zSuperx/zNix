#!/bin/sh

while true; do
  playerctl -p spotify status -F 2>/dev/null | while read -r STATUS; do
    [ -z "$STATUS" ] && STATUS="Stopped"
    echo "{\"class\": \"$STATUS\"}"
  done

  # If playerctl exits (e.g. Spotify not ready), retry
  sleep 1
done
