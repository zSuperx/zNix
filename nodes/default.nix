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
        ./${nodeName}/default.nix
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
    allowApplyAll = false;
    specialArgs = { inherit inputs self; };
  };
}
// mkNodes {
  zero = {
    deployment = {
      targetHost = null;
      allowLocalDeployment = true;
      tags = [ "all" ];
    };
  };
  zenith = {
    deployment = {
      targetHost = "zenith";
      allowLocalDeployment = true;
      tags = [ "all" ];
    };
  };
  zealot = {
    deployment = {
      targetHost = "zealot";
      # targetHost = "10.0.0.51";
      tags = [
        "nuc"
        "all"
      ];
    };
  };
  zed = {
    deployment = {
      targetHost = "zed";
      # targetHost = "10.0.0.52";
      tags = [
        "nuc"
        "all"
      ];
    };
  };
  zodiac = {
    deployment = {
      targetHost = "zodiac";
      # targetHost = "10.0.0.53";
      tags = [
        "nuc"
        "all"
      ];
    };
  };
  zoom = {
    deployment = {
      targetHost = "zoom";
      # targetHost = "10.0.0.54";
      tags = [
        "nuc"
        "all"
      ];
    };
  };
  zuko = {
    deployment = {
      targetHost = "zuko";
      # targetHost = "10.0.0.55";
      tags = [
        "nuc"
        "all"
      ];
    };
  };
}
