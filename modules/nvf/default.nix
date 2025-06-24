{
  lib,
  config,
  ...
}: let
  cfg = config.modules.nvf;
in {
  options.modules.nvf.enable = lib.mkEnableOption "nvf";
  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings = import ./nvim-settings.nix;
    };
  };
}
