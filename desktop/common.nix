{pkgs, ...}: {
  # Use stylix to style window managers, terminals, fonts, font colors, etc.

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
