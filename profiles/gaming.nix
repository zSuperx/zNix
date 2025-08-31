{
  profiles.gaming =
    { self, ... }:
    {
      imports = with self.nixosModules; [
        gaming
      ];
    };
}
