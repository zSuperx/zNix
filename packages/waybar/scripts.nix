{
  pkgs,
  lib,
}:
{
  wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
  blueman-manager = lib.getExe' pkgs.blueman "blueman-manager";
  slurp = lib.getExe' pkgs.slurp "slurp";
  notify-send = lib.getExe' pkgs.libnotify "notify-send";
  nmgui = "${lib.getExe pkgs.nmgui}";
  wpctl = lib.getExe' pkgs.wireplumber "wpctl";
  toggle-bluetooth = pkgs.writeShellScript "toggle-bluetooth" ''
    if bluetoothctl show | grep -q "Powered: yes"; then
      # If enabled, disable it
      bluetoothctl power off
    else
      # If disabled, enable it
      bluetoothctl power on
    fi
  '';
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
      local max_len="$1"
      local str="$2"

      if (( ''${#str} > max_len )); then
        echo "$(echo $str | head -c $max_len)..."
      else
        echo "$str"
      fi
    }


    playerctl -p spotify metadata -F --format '{{status}} {{xesam:title}} - {{xesam:artist}}' | while read -r STATUS FILLER; do
      STATUS=$(playerctl -p spotify status)
      SONG_RAW=$(playerctl -p spotify metadata --format '{{title}}')
      SONG=$(truncate 15 "$SONG_RAW")
      ARTIST_RAW=$(playerctl -p spotify metadata --format '{{xesam:artist}}')
      ARTIST=$(truncate 15 "$ARTIST_RAW")
      case "$STATUS" in
        Playing) echo "{\"text\": \"   $SONG - $ARTIST\", \"tooltip\": \"$SONG_RAW - $ARTIST_RAW\", \"class\": \"$STATUS\"}" ;;
        Paused) echo "{\"text\": \"   $SONG - $ARTIST\", \"tooltip\": \"$SONG_RAW - $ARTIST_RAW\", \"class\": \"$STATUS\"}" ;;
        *) echo "{\"text\": \"\"}" ;;
      esac
      
    done
  '';
}
