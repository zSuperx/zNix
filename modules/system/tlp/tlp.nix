{
  tlp =
    { lib, ... }:
    {
      services.power-profiles-daemon.enable = lib.mkForce false;
      services.tlp = {
        enable = false;
        extraConfig = builtins.readFile ./tlp.conf;
      };
    };
}
