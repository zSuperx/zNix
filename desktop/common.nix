{ pkgs, ... }:
{
  # Use stylix to style window managers, terminals, fonts, font colors, etc.

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    opacity.terminal = 0.9;
    polarity = "dark";
  };

  # Common tools to help with a Wayland environment
  home.packages = with pkgs; [
    wl-clipboard
    wf-recorder
    wofi
    socat
    swaynotificationcenter
    brightnessctl
    networkmanagerapplet
    playerctl
  ];
}
