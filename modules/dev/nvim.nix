{
  self,
  inputs,
  ...
}: {
  unify.modules.nvf = {
    nixos = {
      pkgs,
      config,
      ...
    }: let
      inherit (pkgs.stdenv.hostPlatform) system;
    in {
      environment.systemPackages = [
        (inputs.zNix.packages.${system}.nvim.override {colorscheme = config.lib.stylix.colors;})
      ];
    };
  };
}
