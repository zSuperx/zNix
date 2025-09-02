{
  nixos =
    {
      info,
      pkgs,
      config,
      ...
    }:
    {
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

      documentation.nixos.enable = false;
      nixpkgs.config.allowUnfree = true;
      users.users.${info.username} = {
        isNormalUser = true;
        shell = if config.programs.fish.enable then pkgs.fish else pkgs.bash;
        extraGroups = [
          "wheel"
          "docker"
          "networkmanager"
        ];
      };
    };
}
