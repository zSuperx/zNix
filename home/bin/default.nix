{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./direnv.nix
    ./nh.nix
    ./yazi.nix
    ./zoxide.nix
  ];
  home.packages = with pkgs; [
    jq
    fzf
    nitch
    eza
    ripgrep
    bat
    dust
    fd
    gotop
    kitty
    vim
    wget
    git
    nix-tree
    typst
  ];

  # Reverse map from binary names to Nix packages
  programs.command-not-found = {
    enable = true;
    dbPath = inputs.programsdb.packages.${pkgs.stdenv.hostPlatform.system}.programs-sqlite;
  };
}
