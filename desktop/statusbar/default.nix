_: {
  programs = {
    gBar = {
      enable = true;
      config = {
        Location = "T";
        EnableSNI = true;
        SNIIconSize = {
          Discord = 26;
          OBS = 23;
        };
        WorkspaceSymbols = ["" ""];
        NumWorkspaces = 10;
        BatteryFolder = "/sys/class/power_supply/BAT0";

        SuspendCommand = "systemctl suspend";
        ExitCommand = "hyprctl dispatch dpms";
        LockCommand = "hyprlock";
      };

      # extraCSS = builtins.readFile ./gBar/style.css;
      extraSCSS = builtins.readFile ./gBar/style.scss;
    };

    hyprpanel = {
      enable = false;
      hyprland.enable = true;
      overwrite.enable = true;

      override = {
        menus.dashboard.powermenu.avatar.image = "~/.face.icon";
        theme = {
          bar.buttons.dashboard.icon = "#81A1CA";
          bar.buttons.style = "wave";
          font.size = "0.9rem";
        };
      };

      settings = {
        bar = {
          launcher.icon = "";
          workspaces = {
            showApplicationIcons = true;
            showWsIcons = true;
            numbered_active_indicator = "highlight";
          };
          notifications.show_total = true;
          media.rightClick = "playerctl --player=spotify metadata xesam:url | wl-copy";
        };

        notifications.ignore = ["spotify"];

        scalingPriority = "hyprland";
      };
    };

    waybar.enable = true;
  };
}
