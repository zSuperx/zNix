{inputs, ...}: {
  unify.modules.nvf = {
    home = {
      pkgs,
      ...
    }: {
      imports = [
        inputs.nvf.homeManagerModules.default
      ];

      programs.nvf = {
        enable = true;
        settings = import ./_nvim-settings.nix;
      };

      stylix.targets.nvf.enable = true;
    };
  };
}
