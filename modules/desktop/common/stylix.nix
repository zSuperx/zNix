{
  stylix =
    { self, inputs, pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];
      environment.systemPackages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      stylix = {
        enable = true;
        autoEnable = true;
        base16Scheme = "${inputs.base16-schemes}/gruvbox-dark-medium.yaml";
        opacity.terminal = 0.9;
        fonts.sizes.terminal = 11;
        fonts.monospace = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
        polarity = "dark";
      };

      console.font = "JetBrainsMono Nerd Font";
    };
}
