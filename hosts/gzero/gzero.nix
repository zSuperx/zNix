{
  self,
  inputs,
  config,
  ...
}: let
  username = "zsuper";
  hostname = "gzero";
  stateVersion = "25.05";
in {
  unify.hosts.nixos.${hostname} = rec {
    args = {
      inherit username hostname;
    };

    modules = with config.unify.modules; [
      profile-basic
      profile-dev
      profile-hyprland
      profile-gaming
      profile-niri
      wayland-utils
      gBar
      gnome
    ];

    users.${username}.modules = modules;

    # NOTE: This `config` shadows unify's config, which exists on the
    # top-level of flake-parts, as opposed to that of NixOS
    nixos = {
      pkgs,
      lib,
      config,
      ...
    }: {
      imports = [
        ./_configuration.nix
        ./_hardware-configuration.nix
      ];

      users.users.${username} = {
        isNormalUser = true;
        shell = lib.mkIf config.programs.fish.enable pkgs.fish;
        extraGroups = [
          "wheel"
          "docker"
          "networkmanager"
        ];
      };

      system = {
        inherit stateVersion;
      };
      home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };

    home = {
      home = {
        inherit stateVersion;
        sessionPath = ["$HOME/bin"];
      };
      programs.home-manager.enable = true;
    };
  };
}
