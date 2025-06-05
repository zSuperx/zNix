{pkgs, ...}: {
  # General purpose applications
  home.packages = with pkgs; [
    vesktop
    spotify
    obsidian
    mpv

    playerctl
    wofi
    wf-recorder
  ];
}
