{
  services = {
    fonts.fontDir.enable = true;
    programs.nix-ld.enable = true;
    security.rtkit.enable = true;
    services = {
      fprintd.enable = true;
      upower.enable = true;
      tailscale.enable = true;
      printing.enable = true;
      openssh.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      pulseaudio.enable = false;
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    virtualisation.docker.enable = true;
  };
}
