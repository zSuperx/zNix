pkgs: {
  smart-split = pkgs.writeShellScript "tmux-smart-split" ''
    WIDTH=$(($(tmux display -p "#{pane_width}") / 2 - 10));
    HEIGHT=$(tmux display -p "#{pane_height}");

    if [ "$WIDTH" -gt "$HEIGHT" ]; then
      tmux split-window -h -c '#{pane_current_path}'
    else
      tmux split-window -v -c '#{pane_current_path}'
    fi
  '';

  get-battery-icon = pkgs.writeShellScript "get-battery-icon" ''
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
    elif (( 15 > percent )); then
      icon="!!!"
    else
      icon="N/A"
    fi

    echo "$icon"
  '';

  get-battery-capacity = pkgs.writeShellScript "get-battery-capacity" ''
    upower -e | grep --line-buffered BAT | head -n 1 | xargs upower -i | grep percentage | awk '{ print $2 }' | sed 's/%//g'
  '';
}
