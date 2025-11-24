# NixOS configuration options common between all nodes.
# Additional configuration should be added on top of this through the use of other modules.
{
  inputs,
  pkgs,
  config,
  ...
}:
let
  publicKeys = [
    # Main laptop (old)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILl06sDJJiaC+aP+Yf8pbD++dC+8syQIOen22e7ysDXA zsuper@nixos"

    # Main laptop (new)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1ynXOnCqUQny5Suy/b0DJciv4GB2w+aBZ26nrW0NZQ zsuper@zero"

    # On-network thinkpad (YOU SHOULD DEPLOY FROM HERE)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEZd/NHanLEeZcO7UJ3cSA3L6+t9bHJiX4Vv/aCzS6Na supergonk@thinkpad"
  ];
in
{
  imports = [ inputs.disko.nixosModules.disko ];

  users.users = {
    zsuper = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = publicKeys;
      hashedPasswordFile = "/run/keys/hashedPassword.secret";
    };

    root = {
      openssh.authorizedKeys.keys = publicKeys;
      hashedPasswordFile = "/run/keys/hashedPassword.secret";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  programs.fish.enable = true;
  services = {
    tailscale = {
      enable = true; # declaratively add node to Tailnet
      authKeyFile = "/run/keys/tailscale.secret"; # populated by Colmena
      extraUpFlags = [
        "--hostname"
        config.networking.hostName
      ];
    };
    openssh.enable = true;
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking = {
    nameservers = [
      "1.0.0.1"
      "1.1.1.1"
      "8.8.8.8"
    ];
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
  };

  time.timeZone = "America/Los_Angeles";

  # Nix related options that likely won't change
  documentation.nixos.enable = false;
  documentation.man.generateCaches = false;
  nix.package = pkgs.lixPackageSets.stable.lix;
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
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        inherit (prev.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];
  };
  system.stateVersion = "25.05";
}
