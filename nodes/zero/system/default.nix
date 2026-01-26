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
    coreutils
    usbutils

    # Networking
    dig
    wget
    nmap
    websocat
    traceroute
    termshark
    wireshark
  ];

  programs.wireshark = {
    dumpcap.enable = true;
    enable = true;
  };
  users.users.zsuper.extraGroups = [
    "wireshark"
  ];
}
