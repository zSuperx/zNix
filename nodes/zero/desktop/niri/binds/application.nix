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
      action.spawn = ["bash" "-c" "pkill rofi-unwrapped || rofi -show drun -method fuzzy -show-icons"];
    };
    "Mod+B" = {
      action.spawn = ["zen"];
    };
    "Mod+N" = {
      action.spawn = ["playerctl" "next"];
      allow-when-locked = true;
    };
    "Mod+Shift+N" = {
      action.spawn = ["playerctl" "previous"];
      allow-when-locked = true;
    };
    "Mod+Space" = {
      action.spawn = ["playerctl" "play-pause"];
      allow-when-locked = true;
    };
  };
}
