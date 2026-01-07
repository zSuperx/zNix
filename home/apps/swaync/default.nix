{
  pkgs,
  lib,
  ...
}:
let
  record-script = pkgs.writeShellApplication {
    name = "record.sh";
    runtimeInputs = with pkgs; [
      swaynotificationcenter
      libnotify
      wf-recorder
      niri
      ripgrep
      slurp
    ];
    bashOptions = [ ];
    text = ''
      # Get the focused output name
      # We store it in a variable first to check if it's empty

      swaync-client -cp
      if pkill -x -SIGINT wf-recorder; then
      notify-send -e "Recording Finished!" "Video saved to /tmp/recording.mp4"
      exit 0
      fi

      FOCUSED_OUTPUT=$(niri msg focused-output | head -n 1 | rg -Po '\((.*)\)' -r '$1')

      if [ -z "$FOCUSED_OUTPUT" ]; then
      notify-send -e "Recording Error" "Could not detect focused output."
      exit 1
      fi

      REGION="$(slurp)"

      if [ -z "$REGION" ]; then
      notify-send "Selection Error" "Region empty or invalid."
      exit 1
      fi

      notify-send -e "Recording Started!" "Click the button again to finish."
      wf-recorder -o "$FOCUSED_OUTPUT" -y -f /tmp/recording.mp4 -g "$REGION"
    '';
  };
in
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      control-center-positionX = "right";
      control-center-positionY = "top";
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-margin-left = 8;
      control-center-width = 400;
      control-center-height = 1040;
      fit-to-screen = false;

      layer = "overlay";
      cssPriority = "user";
      notification-icon-size = 64;
      notification-body-image-height = 64;
      notification-body-image-width = 64;
      timeout = 3;
      timeout-low = 2;
      timeout-critical = 0;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 100;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = [
        "menubar#label"
        "inhibitors"
        "volume"
        "backlight"
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        "menubar#label" = {
          "menu#power-buttons" = {
            label = "󰐦";
            position = "right";
            actions = [
              {
                "label" = "󰌾 Lock Screen";
                "command" = "swaync-client -t -sw && swaylock -f";
              }
              {
                "label" = "󰈆 Log Out";
                "command" = "swaync-client -t -sw && niri msg action quit";
              }
              {
                "label" = "󰒲 Suspend";
                "command" = "swaync-client -t -sw && systemctl suspend";
              }
              {
                "label" = "󰜉 Reboot";
                "command" = "swaync-client -t -sw && reboot";
              }
              {
                "label" = "⏻ Shut down";
                "command" = "swaync-client -t -sw && shutdown now";
              }
            ];
          };
          buttons-grid = {
            actions = [
              {
                label = "󱚾";
                command = "nmgui";
              }
              {
                label = "󰂯";
                command = "blueman-manager";
              }
            ];
          };
          "buttons#topbar-buttons" = {
            position = "right";
            actions = [
              {
                label = "";
                command = "swaync-client -t && niri msg action screenshot";
              }
              {
                label = "󰻃";
                type = "toggle";
                command = "${lib.getExe' record-script "record.sh"}";
                update-command = "sh -c 'pgrep -x wf-recorder && echo true || echo false'";
              }
              {
                label = "󰈊";
                command = "swaync-client -t && notify-send -e -a 'Niri' 'Click a color!' && niri msg pick-color | sed -r 's/(Picked color: |Hex: )//g' | tr '\n' ' ' | tee  >(wl-copy) | xargs -0 -I {} notify-send {} 'copied to clipboard'";
              }
            ];
          };
        };
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb 󰤄";
        };
        mpris = {
          image-size = 96;
          image-radius = 8;
        };
        volume = {
          label = "󰕾";
        };
        backlight = {
          label = "";
          device = "intel_backlight";
        };
      };
    };
  };
}
