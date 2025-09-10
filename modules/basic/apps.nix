{
  apps =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        spotify
        mpv
        obsidian
        nautilus
        blueman
      ];

      hm = {
        imports = [
          inputs.spicetify.homeManagerModules.default
        ];
        programs.spicetify = {
          enable = true;
        };

        programs.firefox = {
          enable = true;
        };

        stylix.targets.firefox = {
          enable = true;
          colorTheme.enable = true;
        };
      };
    };
}
