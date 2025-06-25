{
  lib,
  config,
  ...
}: let
  cfg = config.modules.direnv;
in {
  options.modules.direnv.enable = lib.mkEnableOption "direnv";
  config = lib.mkIf cfg.enable {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.".config/direnv/direnv.toml".source = ./direnv.toml;
  };
}
