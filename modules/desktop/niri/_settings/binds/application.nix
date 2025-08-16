{
  # Application-specific Keybinds
  # i.e. launching programs, interacting with media players, etc...

  programs.niri.settings.binds = {
    "Mod+Return" = {
      action.spawn = ["kitty"];
    };
    "Mod+E" = {
      action.spawn = ["kitty" "yazi"];
    };
    "Mod+Shift+O" = {
      action.spawn = ["bash" "-c" "pkill wofi || wofi"];
    };
    "Mod+B" = {
      action.spawn = ["firefox"];
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
