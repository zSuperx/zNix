{
  pkgs,
  lib,
  config,
  info,
  ...
}:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.fprintd.enable = true;

  users.users.${info.username} = {
    isNormalUser = true;
    shell = lib.mkIf config.programs.fish.enable pkgs.fish;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
  };
  networking = {
    # Enable networking
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
      enable = true;
    };
  };

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    upower.enable = true;
    tailscale.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      browseDomains = [ "local" ];
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  };

  programs.nix-ld.enable = true;

  security.rtkit.enable = true;

  # GLOBAL SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    kitty
    vim
    wget
    git
  ];

  fonts.fontDir.enable = true;

  # ADVANCED
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
