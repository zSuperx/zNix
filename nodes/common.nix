# NixOS configuration options common between all nodes.
# Additional configuration should be added on top of this through the use of other modules.
let
  publicKeys = import ./public-keys.nix;
in
{ pkgs, ... }:
{
  time.timeZone = "America/Los_Angeles";

  users.users = {
    # All nodes will have the supergonk user defined
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
    };
    openssh.enable = true;
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
  overlays = [ (final: prev: {
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];
};
  system.stateVersion = "25.05";
}
