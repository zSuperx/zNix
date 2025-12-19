{
  inputs,
  self,
  pkgs,
}:
let
  mkNodes = builtins.mapAttrs (
    name: value: {
      deployment = value.deployment;
      networking.hostName = name;
      imports = [
        ./${name}
        ./common.nix
      ];
    }
  );
in
{
  meta = {
    nixpkgs = pkgs;
    specialArgs = { inherit inputs self; };
  };
}
// mkNodes {
  zero = {
    deployment = {
      targetHost = null;
      allowLocalDeployment = true;
    };
  };
}
