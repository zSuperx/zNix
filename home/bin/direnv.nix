{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file.".config/direnv/direnv.toml".text = ''
    [global]
    log_filter = "^$"
  '';
}
