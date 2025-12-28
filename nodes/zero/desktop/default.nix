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
    libnotify
    socat
    swaynotificationcenter
    brightnessctl
    networkmanagerapplet
    playerctl
    xwayland-satellite
    swww
    gnome.gvfs
  ];

  services.gnome.glib-networking.enable = true;
  environment.variables = {
    GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
  };
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts-color-emoji
  ];
}
