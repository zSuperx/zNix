{ pkgs, inputs, ... }:
{
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
  ];

  # Enable GDM greet menu
  services.displayManager.gdm.enable = true;

  xdg.portal = {
    config.niri.default = [
      # required for screenshare on Niri
      "gnome"
      "gtk"
    ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  nixpkgs.overlays = [
    inputs.niri-flake.overlays.niri
  ];

  programs.niri = {
    package = pkgs.niri-unstable;
    enable = true;
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # This supposedly allows swaync's mpris module to display album art
  services.gnome.glib-networking.enable = true;
  environment.variables = {
    GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts-color-emoji
  ];
}
