{pkgs, ...}: {
  # Use stylix to style window managers, terminals, fonts, font colors, etc.
  stylix = {
    enable = true;
    polarity = "dark";
  };

  # Common tools to help with a Wayland environment
  commonPackages = with pkgs; [
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
