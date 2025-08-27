{
  self,
  inputs,
  ...
}: {
  unify.modules.nvf = {
    home = {pkgs, ...}: let
      inherit (pkgs.stdenv.hostPlatform) system;
    in {
      imports = [
        inputs.nvf.homeManagerModules.default
      ];

      programs.nvf = {
        enable = true;
        defaultEditor = true;
        settings = inputs.nvim-personal.configuration.${system}.default;
      };

      stylix.targets.nvf.enable = true;
    };
  };
}
