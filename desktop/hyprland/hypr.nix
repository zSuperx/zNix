{
  inputs,
  pkgs,
  ...
}: let
  common = import ../common.nix {inherit inputs pkgs;};
in {
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  # Packages I need specifically for the Hyprland ecosystem
  home.packages = with pkgs;
    [
      hyprpaper
      hypridle
      hyprshot
      hyprlock
    ]
    ++ common.commonPackages;

  programs.hyprpanel = {
    enable = true;
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
}
