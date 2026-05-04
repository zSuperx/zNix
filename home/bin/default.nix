{
  inputs,
  pkgs,
  system,
  self,
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
    # Add all custom shell scripts
    self.packages.${system}.scripts
    # Add my nvim
    self.packages.${system}.nvim

    jq
    fzf
    nitch
    eza
    ripgrep
    bat
    dust
    fd
    btop
    kitty
    vim
    wget
    git
    nix-tree
    typst
    fastfetch
  ];

  # Reverse map from binary names to Nix packages
  programs.command-not-found = {
    enable = true;
    dbPath = inputs.programsdb.packages.${system}.programs-sqlite;
  };
}
