{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
    ./statusbar

    ./common.nix
  ];

  # Packages I need specifically for the Hyprland ecosystem
  home.packages = with pkgs; [
    hyprpaper
    hypridle
    hyprshot
    hyprlock
  ];
}
