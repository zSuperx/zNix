{ self, inputs, ... }:
let
  inherit (inputs.nixpkgs.lib)
    hasInfix
    hasSuffix
    recursiveUpdate
    concatMap
    mkAliasOptionModule
    ;
  inherit (inputs.nixpkgs.lib.fileset) toList;
in
{
  # Recursively imports all `.nix` files from the given root paths
  # Ignores paths whose components begin with `_`
  recursiveImport =
    roots:
    let
      module-paths = builtins.filter (path: (!hasInfix "/_" (toString path) && hasSuffix ".nix" path)) (
        concatMap (root: toList root) roots
      );
    in
    builtins.foldl' (acc: path: recursiveUpdate acc (import path)) { } module-paths;

  # Builds a system
  mkSystem =
    {
      username,
      hostname ? "nixos",
      system,
      modules,
      stateVersion ? "25.05",
      insanelySpecialArgs ? { },
    }@args:
    let
      insanelySpecialArgs = {
        inherit self inputs;
        scripts = self.lib.scripts inputs.nixpkgs.legacyPackages.${system};
        info = {
          inherit
            username
            hostname
            system
            stateVersion
            ;
        };
      } // args.insanelySpecialArgs;
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.home-manager.nixosModules.home-manager
        (mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = insanelySpecialArgs;
          hm.programs.home-manager.enable = true;
          hm.home.stateVersion = stateVersion;
          system.stateVersion = stateVersion;
        }

      ]
      ++ modules;
      specialArgs = insanelySpecialArgs;
    };
}
