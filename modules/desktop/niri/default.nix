{
  self,
  inputs,
  ...
}: {
  unify.modules.niri = {
    home = {pkgs, config, ...}: {
      # NOTE: cannot enable stylix target if symlinking!
      stylix.targets.niri.enable = false;

      home.file = {
        ".config/niri".source = config.lib.file.mkOutOfStoreSymlink "/home/zsuper/dotfiles/symlinks/niri";
      };
    };

    nixos = {pkgs, ...}: {
      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];
      imports = [
        inputs.niri.nixosModules.niri
      ];
      programs.niri.enable = true;
    };
  };
}
