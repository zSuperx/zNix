_: {
  # Neovim
  programs.nvf = {
    enable = true;
    settings = import ./nvim-settings.nix;
  };
}
