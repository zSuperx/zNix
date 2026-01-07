{
  pkgs,
  scripts,
}:
let
  inherit (pkgs) lib;
  inherit (scripts)
    wl-copy
    blueman-manager
    nmgui
    toggle-bluetooth
    wpctl
    toggle-wifi
    spotify-status
    ;
in
{
  modules-left = [
    "clock"
    "custom/notifications"
    "network"
    "bluetooth"
    "custom/visual-refresh"
  ];
  modules-center = [
    "custom/spotify"
  ];
  modules-right = [
    "tray"
    "pulseaudio"
    "backlight"
    "battery"
    "power-profiles-daemon"
    "custom/power"
  ];
  backlight = {
    format = "  {percent:3}%";
    scroll-step = 5;
  };
  battery = {
    format = "{icon} {capacity:3}%";
    format-alt = "{icon} {time}";
    format-time = "{H}:{m} hrs";
    format-full = "{icon} {capacity:3}%";
    format-charging = "{icon} {capacity:3}%󱐋";
    format-critical = " {capacity:3}%";
    format-icons = [
      ""
      "󰁺"
      "󰁻"
      "󰁼"
      "󰁽"
      "󰁾"
      "󰁿"
      "󰂀"
      "󰂁"
      "󰂂"
      "󰁹"
    ];
    format-plugged = "{icon} {capacity:3}%󱐋";
    format-warning = "{icon} {capacity:3}%";
    states = {
      critical = 10;
      good = 80;
      warning = 20;
    };
  };
  bluetooth = {
    format = "󰂯";
    format-connected = "󰂱";
    format-off = "󰂲";
    format-on = "󰂯";
    on-click = "${toggle-bluetooth}";
    on-click-right = "${blueman-manager}";
    tooltip-format = "{controller_alias}\t{controller_address}\n{device_enumerate}";
  };
  clock = {
    format = "{:%I:%M %p}";
    format-alt = "{:%m/%d/%Y}";
    tooltip-format = "{:%A %d}\n{calendar}";
    on-click-right = "date +%m/%d/%Y | ${wl-copy}";
  };
  "custom/spotify" = {
    exec = "${spotify-status}";
    tail = true;
    format = "{}";
    return-type = "json";
    on-click = "playerctl -p spotify play-pause";
    on-click-right = "playerctl -p spotify metadata -f {{xesam:url}} | ${wl-copy}";
    on-scroll-up = "playerctl -p spotify next";
    on-scroll-down = "playerctl -p spotify previous";
  };
  "custom/visual-refresh" = {
    format = "󰑐";
    on-click = "pkill -SIGUSR2 waybar";
    tooltip = true;
    tooltip-format = "Click to visually refresh waybar";
  };
  "custom/notifications" = {
    tooltip = true;
    format = "{icon}";
    format-icons = {
      notification = "󱅫";
      none = "󰂜";
      dnd-notification = "󰂠";
      dnd-none = "󰪓";
      inhibited-notification = "󰂛";
      inhibited-none = "󰪑";
      dnd-inhibited-notification = "󰂛";
      dnd-inhibited-none = "󰪑";
    };
    return-type = "json";
    exec-if = "which swaync-client";
    exec = "swaync-client -swb";
    on-click = "swaync-client -t -sw";
    on-click-right = "swaync-client -d -sw";
    escape = true;
  };
  "custom/power" = {
    format = "⏻";
    on-click = "${lib.getExe pkgs.wofi-power-menu}";
    tooltip = false;
  };
  height = 35;
  layer = "top";
  position = "bottom";
  network = {
    format-disabled = "󰤭";
    format-disconnected = "󰤩";
    format-ethernet = "모";
    format-icons = [
      "󰤟"
      "󰤢"
      "󰤥"
      "󰤨"
    ];
    format-linked = "{ifname} (No IP) 모";
    format-wifi = "{icon}";
    on-click = "${toggle-wifi}";
    on-click-right = "${nmgui}";
    tooltip-format = "{icon} {essid}";
  };
  power-profiles-daemon = {
    format = "{icon}";
    format-icons = {
      balanced = "  Bal";
      default = "";
      performance = " Perf";
      power-saver = " Eco";
    };
    tooltip = true;
    tooltip-format = "Power profile: {profile}\nDriver: {driver}";
  };
  pulseaudio = {
    format = "{icon}  {volume:3}%";
    format-bluetooth = "{icon}  {volume:3}%";
    format-bluetooth-critical = "󰖁  {volume:3}%";
    format-bluetooth-muted = "󰖁  {volume:3}%";
    format-critical = "󰖁  {volume:3}%";
    format-icons = {
      default = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
    };
    format-muted = "󰖁  {volume:3}%";
    on-click = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
    scroll-step = 5;
    states = {
      critical = 0;
      warning = 5;
    };
  };
}
