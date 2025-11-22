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
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts-color-emoji
  ];
}
