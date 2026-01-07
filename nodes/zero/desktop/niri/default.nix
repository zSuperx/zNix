{
  home.file."niri/config.kdl" = {
    enable = true;
    target = ".config/niri/config.kdl";
    text = ''
      input {
          keyboard {
              xkb {
                  layout ""
                  model ""
                  rules ""
                  variant ""
              }
              repeat-delay 600
              repeat-rate 25
              track-layout "global"
          }
          touchpad { tap; }
          focus-follows-mouse max-scroll-amount="0%"
      }
      output "eDP-1" {
          transform "normal"
          position x=1280 y=0
      }
      screenshot-path null
      prefer-no-csd
      layout {
          gaps 10
          struts {
              left 0
              right 0
              top 0
              bottom 0
          }
          focus-ring {
              width 4
              active-color "#ffffff"
          }
          border { off; }
          background-color "transparent"
          default-column-width { proportion 0.500000; }
          preset-column-widths {
              proportion 0.500000
              proportion 0.666667
              proportion 1.000000
          }
          center-focused-column "never"
      }
      cursor {
          xcursor-theme "default"
          xcursor-size 24
      }
      environment {
          DISPLAY ":0"
          "NIXOS_OZONE_WL" "1"
      }
      binds {
          Alt+Print { screenshot-window; }
          Ctrl+Alt+Delete { quit; }
          Ctrl+Print { screenshot-screen; }
          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }
          Mod+B { spawn "zen"; }
          Mod+BracketLeft { consume-or-expel-window-left; }
          Mod+BracketRight { consume-or-expel-window-right; }
          Mod+C { center-column; }
          Mod+Comma { consume-window-into-column; }
          Mod+Ctrl+1 { move-column-to-workspace 1; }
          Mod+Ctrl+2 { move-column-to-workspace 2; }
          Mod+Ctrl+3 { move-column-to-workspace 3; }
          Mod+Ctrl+4 { move-column-to-workspace 4; }
          Mod+Ctrl+5 { move-column-to-workspace 5; }
          Mod+Ctrl+6 { move-column-to-workspace 6; }
          Mod+Ctrl+7 { move-column-to-workspace 7; }
          Mod+Ctrl+8 { move-column-to-workspace 8; }
          Mod+Ctrl+9 { move-column-to-workspace 9; }
          Mod+Ctrl+D { move-workspace-down; }
          Mod+Ctrl+Down { focus-monitor-down; }
          Mod+Ctrl+End { move-column-to-last; }
          Mod+Ctrl+H { focus-monitor-left; }
          Mod+Ctrl+Home { move-column-to-first; }
          Mod+Ctrl+J { focus-monitor-down; }
          Mod+Ctrl+K { focus-monitor-up; }
          Mod+Ctrl+L { focus-monitor-right; }
          Mod+Ctrl+Left { focus-monitor-left; }
          "Mod+Ctrl+Page_Down" { move-column-to-workspace-down; }
          "Mod+Ctrl+Page_Up" { move-column-to-workspace-up; }
          Mod+Ctrl+Right { focus-monitor-right; }
          Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
          Mod+Ctrl+Shift+WheelScrollUp { move-column-left; }
          Mod+Ctrl+U { move-workspace-up; }
          Mod+Ctrl+Up { focus-monitor-up; }
          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
          Mod+Ctrl+WheelScrollLeft { move-column-left; }
          Mod+Ctrl+WheelScrollRight { move-column-right; }
          Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }
          Mod+Down { focus-window-down; }
          Mod+E { spawn "kitty" "yazi"; }
          Mod+End { focus-column-last; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Escape { spawn "hyprlock"; }
          Mod+F { maximize-column; }
          Mod+H { focus-column-or-monitor-left; }
          Mod+Home { focus-column-first; }
          Mod+J { focus-window-or-workspace-down; }
          Mod+K { focus-window-or-workspace-up; }
          Mod+L { focus-column-or-monitor-right; }
          Mod+Left { focus-column-left; }
          Mod+Minus { set-column-width "-10%"; }
          Mod+N allow-when-locked=true { spawn "playerctl" "-p" "spotify" "next"; }
          Mod+O repeat=false { toggle-overview; }
          "Mod+Page_Down" { focus-workspace-down; }
          "Mod+Page_Up" { focus-workspace-up; }
          Mod+Period { expel-window-from-column; }
          Mod+Q { close-window; }
          Mod+R { switch-preset-column-width; }
          Mod+Return { spawn "kitty"; }
          Mod+Right { focus-column-right; }
          Mod+Shift+Ctrl+Down { move-column-to-monitor-down; }
          Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
          Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
          Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
          Mod+Shift+Ctrl+L { move-column-to-monitor-right; }
          Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }
          Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
          Mod+Shift+Ctrl+Up { move-column-to-monitor-up; }
          Mod+Shift+Down { move-window-down; }
          Mod+Shift+E { quit; }
          Mod+Shift+Equal { set-window-height "+10%"; }
          Mod+Shift+Escape allow-when-locked=true { spawn "sh" "-c" "systemctl suspend & hyprlock & niri msg action power-off-monitors"; }
          Mod+Shift+F { fullscreen-window; }
          Mod+Shift+H { move-column-left-or-to-monitor-left; }
          Mod+Shift+J { move-window-down-or-to-workspace-down; }
          Mod+Shift+K { move-window-up-or-to-workspace-up; }
          Mod+Shift+L { move-column-right-or-to-monitor-right; }
          Mod+Shift+Left { move-column-left; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+N allow-when-locked=true { spawn "playerctl" "-p" "spotify" "previous"; }
          Mod+Shift+O { spawn "bash" "-c" "pkill rofi-unwrapped || rofi -show drun -method fuzzy -show-icons"; }
          "Mod+Shift+Page_Down" { move-workspace-down; }
          "Mod+Shift+Page_Up" { move-workspace-up; }
          Mod+Shift+Right { move-column-right; }
          Mod+Shift+Slash { show-hotkey-overlay; }
          Mod+Shift+Up { move-window-up; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }
          Mod+Shift+WheelScrollDown { focus-column-right; }
          Mod+Shift+WheelScrollUp { focus-column-left; }
          Mod+Space allow-when-locked=true { spawn "playerctl" "-p" "spotify" "play-pause"; }
          Mod+Up { focus-window-up; }
          Mod+V { toggle-window-floating; }
          Mod+W { toggle-column-tabbed-display; }
          Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollLeft { focus-column-left; }
          Mod+WheelScrollRight { focus-column-right; }
          Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
          Print { screenshot; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
          XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
          XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "-n4800" "--class=backlight" "set" "5%-"; }
          XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "-n4800" "--class=backlight" "set" "+5%"; }
      }
      spawn-at-startup "xwayland-satellite"
      spawn-at-startup "swww-daemon"
      spawn-at-startup "waybar"
      spawn-at-startup "swaync"
      window-rule {
          match app-id="com.network.manager"
          open-floating true
      }
      window-rule {
          match app-id=".blueman-manager-wrapped"
          open-floating true
      }
      window-rule {
          draw-border-with-background false
          geometry-corner-radius 12.000000 12.000000 12.000000 12.000000
          clip-to-geometry true
      }
      layer-rule {
          match namespace="swww"
          place-within-backdrop true
      }
      gestures {
          dnd-edge-view-scroll {
              trigger-width 30
              delay-ms 100
              max-speed 1500
          }
      }
      // Attempt to source matugen theme for niri
      include optional=true "matugen.kdl"
    '';
  };
}
