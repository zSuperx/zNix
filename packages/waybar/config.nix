{
  pkgs,
  lib,
  ...
}:
let
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
in
{
  modules-center = [
    "custom/spotify"
  ];
  modules-left = [
    "clock"
    "network"
    "bluetooth"
    "custom/screen-utils"
  ];
  modules-right = [
    "pulseaudio"
    "backlight"
    "battery"
    "power-profiles-daemon"
    "custom/power"
  ];
  backlight = {
    format = "  {icon} {percent}%";
    format-icons = [
      "[ ░░░░░░░░░░ ]"
      "[ ▓░░░░░░░░░ ]"
      "[ ▓▓░░░░░░░░ ]"
      "[ ▓▓▓░░░░░░░ ]"
      "[ ▓▓▓▓░░░░░░ ]"
      "[ ▓▓▓▓▓░░░░░ ]"
      "[ ▓▓▓▓▓▓░░░░ ]"
      "[ ▓▓▓▓▓▓▓░░░ ]"
      "[ ▓▓▓▓▓▓▓▓░░ ]"
      "[ ▓▓▓▓▓▓▓▓▓░ ]"
      "[ ▓▓▓▓▓▓▓▓▓▓ ]"
    ];
    scroll-step = 5;
  };
  battery = {
    format = " {icon} {capacity}%";
    format-alt = " {time} {icon}";
    format-charging = " {icon} {capacity}%󱐋";
    format-critical = "  [ ░░░░░░░░░░ ] {capacity}%";
    format-full = " {icon} {capacity}%";
    format-icons = [
      " [ ░░░░░░░░░░ ]"
      "󰁺 [ ▓░░░░░░░░░ ]"
      "󰁻 [ ▓▓░░░░░░░░ ]"
      "󰁼 [ ▓▓▓░░░░░░░ ]"
      "󰁽 [ ▓▓▓▓░░░░░░ ]"
      "󰁾 [ ▓▓▓▓▓░░░░░ ]"
      "󰁿 [ ▓▓▓▓▓▓░░░░ ]"
      "󰂀 [ ▓▓▓▓▓▓▓░░░ ]"
      "󰂁 [ ▓▓▓▓▓▓▓▓░░ ]"
      "󰂂 [ ▓▓▓▓▓▓▓▓▓░ ]"
      "󰁹 [ ▓▓▓▓▓▓▓▓▓▓ ]"
    ];
    format-plugged = " {icon} {capacity}%󱐋";
    format-warning = " {icon} {capacity}%";
    states = {
      critical = 10;
      good = 80;
      warning = 20;
    };
  };
  bluetooth = {
    format = "[ <span font_size=\"13pt\"> 󰂯 </span>  ]";
    format-connected = "[  <span font_size=\"13pt\"> 󰂱 </span>  ]";
    format-off = "[  <span font_size =\"13pt\"> 󰂲 </span>  ]";
    format-on = "[  <span font_size=\"13pt\"> 󰂯 </span>  ]";
    on-click = "${toggle-bluetooth}";
    on-click-right = "${blueman-manager}";
    tooltip-format = "{controller_alias}\t{controller_address}\n{device_enumerate}";
  };
  clock = {
    format = "[ <span font_desc = \"Maple Mono Bold 11.2 \">{:%R %p}</span> ]";
    format-alt = "[ <span font_desc =\"Maple Mono Bold 11.2 \">{:%m/%d/%Y}</span> ]";
    tooltip-format = "<big>{:%d %A }</big>\n<tt><span font_desc=\"Maple Mono Bold \">{calendar}</span></tt>";
    on-click-right = "date +%m/%d/%Y | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
  };
  "custom/spotify" = {
    exec = spotify-status;
    tail = true;
    format = "  [ {} ]";
    tooltip-format = "(Scroll = Next/Prev | Right Click = Copy URL)";
    on-click = "playerctl -p spotify_player,spotify play-pause";
    on-click-right = "playerctl -p spotify_player,spotify metadata -f {{xesam:url}} | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
    on-scroll-up = "playerctl -p spotify_player,spotify next";
    on-scroll-down = "playerctl -p spotify_player,spotify previous";
  };
  "custom/screen-utils" = {
    format = "{}";
    exec = wf-waybar;
    on-click = screen-utils;
    tooltip-format = "Click to select from screen tools";
    return-type = "json";
    tail = true;
  };
  "custom/power" = {
    format = "[  ⏻   ] ";
    on-click = "${lib.getExe pkgs.wofi-power-menu}";
    tooltip = false;
  };
  height = 35;
  layer = "top";
  position = "bottom";
  network = {
    format-disabled = " [    󰤭     ]";
    format-disconnected = " [    󰤩     ]";
    format-ethernet = " [    모    ]";
    format-icons = [
      "󰤟 "
      "󰤢 "
      "󰤥 "
      "󰤨 "
    ];
    format-linked = "[ {ifname} (No IP) 모 ] ";
    format-wifi = " [    {icon}    ]";
    on-click = "${toggle-wifi}";
    on-click-right = "${nmgui}";
    tooltip-format = "{icon} {essid}";
  };
  power-profiles-daemon = {
    format = "{icon} ";
    format-icons = {
      balanced = "";
      default = "";
      performance = "";
      power-saver = "";
    };
    tooltip = true;
    tooltip-format = "Power profile: {profile}\nDriver: {driver}";
  };
  pulseaudio = {
    format = " {icon} {volume}% ";
    format-bluetooth = " {icon} {volume}%";
    format-bluetooth-critical = " 󰖁 [ ░░░░░░░░░░ ] {volume}% ";
    format-bluetooth-muted = " 󰖁 [ ░░░░░░░░░░ ] {volume}% ";
    format-critical = "  󰖁 [ ░░░░░░░░░░ ] {volume}% ";
    format-icons = {
      default = [
        " [ ░░░░░░░░░░ ]"
        " [ ▓░░░░░░░░░ ]"
        " [ ▓▓░░░░░░░░ ]"
        " [ ▓▓▓░░░░░░░ ]"
        " [ ▓▓▓▓░░░░░░ ]"
        " [ ▓▓▓▓▓░░░░░ ]"
        " [ ▓▓▓▓▓▓░░░░ ]"
        " [ ▓▓▓▓▓▓▓░░░ ]"
        " [ ▓▓▓▓▓▓▓▓░░ ]"
        " [ ▓▓▓▓▓▓▓▓▓░ ]"
        " [ ▓▓▓▓▓▓▓▓▓▓ ]"
      ];
    };
    format-muted = " 󰖁 [ ░░░░░░░░░░ ] {volume}% ";
    on-click = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
    scroll-step = 5;
    states = {
      critical = 0;
      warning = 5;
    };
  };
  spacing = 4;
}
