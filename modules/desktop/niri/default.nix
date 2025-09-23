{
  niri =
    {
      inputs,
      pkgs,
      lib,
      ...
    }:
    {
      xdg.portal = {
        config.niri.default = [ "gnome" "gtk" ];
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];

      imports = [
        inputs.niri.nixosModules.niri
      ];

      programs.niri.enable = true;

      # Configure Niri through Home Manager
      hm = {
        # All Niri config is stored in `./_settings`, so just recursively import everything
        imports = (builtins.filter (path: lib.hasSuffix ".nix" path)) (lib.fileset.toList ./_settings);

        stylix.targets.niri.enable = true;
      };
    };
}
