{
  home-manager =
    {
      self,
      inputs,
      config,
      lib,
      userInfo,
      ...
    }:
    let
      inherit (lib) mkAliasOptionModule;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        (mkAliasOptionModule [ "hm" ] [ "home-manager" "users" userInfo.username ])
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit self inputs; };
      };

      hm = {
        programs.home-manager.enable = true;
        home = {
          stateVersion = config.system.stateVersion;
          sessionVariables = {
            EDITOR = userInfo.editor;
          };
        };
      };
    };
}
