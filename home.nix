{
  inputs,
  config,
  ...
}: let
  # Helper function
  homelink = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${path}";
in {
  imports = [
    inputs.nvf.homeManagerModules.default

    # Hyprland
    ./desktop/hyprland/hypr.nix

    # Development
    ./apps/languages.nix
    ./apps/terminal.nix
    ./apps/utils.nix

    # Apps
    ./apps/general.nix
    ./apps/games.nix
  ];
  home = {
    username = "zsuper";
    homeDirectory = "/home/zsuper";

    # Manage dotfiles by symlinking at build time
    file = {
      ".config/direnv/direnv.toml".source = homelink "dotfiles/direnv/direnv.toml";
      ".config/hypr".source = homelink "dotfiles/desktop/hyprland";
      ".config/wofi".source = homelink "dotfiles/wofi";
      ".config/yazi".source = homelink "dotfiles/yazi";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "24.11";
  };

  # Neovim
  programs.nvf = {
    enable = true;
    settings = import ./editor/nvim-settings.nix;
  };

  programs.home-manager.enable = true; # Don't change this probably
}
