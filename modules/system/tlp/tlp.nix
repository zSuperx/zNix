{
  tlp =
    { lib, ... }:
    {
      services.power-profiles-daemon.enable = lib.mkForce false;
      services.tlp = {
        enable = true;
        extraConfig = builtins.readFile ./tlp.conf;
      };
    };
}
