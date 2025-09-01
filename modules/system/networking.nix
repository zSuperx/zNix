{
  networking =
    {
      info,
      ...
    }:
    {
      # Enable networking
      networking = {
        hostName = info.hostname;
        networkmanager.enable = true;
        firewall = {
          allowedTCPPorts = [ 22 ];
          allowedUDPPorts = [ ];
          enable = true;
        };
      };
    };
}
