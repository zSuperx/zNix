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
    "custom/spotify-prev"
    "mpris"
    "custom/spotify-next"
  ];
  modules-right = [
    "tray"
    "pulseaudio"
    "backlight"
    "group/hardware"
    "power-profiles-daemon"
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
    format-charging = "{icon} {capacity:3}%";
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
    format-plugged = "{icon} {capacity:3}%";
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
    on-click = "${blueman-manager}";
    on-click-right = "${toggle-bluetooth}";
    tooltip-format = "{controller_alias}\t{controller_address}\n{device_enumerate}";
  };
  clock = {
    format = "{:%I:%M %p}";
    format-alt = "{:%m/%d/%Y}";
    tooltip-format = "{:%A %d}\n{calendar}";
    on-click-right = "date +%m/%d/%Y | ${wl-copy}";
  };
  "group/hardware" = {
    orientation = "inherit";
    "drawer" = {
      "transition-duration" = 500;
      "children-class" = "not-power";
      "transition-left-to-right" = false;
    };
    children-class = "hardware-child";
    modules = [
      "battery"
      "disk"
      "memory"
      "cpu"
    ];
  };
  disk = {
    format = " {percentage_used}%";
  };
  memory = {
    format = " {percentage}%";
  };
  cpu = {
    format = " {usage}%";
  };
  mpris = {
    player = "spotify";
    format = "  {status_icon} {dynamic:^30}";
    tooltip-format = "{title} - {artist}";
    dynamic-order = [
      "title"
      "artist"
    ];
    title-len = 14;
    artist-len = 13;
    status-icons = {
      "paused" = "";
      "playing" = "";
    };
    on-click-right = "playerctl -p spotify metadata -f \"{{xesam:title}} - {{xesam:artist}}, {{xesam:url}}\" | ${wl-copy}";
  };
  "custom/spotify-prev" = {
    exec = "${spotify-status}";
    tail = true;
    return-type = "json";
    tooltip = false;
    format = "";
    on-click = "playerctl -p spotify previous";
  };
  "custom/spotify-next" = {
    exec = "${spotify-status}";
    tail = true;
    return-type = "json";
    tooltip = false;
    format = "";
    on-click = "playerctl -p spotify next";
  };
  "custom/visual-refresh" = {
    format = "";
    on-click = ''
      pkill hellpaper || matugen -c ~/zNix/home/apps/matugen/config.toml image "$(hellpaper --recursive ~/Pictures/backgrounds/)" --source-color-index 0
    '';
    on-click-right = "pkill -SIGUSR2 waybar";
    tooltip = true;
    tooltip-format = "LMB = select wallpaper | RMB = reload wallpaper";
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
    on-click = "${nmgui}";
    on-click-right = "${toggle-wifi}";
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
    format-bluetooth-critical = "  {volume:3}%";
    format-bluetooth-muted = "  {volume:3}%";
    format-critical = "  {volume:3}%";
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
    format-muted = "  {volume:3}%";
    on-click = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
    scroll-step = 5;
    states = {
      critical = 0;
      warning = 5;
    };
  };
}
