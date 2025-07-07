{inputs, ...}: {
  unify.modules.starship = {
    home = {pkgs, ...}: {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings = pkgs.lib.importTOML ./starship.toml;
      };
    };
  };
}
