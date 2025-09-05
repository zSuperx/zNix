{
  fish =
    { self, userInfo, lib, ... }:
    {
      programs.fish.enable = true;
      documentation.man.generateCaches = lib.mkForce false;

      imports = [
        self.nixosModules.starship
      ];

      hm = {
        programs.fish = {
          enable = true;

          inherit (userInfo) shellAliases;
          # Disable Fish greeting & add ~/bin to path
          interactiveShellInit = ''
            set fish_greeting
            nitch
          '';
        };
      };

    };
}
