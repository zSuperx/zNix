{
  waybar = {
    hm =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        programs.waybar = {
          enable = true;
          settings.mainBar = import ./_config.nix { inherit pkgs lib; };
          # style = import ./_style.nix { inherit pkgs config; };
        };
      };
  };
}
