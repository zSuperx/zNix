{
  lib,
  ...
}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = lib.mkForce 11;
    };
    settings = {
      background_opacity = 0.92;
      shell = "fish";
      cursor_trail = "1";
      themeFile = "Catppuccin-Mocha";
    };
    extraConfig = ''
      include themes/matugen.conf
    '';
  };
}
