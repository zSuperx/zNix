{
  self,
  inputs,
  lib,
  system,
  ...
}:
{
  imports = [
    ./system
    ./gaming
    ./desktop
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit self inputs system; };
    users.zsuper = {
      imports = [ self.homeModules.zsuper ];
      nixpkgs.config = lib.mkForce null; # Force disable nixpkgs configuration if using as nixosModule
    };
  };
}
