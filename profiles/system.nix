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
        tlp # Minecraft runs horribly with this on wtf??
      ];
    };
}
