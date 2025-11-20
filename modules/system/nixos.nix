{
  nixos =
    {
      info,
      userInfo,
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
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "docker"
          "networkmanager"
        ];
      };
      hm = {
        home.sessionVariables = {
          EDITOR = userInfo.editor;
        };
      };
    };
}
