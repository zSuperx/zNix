{pkgs, ...}: {
  # General purpose applications
  imports = [
    ./discord
  ];

  home.packages = with pkgs; [
    spotify
    obsidian
    mpv
  ];
}
