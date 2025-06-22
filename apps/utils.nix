{pkgs, ...}: {
  # Terminal utilities & programs
  home.packages = with pkgs; [
    # Out with the old
    eza
    ripgrep
    fd
    bat
    dust

    # Useful utils
    htop
    fzf
    tree
    jq
    yazi
  ];
}
