{ inputs, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./services.nix
    ./languages.nix
    ./tlp.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    home-manager
    inputs.colmena.packages.${pkgs.system}.colmena
  ];
}
