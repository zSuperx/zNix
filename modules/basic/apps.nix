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
        zathura
        firefox
        spotify-player
        inputs.zen-browser.packages.${pkgs.system}.default
      ];

      hm = {
        imports = [
          inputs.spicetify.homeManagerModules.default
        ];
        programs.spicetify = {
          enable = true;
        };
      };
    };
}
