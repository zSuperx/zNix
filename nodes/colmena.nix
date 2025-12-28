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
          "bore-minecraft.secret".keyFile = "/home/zsuper/zNix/.secrets/bore-minecraft.secret";
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
    specialArgs = {
      inherit inputs self;
      inherit (pkgs.stdenv.hostPlatform) system;
    };
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
      targetHost = "zenith";
      allowLocalDeployment = true;
    };
  };
  zealot = {
    deployment = {
      targetHost = "zealot";
      tags = [ "nuc" ];
    };
  };
  zed = {
    deployment = {
      targetHost = "zed";
      tags = [ "nuc" ];
    };
  };
  zodiac = {
    deployment = {
      targetHost = "zodiac";
      tags = [ "nuc" ];
    };
  };
  zoom = {
    deployment = {
      targetHost = "zoom";
      tags = [ "nuc" ];
    };
  };
  zuko = {
    deployment = {
      targetHost = "zuko";
      tags = [ "nuc" ];
    };
  };
}
