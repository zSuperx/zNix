{ config, ... }:
with config.lib.stylix.colors.withHashtag;
''
  * {
      font-family: Font Awesome, Liberation Mono, Maple Mono Italic, "JetbrainsMono Nerd Font", Roboto, sans-serif, DejaVuSansMono, Maple Mono, "AdwaithaMono";
      font-weight: 900;
  }

  window#waybar {
      margin-top: 10px;
      font-size: 16px;
      color: transparent;
      background-color: ${base00};
  }

  #workspaces button {
      color: ${base0E};
      font-size: 14px;
  }

  #modules-right {
      font-size: 18px;
  }

  #modules-center {
      font-size: 18px;
  }

  #clock,
  #battery,
  #backlight,
  #network,
  #bluetooth #pulseaudio,
  #wireplumber,
  #mode,
  #power-profiles-daemon,
  #mpd {
      padding: 0 10px;
      color: ${base07};
  }

  #window,
  #workspaces {
      margin: 0 4px;
  }

  .modules-left>widget:first-child>#workspaces {
      margin-left: 0;
  }

  .modules-right>widget:last-child>#workspaces {
      margin-right: 0;
  }

  #clock {
      background-color: transparent;
      color: ${base0B};
      font-weight: bold;
      font-size: 16px;
      font-family: arial;
  }

  #battery {
      background-color: transparent;
      color: ${base0D};
      border: 0px;
      border-color: ${base01};
      padding-right: 15px;
  }

  #battery.charging,
  #battery.plugged {
      color: ${base0D};
      background-color: transparent;
  }

  #battery.warning:not(.charging) {
      background-color: transparent;
      color: ${base0A};
  }

  @keyframes blink {
      to {
          background-color: transparent;
          color: ${base00};
      }
  }

  #battery.critical:not(.charging) {
      background-color: transparent;
      color: ${base08};
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: steps(12);
      animation-iteration-count: infinite;
      animation-direction: alternate;
  }

  #bluetooth {
      color: ${base0D};
      font-size: 16px;
      font-family: arial;
  }

  #bluetooth.off {
      color: ${base08};
  }

  #backlight {
      background-color: transparent;
      color: ${base0A};
  }

  #network {
      background-color: transparent;
      color: ${base0E};
      font-size: 16px;
      font-family: arial;
  }

  #network.disabled {
      background-color: transparent;
      color: ${base02};
  }

  #network.disconnected {
      background-color: transparent;
      color: ${base08};
  }

  #pulseaudio {
      background-color: transparent;
      color: ${base09};
  }

  #pulseaudio.muted,
  #pulseaudio.critical {
      background-color: transparent;
      color: ${base08};
  }


  #wireplumber {
      background-color: ${base07};
      color: ${base00};
  }

  #wireplumber.muted {
      background-color: ${base08};
  }

  #custom-power {
      color: ${base08};
      font-family: "bargraph";
      font-size: 15px;
      padding-right: 10px;
  }

  #custom-spotify-previous {
      color: ${base0E};
      font-family: "bargraph";
      font-size: 15px;
      padding-right: 10px;
  }

  #custom-spotify {
      color: ${base0E};
      font-family: "bargraph";
      font-size: 15px;
      padding-right: 10px;
  }

  #custom-spotify-next {
      color: ${base0E};
      font-family: "bargraph";
      font-size: 15px;
      padding-right: 10px;
  }
''
