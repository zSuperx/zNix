{
  fish =
    { self, userInfo, ... }:
    {
      programs.fish.enable = true;

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
