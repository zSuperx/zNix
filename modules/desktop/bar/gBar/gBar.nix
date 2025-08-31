{
  gBar = {
    hm =
      { inputs, pkgs, ... }:
      {
        imports = [
          inputs.gBar.homeManagerModules.x86_64-linux.default
        ];

        home.packages = with pkgs; [
          pamixer
        ];

        programs.gBar = {
          enable = true;
          config = {
            Location = "T";
            EnableSNI = true;
            SNIIconSize = {
              Discord = 26;
            };
            WorkspaceSymbols = [
              ""
              ""
            ];
            NumWorkspaces = 10;
            BatteryFolder = "/sys/class/power_supply/BAT0";

            SuspendCommand = "systemctl suspend";
            ExitCommand = "niri msg quit";
            LockCommand = "hyprlock";
          };

          extraSCSS = builtins.readFile ./gBar-style.scss;
        };
      };
  };
}
