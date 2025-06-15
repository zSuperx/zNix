hyprctl monitors -j | jq '.[] | .name' | xargs -I{} sh -c 'gBar bar "$1" &>/dev/null &' _ {}
