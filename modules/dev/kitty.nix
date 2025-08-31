{
  kitty =
    {
      config,
      lib,
      ...
    }:
    {
      hm = {
        programs.kitty = {
          enable = true;
          font.size = lib.mkForce 13;
          settings = {
            shell = if config.programs.fish.enable then "fish" else "bash";
            cursor_trail = "1";
            themeFile = "Catppuccin-Mocha";
          };
        };

        stylix.targets.kitty.enable = true;
      };
    };
}
