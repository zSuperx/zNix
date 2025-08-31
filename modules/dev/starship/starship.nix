{
  starship =
    { pkgs, ... }:
    {
      hm = {
        programs.starship = {
          enable = true;
          enableFishIntegration = true;
          settings = pkgs.lib.importTOML ./starship.toml;
        };
      };
    };
}
