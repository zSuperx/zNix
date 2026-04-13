{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./niri.nix
  ];

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wf-recorder
    slurp
    grim
    satty
    libnotify
    socat
    swaynotificationcenter
    brightnessctl
    networkmanagerapplet
    playerctl
    xwayland-satellite
    awww
    gnome.gvfs
  ];

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  services.gnome.glib-networking.enable = true;
  environment.variables = {
    GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
  };
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.monocraft
    pkgs.noto-fonts-color-emoji
  ];
}
