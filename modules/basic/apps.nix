{
  unify.modules.apps = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        spotify
        mpv
        obsidian
      ];
    };

    home = {
      programs.firefox = {
        enable = true;
      };
      stylix.targets.firefox = {
        enable = false;
        colorTheme.enable = true;
        profileNames = [
          "main"
          "work"
        ];
      };
    };
  };
}
