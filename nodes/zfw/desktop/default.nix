{ pkgs, inputs, ... }:
{
  # Wayland-related programs
  environment.systemPackages = with pkgs; [
    # Clipboard
    wl-clipboard

    # Screenshots/Recording
    slurp
    grim
    satty
    wf-recorder

    # Notifications
    libnotify
    swaynotificationcenter

    # IPC
    playerctl
    brightnessctl
    networkmanagerapplet
    xwayland-satellite

    # Wallpaper
    awww
  ];

  # Enable GDM greet menu
  services.displayManager.gdm.enable = true;

  # Niri window manager
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

  # Hyprlock, Hypridle, and fingerprint
  security.pam.services.hyprlock = { };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  services.fprintd.enable = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts-color-emoji
  ];

  # Key remapping
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          # Maps capslock to escape on tap, capslock on hold
          capslock = "overload(caps, esc)";
        };
        caps = {
          capslock = "caps";
        };
      };
    };
  };
}
