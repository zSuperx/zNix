{
  unify.modules.apps = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        spotify
        mpv
        obsidian
      ];

      programs.firefox.enable = true;
    };
  };
}
