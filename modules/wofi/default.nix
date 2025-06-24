{
  lib,
  config,
  ...
}: let
  cfg = config.modules.wofi;
in {
  options.modules.wofi.enable = lib.mkEnableOption "wofi";
  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      style = ./style.css;
      settings = {
        hide_scroll = true;
        show = "drun";
        width = "30%";
        lines = 8;
        line_wrap = "word";
        term = "kitty";
        allow_markup = true;
        always_parse_args = false;
        show_all = true;
        print_command = true;
        layer = "overlay";
        allow_images = true;
        gtk_dark = true;
        prompt = "";
        image_size = 20;
        display_generic = false;
        location = "center";
        key_expand = "Tab";
        insensitive = true;
        matching = "fuzzy";
      };
    };
  };
}
