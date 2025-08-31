{
  pkgs,
  lib,
  ...
}: let
  blueman-manager = lib.getExe' pkgs.blueman "blueman-manager";
  nmtui = "${lib.getExe pkgs.kitty} nmtui";
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
in {
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
    format-alt = "[ <span font_desc =\"Maple Mono Bold 11.2 \">{:%d %m %Y}</span> ]";
    tooltip-format = "<big>{:%d %A }</big>\n<tt><span font_desc=\"Maple Mono Bold \">{calendar}</span></tt>";
  };
  "custom/power" = {
    format = "[   ⏻   ] ";
    on-click = "echo hi";
    tooltip = false;
  };
  height = 35;
  layer = "top";
  modules-center = [];
  modules-left = [
    "clock"
    "network"
    "bluetooth"
  ];
  modules-right = [
    "pulseaudio"
    "backlight"
    "battery"
    "power-profiles-daemon"
    "custom/power"
  ];
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
    on-click-right = "${nmtui}";
    tooltip-format = "{icon} {essid}";
  };
  power-profiles-daemon = {
    format = "{icon}";
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
