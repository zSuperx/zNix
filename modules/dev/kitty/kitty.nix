{
  unify.modules.kitty = {
    home = {pkgs, lib, config, ...}: {
      programs.kitty = {
        enable = true;
        settings = {
          shell = lib.mkIf config.programs.fish.enable "fish";
          cursor_trail = "1";
        };
      };

      stylix.targets.kitty.enable = true;
    };
  };
}
