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
    ]
    ++ [
      # Third party binaries
      inputs.zen-browser.packages.${system}.default
      inputs.hellpaper.packages.${system}.default
      inputs.wlctl.packages.${system}.default
    ]
    ++ (with self.packages.${system}; [
      # Custom-packaged programs
      nvim
    ]);


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

    rofi = {
      source = ./rofi/config.rasi;
      target = ".config/rofi/config.rasi";
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
