{
  unify.modules.apps = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        spotify
        mpv
        obsidian
        nautilus
      ];
    };

    home = {
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
