{
  imports = [
    ./apps
    ./shell
    ./bin
  ];

  home = {
    username = "zsuper";
    homeDirectory = "/home/zsuper";
    stateVersion = "25.05"; # Please read the comment before changing.
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  programs.home-manager.enable = true;
}
