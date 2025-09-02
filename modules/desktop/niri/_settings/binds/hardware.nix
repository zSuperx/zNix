{
  # Hardware-specific Keybinds
  # i.e. Mouse scroll wheel, Brightness, Audio buttons

  programs.niri.settings.binds = {
    # Audio buttons
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"];
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
    };

    # Brightness buttons
    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = ["brightnessctl" "-n4800" "--class=backlight" "set" "+5%"];
    };
    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = ["brightnessctl" "-n4800" "--class=backlight" "set" "5%-"];
    };

    # Scroll wheel
    "Mod+WheelScrollDown" = {
      cooldown-ms = 150;
      action.focus-workspace-down = {};
    };
    "Mod+WheelScrollUp" = {
      cooldown-ms = 150;
      action.focus-workspace-up = {};
    };
    "Mod+Ctrl+WheelScrollDown" = {
      cooldown-ms = 150;
      action.move-column-to-workspace-down = {};
    };
    "Mod+Ctrl+WheelScrollUp" = {
      cooldown-ms = 150;
      action.move-column-to-workspace-up = {};
    };

    "Mod+WheelScrollRight".action.focus-column-right = {};
    "Mod+WheelScrollLeft".action.focus-column-left = {};
    "Mod+Ctrl+WheelScrollRight".action.move-column-right = {};
    "Mod+Ctrl+WheelScrollLeft".action.move-column-left = {};

    "Mod+Shift+WheelScrollDown".action.focus-column-right = {};
    "Mod+Shift+WheelScrollUp".action.focus-column-left = {};
    "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = {};
    "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = {};

    # Lock the screen and/or power off monitors
    "Super+Alt+L".action.spawn = ["hyprlock"];
    "Super+Alt+Ctrl+L" = {
      action.spawn = ["sh" "-c" "systemctl suspend & hyprlock & niri msg action power-off-monitors"];
    };
  };
}
