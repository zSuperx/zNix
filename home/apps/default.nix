{
  self,
  inputs,
  pkgs,
  system,
  ...
}:
let
  spicePkgs = inputs.spicetify.legacyPackages.${system};
in
{
  # TODO: Hopefully uncomment all this when the Lucid theme stabilizes and gets added
  # to spicePkgs
  #
  # imports = [
  #   inputs.spicetify.homeManagerModules.spicetify
  # ];

  # programs.spicetify = {
  #   enable = true;
  #   enabledExtensions = with spicePkgs.extensions; [
  #     adblockify
  #     hidePodcasts
  #     shuffle # shuffle+ (special characters are sanitized out of extension names)
  #   ];
  #   theme = spicePkgs.themes.spicetify-lucid;
  # };

  home.packages =
    with pkgs;
    [
      spotify
      mpv
      glib
      obsidian
      nautilus
      zathura
      rofi
      spotify-player
      thunderbird
      vscode-fhs
      zellij
      obs-studio
      tesseract # For OCR
      matugen
      swaynotificationcenter
      waybar
      bluetui
      blueman
      netsurf-browser

      # Third party binaries
      inputs.zen-browser.packages.${system}.default
      inputs.wlctl.packages.${system}.default
    ];


  programs.vesktop = {
    enable = true;
    vencord.settings = {
      enabledThemes = [ "matugen.css" ];
      transparent = true;
    };
  };

  home.file = {
    matugen = {
      source = ./matugen;
      target = ".config/matugen/";
    };

    hypridle = {
      source = ./hypr/hypridle.conf;
      target = ".config/hypr/hypridle.conf";
    };

    hyprlock = {
      source = ./hypr/hyprlock.conf;
      target = ".config/hypr/hyprlock.conf";
    };

    niri = {
      source = ./niri/config.kdl;
      target = ".config/niri/config.kdl";
    };

    waybar = {
      source = ./waybar/config.jsonc;
      target = ".config/waybar/config.jsonc";
    };

    swaync = {
      source = ./swaync/config.json;
      target = ".config/swaync/config.json";
    };

    rofi-default = {
      source = ./rofi/config.rasi;
      target = ".config/rofi/config.rasi";
    };

    rofi-wallpaper = {
      source = ./rofi/wallpaper-grid.rasi;
      target = ".config/rofi/wallpaper-grid.rasi";
    };

    # TODO: Nixifying this config file results in a store symlink, which makes
    # `touch ~/.config/zellij/config.kdl` fail with permission errors. This
    # matters because this is how matugen triggers Zellij to reload its theme
    #
    # "zellij" = {
    #   source = ./zellij/config.kdl;
    #   target = ".config/zellij/config.kdl";
    # };
  };
}
