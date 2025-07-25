{
  # Application-specific Keybinds
  # i.e. launching programs, interacting with media players, etc...

  programs.niri.settings.binds = {
    "Mod+Return" = {
      action.spawn = ["kitty"];
      # hotkey-overlay-title = "Open a Terminal: kitty";
    };
    "Mod+E" = {
      action.spawn = ["kitty" "yazi"];
      # hotkey-overlay-title = "File Manager: kitty";
    };
    "Mod+R" = {
      action.spawn = ["bash" "-c" "pgrep wofi || wofi"];
      # hotkey-overlay-title = "Run an Application: wofi";
    };
    "Mod+B" = {
      action.spawn = ["firefox"];
      # hotkey-overlay-title = "Run an Application: Browser";
    };

    "Mod+N" = {
      action.spawn = ["playerctl" "next"];
      allow-when-locked = true;
      # hotkey-overlay-title = "Spotify: Next";
    };
    "Mod+Shift+N" = {
      action.spawn = ["playerctl" "previous"];
      allow-when-locked = true;
      # hotkey-overlay-title = "Spotify: Prev";
    };
    "Mod+Space" = {
      action.spawn = ["playerctl" "play-pause"];
      allow-when-locked = true;
      # hotkey-overlay-title = "Spotify: Toggle";
    };
  };
}
