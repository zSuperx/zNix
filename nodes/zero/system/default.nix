{ inputs, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./services.nix
    ./languages.nix
    ./tlp.nix
  ];

  environment.systemPackages = with pkgs; [
    # Core
    vim
    git
    inputs.colmena.packages.${pkgs.system}.colmena

    # Networking
    wget
    nmap
    traceroute
    dig
    busybox
  ];
}
