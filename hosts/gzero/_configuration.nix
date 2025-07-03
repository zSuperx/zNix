{pkgs, ...}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.fprintd.enable = true;

  networking = {
    # Enable networking
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [22];
      allowedUDPPorts = [];
      enable = true;
    };
  };

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {
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

    trusted-users = ["root" "@wheel"];
  };

  nixpkgs.config.allowUnfree = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
