{
  pkgs,
  lib,
}:
rec {
  wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
  blueman-manager = lib.getExe' pkgs.blueman "blueman-manager";
  slurp = lib.getExe' pkgs.slurp "slurp";
  notify-send = lib.getExe' pkgs.libnotify "notify-send";
  nmgui = "${lib.getExe pkgs.nmgui}";
  toggle-bluetooth = pkgs.writeShellScript "toggle-bluetooth" ''
    if bluetoothctl show | grep -q "Powered: yes"; then
      # If enabled, disable it
      bluetoothctl power off
    else
      # If disabled, enable it
      bluetoothctl power on
    fi
  '';
  wpctl = lib.getExe' pkgs.wireplumber "wpctl";
  toggle-wifi = pkgs.writeShellScript "toggle-wifi" ''
    if nmcli radio wifi | grep -q "enabled"; then
      nmcli radio wifi off
      echo "WiFi is now OFF"
    else
      nmcli radio wifi on
      echo "WiFi is now ON"
    fi
    waybar -t #Refresh Waybar after each action
  '';
  spotify-status = pkgs.writeShellScript "spotify-status" ''
    truncate() {
      local str="$1"
      local max_len="$2"

      if (( ''${#str} > max_len )); then
        echo "$(echo $str | head -c $max_len)..."
      else
        echo "$str"
      fi
    }

    playerctl -p spotify_player,spotify metadata -F --format '{{status}} {{xesam:title}} - {{xesam:artist}}' |
    while read -r STATUS FILLER; do
      SONG=$(truncate "$(playerctl -p spotify_player,spotify metadata title)" 15)
      ARTIST=$(truncate "$(playerctl -p spotify_player,spotify metadata artist)" 10)
      case "$STATUS" in
        Playing) ICON="⏸" ;;
        Paused) ICON="▶" ;;
        *) ICON="◼" ;;
      esac
      echo "$ICON | $SONG - $ARTIST"
    done
  '';
  wf-waybar = pkgs.writeShellScript "wf-waybar" ''
    check-wf-recorder() {
      if pgrep -x wf-recorder > /dev/null;
      then
        echo '{"text":"  [    ⚒     ]","class":"recording"}'
      else
        echo '{"text":"  [    ⚒     ]","class":"idle"}'
      fi
    }

    check-wf-recorder

    trap 'check-wf-recorder' SIGUSR1
    while true; do
      sleep infinity & wait $!
    done
  '';
  screen-utils = pkgs.writeShellScript "screen-utils" ''
    record() {
      local type=$1
      # Prompt for output
      output=$(niri msg outputs | rg -N "^Output" | sed -r "s/^Output //" | rofi -dmenu -p "Select an output to record")

      # If user exits rofi then quit
      if [[ -z "$output" ]];
      then
        exit 0
      fi

      outputName=$(echo "$output" | sed -r "s/(.*\(|\).*)//g")

      if [[ "$type" = "region" ]]; then
        sleep 0.5
        region=$(${slurp} -o "$outputName")
      fi

      pkill -f wf-waybar --signal 10
      case "$type" in
        "region") wf-recorder -g "$region" -f /tmp/recording.mp4 -o "$outputName" -y ;;
        "monitor") wf-recorder -f /tmp/recording.mp4 -o "$outputName" -y ;;
        *) exit 0 ;;
      esac

      ${notify-send} "Recording saved to /tmp/recording.mp4"
    }

    pick-color() {
      output=$(niri msg pick-color)
      echo "$output" | sed -r "s/(Picked color: |Hex: )//g" | tr '\n' ' ' | wl-copy
      ${notify-send} "Color copied to clipboard"
    }

    if pgrep -x wf-recorder > /dev/null;
    then
      pkill -x wf-recorder
      sleep 0.5
      pkill -f wf-waybar --signal 10
      exit 0
    fi

    opt1="Take Screenshot (Region)  [to clipboard]"
    opt2="Take Screenshot (Window)  [to clipboard]"
    opt3="Record Screen   (Region)  [to /tmp/recording.mp4]"
    opt4="Record Screen   (Monitor) [to /tmp/recording.mp4]"
    opt5="Color Picker              [to clipboard]"
    result=$(echo "$opt1
    $opt2
    $opt3
    $opt4
    $opt5" | rofi -dmenu -method fuzzy -case-smart -p "Select an Action")

    case "$result" in
      "$opt1") niri msg action screenshot ;;
      "$opt2") niri msg action screenshot-window ;;
      "$opt3") record "region" ;;
      "$opt4") record "monitor" ;;
      "$opt5") pick-color ;;
      *) ;;
    esac
  '';
}
