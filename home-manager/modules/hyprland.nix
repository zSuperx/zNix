{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];
  home.packages = [
    # HYPRLAND
    pkgs.hyprpaper
    pkgs.hypridle
    pkgs.hyprshot
    pkgs.hyprlock
  ];

  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overwrite.enable = true;

    override = {
      theme.bar.buttons.dashboard.icon = "#81A1CA";
      menus.clock.time.hideSeconds = true;
      menus.dashboard.powermenu.avatar.image = "$HOME/Pictures/jue-viole-grace.png";
    };

    settings = {
      bar.launcher.icon = "";
      bar.workspaces.showApplicationIcons = true;
      bar.workspaces.showWsIcons = true;
      bar.workspaces.numbered_active_indicator = "highlight";

      theme.font.size = "0.9rem";
      theme.bar.buttons.style = "wave";

      scalingPriority = "hyprland";
    };
  };
}
