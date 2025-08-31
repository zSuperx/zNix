{
  vesktop = {
    hm = {
      stylix.targets.vesktop.enable = false;

      programs.vesktop = {
        enable = true;
        vencord.themes = {
          system24 = ./system24.theme.css;
        };
      };
    };
  };
}
