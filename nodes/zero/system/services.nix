{
  lib,
  pkgs,
  ...
}:
{
  fonts.fontDir.enable = true;
  programs.nix-ld.enable = true;
  security.rtkit.enable = true;
  security.pam.services.hyprlock.fprintAuth = lib.mkDefault false;
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
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
  environment.systemPackages = [ pkgs.podman-compose ];
}
