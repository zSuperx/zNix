{inputs, ...}: {
  unify.modules.apps = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        spotify
        mpv
        obsidian
        nautilus
      ];
    };

    home = {pkgs, ...}: {
      imports = [
        inputs.spicetify.homeManagerModules.default
      ];
      programs.spicetify = let
        spicetifyPkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in {
        enable = true;
        enabledExtensions = with spicetifyPkgs.extensions; [
          keyboardShortcut
          popupLyrics
        ];
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
