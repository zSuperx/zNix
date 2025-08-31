{
  profiles.basic =
    { self, ... }:
    {
      imports = with self.nixosModules; [
        vesktop
        apps
      ];
    };
}
