{
  self,
  inputs,
  ...
}: {
  unify.modules.hyprland = {
    home = {
      pkgs,
      config,
      lib,
      ...
    }: {
      stylix.targets.hyprland.enable = true;

      wayland.windowManager.hyprland = let
        inherit (pkgs.stdenv.hostPlatform) system;
        cycle-monitor-script = "${self}/scripts/cycle-monitor-ws.sh";
        launch-gBar-script = "${self}/scripts/launch-gBar.sh";
      in {
        enable = true;
        xwayland.enable = true;

        package = inputs.hyprland.packages.${system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;

        # Don't autostart hyprland since I'm kurrently using Niri
        systemd.enable = false;

        settings = {
          "$terminal" = "kitty";
          "$fileManager" = "$terminal yazi";
          "$statusbar" = launch-gBar-script;
          "$menu" = "wofi";
          "$screenshot_region" = "hyprshot -z -m region --clipboard-only";
          "$screenshot_screen" = "hyprshot -z -m output --clipboard-only";

          exec-once = [
            "$statusbar"
            "nm-applet --indicator"
            "hypridle"
            "hyprpaper"
          ];

          env = [
            "XCURSOR_SIZE,48"
            "HYPRCURSOR_SIZE,48"

            "DISPLAY,0"
            "NIXOS_OZONE_WL,1"
          ];

          general = {
            gaps_in = 2;
            gaps_out = 5;
            border_size = 1;

            layout = ''"dwindle"'';
          };

          decoration = {
            rounding = 32;
            rounding_power = 1;
            blur = {
              enabled = true;
              size = 3;
              passes = 1;
              vibrancy = 0.1696;
            };
          };

          "$windowSpeed" = 3;

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, $windowSpeed, myBezier"
              "windowsOut, 1, $windowSpeed, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, $windowSpeed, default"
            ];
          };
          monitor = ",preferred,auto,auto";

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
          };

          input = {
            kb_layout = "us";

            follow_mouse = 1;

            sensitivity = 0;

            touchpad = {
              natural_scroll = false;
            };
          };

          gestures = {
            workspace_swipe = true;
          };

          "$mainMod" = "SUPER";

          bind = [
            "$mainMod, B, exec, firefox"
            "$mainMod, RETURN, exec, $terminal"
            "$mainMod, Q, killactive,"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, V, togglefloating,"
            "$mainMod, R, exec, pgrep $menu || $menu # Prevents window duplication"
            ", Print, exec, $screenshot_region"
            "ALT, Print, exec, $screenshot_screen"
            "$mainMod, H, movefocus, l"
            "$mainMod, J, movefocus, d"
            "$mainMod, K, movefocus, u"
            "$mainMod, L, movefocus, r"
            "$mainMod SHIFT, H, movewindow, l"
            "$mainMod SHIFT, J, movewindow, d"
            "$mainMod SHIFT, K, movewindow, u"
            "$mainMod SHIFT, L, movewindow, r"
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"
            "$mainMod, M, togglespecialworkspace, magic"
            "$mainMod SHIFT, M, movetoworkspace, special:magic"
            "$mainMod, TAB, exec, sh ${cycle-monitor-script} next"
            "$mainMod SHIFT, TAB, exec, sh ${cycle-monitor-script} prev"
            "$mainMod, O, workspace, emptym"
            "$mainMod SHIFT, O, movetoworkspace, emptym"
            "$mainMod ALT, L, exec, hyprlock"
          ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          bindl = [
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "$mainMod, SPACE, exec, playerctl play-pause"
            "$mainMod SHIFT, N, exec, playerctl previous"
            "$mainMod, N, exec, playerctl next"
          ];

          bindel = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ];

          windowrulev2 = [
            "bordersize 3, class:.*"
            "suppressevent maximize, class:.*"
            "opacity 1.0 0.8, class:.*"
            "opacity 1.0 override, class:firefox, title:.*YouTube.*"
            "opacity 1.0 override, class:firefox, title:.*Zoom.*"
            "opacity 1.0 override, class:firefox, title:.*Prime Video.*"
            "opacity 1.0 override, class:firefox, title:.*(\| Disney\+).*"
          ];
        };
      };
    };
  };
}
