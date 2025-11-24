{
  inputs,
  self,
  pkgs,
}:
let
  mkNodes = builtins.mapAttrs (
    nodeName:
    {
      deployment ? { },
      modules ? [ ],
    }:
    {
      deployment = deployment // {
        keys = {
          "tailscale.secret".keyFile = "/home/zsuper/zNix/.secrets/tailscale.secret";
          "hashedPassword.secret".keyFile = "/home/zsuper/zNix/.secrets/hashedPassword.secret";
        };
      };
      networking.hostName = nodeName;
      imports = [
        ./${nodeName}
        ./${nodeName}/hardware-configuration.nix
        ./common.nix
      ]
      ++ modules;
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
  zenith = {
    deployment = {
      targetHost = "thinkpad";
      allowLocalDeployment = true;
    };
    modules = [ inputs.disko.nixosModules.disko ];
  };
  zed = {
    deployment = {
      targetHost = "t1";
    };
    modules = [ inputs.disko.nixosModules.disko ];
  };
  zealot = {
    deployment = {
      targetHost = "t2";
    };
    modules = [ inputs.disko.nixosModules.disko ];
  };
  zodiac = {
    deployment = {
      targetHost = "t3";
    };
    modules = [ inputs.disko.nixosModules.disko ];
  };
  zoom = {
    deployment = {
      targetHost = "t4";
    };
    modules = [ inputs.disko.nixosModules.disko ];
  };
  zuko = {
    deployment = {
      targetHost = "t5";
    };
    modules = [ inputs.disko.nixosModules.disko ];
  };
}
