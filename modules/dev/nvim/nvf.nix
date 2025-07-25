{
  self,
  inputs,
  lib,
  ...
}: {
  unify.modules.nvf = {
    home = {pkgs, ...}: {
      imports = [
        inputs.nvf.homeManagerModules.default
      ];

      programs.nvf = {
        enable = true;
        defaultEditor = true;
        settings = import ./_nvim-settings.nix { isMaximal = true; inherit pkgs lib; };
      };

      stylix.targets.nvf.enable = true;
    };
  };

  perSystem = {inputs', ...}: {
    packages.nvim =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = inputs'.nixpkgs.legacyPackages;
        extraSpecialArgs = { isMaximal = false; };
        modules = [
          (import ./_nvim-settings.nix)
        ];
      }).neovim;

    packages.nvim-full =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = inputs'.nixpkgs.legacyPackages;
        extraSpecialArgs = { isMaximal = true; };
        modules = [
          (import ./_nvim-settings.nix)
        ];
      }).neovim;
  };
}
