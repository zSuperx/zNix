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
  };
}
