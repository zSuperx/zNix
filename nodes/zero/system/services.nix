{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  fonts.fontDir.enable = true;
  programs.nix-ld.enable = true;
  security.rtkit.enable = true;
  security.pam.services.swaylock = { };
  services = {
    fprintd.enable = true;
    upower.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          main = {
            # Maps capslock to escape on tap, capslock on hold
            capslock = "overload(caps, esc)";
          };
          caps = {
            capslock = "caps";
          };
        };
      };
    };
  };

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  ##### TODO: REMOVE THIS SHIT LATER #############
  # nixpkgs.config.segger-jlink.acceptLicense = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "segger-jlink-qt4-874"
  # ];
  # services.udev.packages = with pkgs; [
  #   nrf-udev
  #   segger-jlink
  #   platformio-core.udev
  # ];
  # environment.systemPackages = with pkgs; [
  #   nrfconnect
  #     segger-jlink
  #     nrf-command-line-tools
  #     nrfutil
  #     cmake
  #     ninja
  # ];
  ################################################

  virtualisation.podman.enable = true;
}
