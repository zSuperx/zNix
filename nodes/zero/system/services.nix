{
  lib,
  ...
}:
{
  services.power-profiles-daemon.enable = true;
  programs.nix-ld.enable = true;
  security.rtkit.enable = true;

  services = {
    upower.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
  };

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  virtualisation.podman.enable = true;
}
