#!/bin/sh
set -xe
exec 9>/tmp/$(basename "$0").lock
flock -n 9 || exit 1

WALLPAPER="$(hellpaper --recursive ~/Pictures/Wallpapers/)"
matugen -c ~/zNix/home/apps/matugen/config.toml image "$WALLPAPER" --source-color-index 0
