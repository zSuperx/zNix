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
    on-click-right = "date +%m/%d/%Y | ${wl-copy}";
  };
  "custom/spotify" = {
    exec = "${spotify-status}";
    tail = true;
    format = "  [ {} ]";
    tooltip-format = "(Scroll = Next/Prev | Right Click = Copy URL)";
    on-click = "playerctl -p spotify_player,spotify play-pause";
    on-click-right = "playerctl -p spotify_player,spotify metadata -f {{xesam:url}} | ${wl-copy}";
    on-scroll-up = "playerctl -p spotify_player,spotify next";
    on-scroll-down = "playerctl -p spotify_player,spotify previous";
  };
  "custom/visual-refresh" = {
    format = " [ <span font_size=\"13pt\"> 󰑐 </span>  ]  ";
    on-click = "pkill -SIGUSR2 waybar";
    tooltip = true;
    tooltip-format = "Click to visually refresh waybar";
  };
  "custom/notifications" = {
    tooltip = true;
    format = "[ {icon} ]";
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
