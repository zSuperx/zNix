_: {
  stylix.targets.vesktop.enable = false;

  programs.vesktop = {
    enable = true;
    settings.enabledThemes = ["./system24.theme.css"];
    vencord.themes = {
      system-24 = ./system24.theme.css;
    };
  };
}
