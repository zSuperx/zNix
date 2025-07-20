{
  unify.modules.kitty = {
    home = {pkgs, lib, config, ...}: {
      programs.kitty = {
        enable = true;
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
