{
  unify.modules.wezterm = {
    home = {pkgs, ...}: {
      stylix.targets.wezterm.enable = true;

      programs.wezterm = {
        enable = true;
        package = pkgs.wezterm;

        # ITS FAT
        extraConfig =
          builtins.readFile
          ./wezterm.lua
          + ''

            return {
              cursor_blink_ease_in = "Constant",
              cursor_blink_ease_out = "Constant",
              cursor_blink_rate = 500,
              default_cursor_style = "BlinkingBar",
            }
          '';
      };
    };
  };
}
