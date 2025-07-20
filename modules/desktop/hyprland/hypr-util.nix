{
  unify.modules.hypr-util = {
    home = {pkgs, ...}: {
      programs.hyprpanel = {
        enable = false;

        settings = {
          menus.dashboard.powermenu.avatar.image = "~/.face.icon";
          theme = {
            bar.buttons.dashboard.icon = "#81A1CA";
            bar.buttons.style = "wave";
            font.size = "0.9rem";
          };

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
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        hyprpaper
        hypridle
        hyprshot
        hyprlock
      ];
    };
  };
}
