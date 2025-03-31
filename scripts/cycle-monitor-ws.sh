if [[ $# -ne 1 ]]; then
	echo "Usage: $0 [prev|next]"
	exit 1
fi

if [ "$1" = "next" ]; then
	op="+"
elif [ "$1" = "prev" ]; then
	op="-"
else
	echo "Invalid argument: $1"
	exit 1
fi

active=$(hyprctl activewindow -j)
if [ "$active" = "{}" ]; then
	if [ "$op" = "+" ]; then
		hyprctl dispatch workspace m+1
	else
		hyprctl dispatch workspace m-1
	fi
	exit 1
fi

active_monitor=$(echo "$active" | jq '.monitor')
active_workspace=$(echo "$active" | jq '.workspace.id')

next_workspace=$(hyprctl workspaces -j | jq "[.[] | select(.monitorID == $active_monitor and .id > 0)] | sort_by(.id) | map(.id) | .[(index($active_workspace) $op 1) % length]")

hyprctl dispatch workspace "$next_workspace"
