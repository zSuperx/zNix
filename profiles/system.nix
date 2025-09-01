{
  profiles.system =
    { self, ... }:
    {
      imports = with self.nixosModules; [
        boot
        networking
        nixos
        services
        timezone
      ];
    };
}
