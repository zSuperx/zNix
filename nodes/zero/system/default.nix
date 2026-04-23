{ inputs, pkgs, system, ... }:
{
  imports = [
    ./boot.nix
    ./services.nix
    ./languages.nix
  ];

  environment.systemPackages = with pkgs; [
    # Core
    vim
    git
    coreutils
    usbutils
    qemu
    socat
    
    inputs.colmena.packages.${system}.colmena

    # Networking
    dig
    wget
    nmap
    websocat
    traceroute
    termshark
    speedtest-cli
  ];

  programs.wireshark = {
    dumpcap.enable = true;
    enable = true;
  };

  users.users.zsuper.extraGroups = [
    "wireshark"
    "dialout" # used for embedded UART console monitoring
  ];
}
