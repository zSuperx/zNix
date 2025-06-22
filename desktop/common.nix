{pkgs, ...}: {
  # Use stylix to style window managers, terminals, fonts, font colors, etc.
  stylix.targets = {
    nvf.enable = true;
    wezterm.enable = true;
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
