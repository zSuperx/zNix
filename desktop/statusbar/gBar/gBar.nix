_: {
  programs.gBar = {
    enable = true;
    config = {
      Location = "T";
      EnableSNI = true;
      SNIIconSize = {
        Discord = 26;
        OBS = 23;
      };
      WorkspaceSymbols = ["" ""];
      NumWorkspaces = 10;
      BatteryFolder = "/sys/class/power_supply/BAT0";

      SuspendCommand = "systemctl suspend";
      ExitCommand = "hyprctl dispatch dpms";
      LockCommand = "hyprlock";
    };

    # extraCSS = builtins.readFile ./style.css;
    extraSCSS = builtins.readFile ./style.scss;
  };
}
