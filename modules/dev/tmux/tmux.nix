{
  self,
  inputs,
  ...
}: {
  unify.modules.tmux = {
    nixos = {
      pkgs,
      config,
      ...
    }: let
      inherit (pkgs.stdenv.hostPlatform) system;
    in {
      environment.systemPackages = [
        (inputs.zNix.packages.${system}.tmux.override {colorscheme = config.lib.stylix.colors;})
      ];
    };
  };
}
