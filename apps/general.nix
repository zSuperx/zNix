{pkgs, ...}: {
  # General purpose applications
  home.packages = with pkgs; [
    spotify
    obsidian
    mpv
  ];

  programs.vesktop.enable = true;
}
