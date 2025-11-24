{
  imports = [
    ./apps
    ./shell
    ./bin
  ];

  home = {
    username = "zsuper";
    homeDirectory = "/home/zsuper";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  programs.home-manager.enable = true;
}
