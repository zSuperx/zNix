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
    playerctl -p spotify status -F | while read -r STATUS FILLER; do
      STATUS=$(playerctl -p spotify status)
      echo "{\"class\": \"$STATUS\"}"
    done
  '';
}
