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
          font = {
            name = "JetBrainsMono Nerd Font";
            size = lib.mkForce 13;
          };
          settings = { 
            background_opacity = 0.90;
            background_blur = 10;
            shell = if config.programs.fish.enable then "fish" else "bash";
            cursor_trail = "1";
            themeFile = "Catppuccin-Mocha";
          };
          extraConfig = ''
            include themes/matugen.conf
          '';
        };
      };
    };
}
