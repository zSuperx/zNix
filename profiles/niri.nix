{
  profiles.niri =
    { self, ... }:
    {
      imports = with self.nixosModules; [
        niri
        waybar
        rofi
      ];
    };
}
