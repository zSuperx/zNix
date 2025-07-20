{
  # Workspace-related keybinds
  # Contains most of Niri's base config

  programs.niri.settings.binds = {
    "Mod+Shift+Slash".action.show-hotkey-overlay = {};

    "Mod+O" = {
      action.toggle-overview = {};
      repeat = false;
    };

    "Mod+Q".action.close-window = {};

    "Mod+Left".action.focus-column-left = {};
    "Mod+Down".action.focus-window-down = {};
    "Mod+Up".action.focus-window-up = {};
    "Mod+Right".action.focus-column-right = {};

    "Mod+Shift+Left".action.move-column-left = {};
    "Mod+Shift+Down".action.move-window-down = {};
    "Mod+Shift+Up".action.move-window-up = {};
    "Mod+Shift+Right".action.move-column-right = {};

    "Mod+H".action.focus-column-or-monitor-left = {};
    "Mod+J".action.focus-window-or-workspace-down = {};
    "Mod+K".action.focus-window-or-workspace-up = {};
    "Mod+L".action.focus-column-or-monitor-right = {};

    "Mod+Tab".action.focus-column-right-or-first = {};
    "Mod+Shift+Tab".action.focus-column-left-or-last = {};

    "Mod+Shift+H".action.move-column-left-or-to-monitor-left = {};
    "Mod+Shift+J".action.move-window-down-or-to-workspace-down = {};
    "Mod+Shift+K".action.move-window-up-or-to-workspace-up = {};
    "Mod+Shift+L".action.move-column-right-or-to-monitor-right = {};

    "Mod+Home".action.focus-column-first = {};
    "Mod+End".action.focus-column-last = {};
    "Mod+Ctrl+Home".action.move-column-to-first = {};
    "Mod+Ctrl+End".action.move-column-to-last = {};

    "Mod+Ctrl+Left".action.focus-monitor-left = {};
    "Mod+Ctrl+Down".action.focus-monitor-down = {};
    "Mod+Ctrl+Up".action.focus-monitor-up = {};
    "Mod+Ctrl+Right".action.focus-monitor-right = {};
    "Mod+Ctrl+H".action.focus-monitor-left = {};
    "Mod+Ctrl+J".action.focus-monitor-down = {};
    "Mod+Ctrl+K".action.focus-monitor-up = {};
    "Mod+Ctrl+L".action.focus-monitor-right = {};

    "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
    "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
    "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
    "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
    "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
    "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
    "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
    "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

    "Mod+Page_Down".action.focus-workspace-down = {};
    "Mod+Page_Up".action.focus-workspace-up = {};
    "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
    "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};

    "Mod+Shift+Page_Down".action.move-workspace-down = {};
    "Mod+Shift+Page_Up".action.move-workspace-up = {};
    "Mod+Ctrl+D".action.move-workspace-down = {};
    "Mod+Ctrl+U".action.move-workspace-up = {};

    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;
    "Mod+Ctrl+5".action.move-column-to-workspace = 5;
    "Mod+Ctrl+6".action.move-column-to-workspace = 6;
    "Mod+Ctrl+7".action.move-column-to-workspace = 7;
    "Mod+Ctrl+8".action.move-column-to-workspace = 8;
    "Mod+Ctrl+9".action.move-column-to-workspace = 9;

    "Mod+Comma".action.consume-window-into-column = {};
    "Mod+Period".action.expel-window-from-column = {};

    "Mod+BracketLeft".action.consume-or-expel-window-left = {};
    "Mod+BracketRight".action.consume-or-expel-window-right = {};

    "Mod+F".action.maximize-column = {};
    "Mod+Shift+F".action.fullscreen-window = {};
    "Mod+C".action.center-column = {};

    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";

    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    "Print".action.screenshot = {};
    "Ctrl+Print".action.screenshot-screen = {};
    "Alt+Print".action.screenshot-window = {};

    "Mod+Shift+E".action.quit = {};

    "Mod+V".action.toggle-window-floating = {};
    "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};

    "Mod+W".action.toggle-column-tabbed-display = {};

    "Print".action.screenshot = {};
    "Ctrl+Print".action.screenshot-screen = {};
    "Alt+Print".action.screenshot-window = {};

    "Mod+Shift+E".action.quit = {};
    "Ctrl+Alt+Delete".action.quit = {};

    "Mod+Escape" = {
      action.toggle-keyboard-shortcuts-inhibit = {};
      allow-inhibiting = false;
    };
  };
}
