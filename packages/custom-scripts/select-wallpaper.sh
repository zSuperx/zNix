#!/bin/sh
set -xe
exec 9>/tmp/$(basename "$0").lock
flock -n 9 || exit 1

# Path to your wallpaper folder
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Generate the list of images for Rofi
# The format is: Name\0icon\x1f/path/to/image
choice=$(ls "$WALLPAPER_DIR" | while read -r img; do
    echo -en "$img\0icon\x1f$WALLPAPER_DIR/$img\n"
done | rofi -dmenu -i -theme ~/.config/rofi/wallpaper-grid.rasi -p " ")

# If a choice was made, apply it
if [ -n "$choice" ]; then
    matugen image -c ~/zNix/home/apps/matugen/config.toml "$WALLPAPER_DIR/$choice" --source-color-index 0
fi
