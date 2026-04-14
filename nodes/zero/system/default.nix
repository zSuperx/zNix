{ inputs, pkgs, ... }:
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
    inputs.colmena.packages.${pkgs.stdenv.hostPlatform.system}.colmena
    coreutils
    usbutils
    qemu

    # Networking
    dig
    wget
    nmap
    websocat
    traceroute
    termshark
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
