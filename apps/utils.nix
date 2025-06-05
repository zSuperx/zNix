{pkgs, ...}: {
  # Terminal utilities & programs
  home.packages = with pkgs; [
    ripgrep
    htop
    tree
    jq
    yazi
    bat
  ];
}
