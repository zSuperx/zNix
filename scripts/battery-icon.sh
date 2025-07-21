battery_info=$(upower -e | grep --line-buffered BAT | head -n 1 | xargs upower -i)

percent=$(echo "$battery_info" | grep percentage | awk '{ print $2 }' | sed 's/%//g')
status=$(echo "$battery_info" | grep state | awk '{ print $2 }')

if [[ "$status" == "charging" ]]; then
  icon="󰂄"
elif (( percent >= 90 )); then
  icon="󰁹"
elif (( percent >= 70 )); then
  icon="󰂁"
elif (( percent >= 50 )); then
  icon="󰂀"
elif (( percent >= 30 )); then
  icon="󰁾"
elif (( percent >= 15 )); then
  icon="󰁻"
else
  icon="!!!"
fi

echo "$icon"
