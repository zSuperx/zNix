{
  inputs,
  self,
  ...
}: {
  unify.modules.hyprland = {
    home = {
      pkgs,
      config,
      ...
    }: {
      home.file = {
        ".config/hypr".source =
          config.lib.file.mkOutOfStoreSymlink "${self.lib.projectRoot}/symlinks/hypr";
      };
    };

    nixos = {pkgs, ...}: {
      programs.hyprland = let
        inherit (pkgs.stdenv.hostPlatform) system;
      in {
        enable = true;

        package = inputs.hyprland.packages.${system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
      };
    };
  };
}
