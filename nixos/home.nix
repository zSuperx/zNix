{
  inputs,
  config,
  ...
}: let
  homelink = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${path}";
in {
  # This file contains very basic attributes and fields.
  # Specific configuration/package installation can be found in the following .nix files...
  imports = [
    inputs.nvf.homeManagerModules.default

    ./packages/dev-tools.nix # Lanugages + LSPs
    ./packages/utils.nix # UNIX Utilities
    ./packages/apps.nix # Standalone applications

    ./modules/hyprland.nix # Hyprland & its numerous tools
    ./modules/terminal.nix # Terminal config
    ./modules/nvf.nix # Neovim config
  ];
  home = {
    username = "zsuper";
    homeDirectory = "/home/zsuper";

    # Manages dotfiles by symlinking at build time
    # The `homelink` function creates uses mkOutOfStoreSymlink so files can be hot relaoded.
    file = {
      # These files for Neovim are now stale, as I use NVF to declaratively install Neovim.
      ".config/nvim/init.lua".source = homelink "dotfiles/nvim/init.lua";
      ".config/nvim/lua".source = homelink "dotfiles/nvim/lua";

      ".config/hypr".source = homelink "dotfiles/hypr";
      ".config/wofi".source = homelink "dotfiles/wofi";
      ".config/yazi".source = homelink "dotfiles/yazi";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true; # Don't change this probably
}
