{config, ...}: {
  programs.niri.settings = {
    input = {
      touchpad.natural-scroll = false;
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
    };

    outputs."eDP-1" = {
      position = {
        x = 1280;
        y = 0;
      };
    };

    prefer-no-csd = true;

    layout = {
      background-color = "transparent";

      gaps = 10;

      center-focused-column = "never";

      default-column-width = {proportion = 0.5;};
      focus-ring = {
        width = 4;
        active.color = "#83a598";
      };
    };

    spawn-at-startup = [
      {command = ["xwayland-satellite"];}
      {command = ["swww-daemon"];}
      {command = ["waybar"];}
    ];

    environment = {
      DISPLAY = ":0";
      NIXOS_OZONE_WL = "1";
    };

    screenshot-path = null;

    gestures = {
      dnd-edge-view-scroll = {
        trigger-width = 30;
        delay-ms = 100;
        max-speed = 1500;
      };
    };

    layer-rules = [
      {
        matches = [
          {namespace = "wayland-test";}
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          {namespace = "swww";}
        ];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      {
        matches = [
          {app-id = "r#\"firefox$\"# title=\"^Picture-in-Picture$\"";}
        ];

        open-floating = true;
      }
      {
        geometry-corner-radius = {
          bottom-left = 12.0;
          bottom-right = 12.0;
          top-left = 12.0;
          top-right = 12.0;
        };

        clip-to-geometry = true;
        draw-border-with-background = false;
      }
    ];
  };
}
