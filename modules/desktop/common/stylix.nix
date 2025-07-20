{inputs, ...}: {
  unify.nixos = {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];
  };
  unify.modules.stylix = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      stylix = {
        enable = true;
        autoEnable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
        opacity.terminal = 0.9;
        fonts.sizes.terminal = 11;
        fonts.monospace = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
        polarity = "dark";
      };
    };
  };
}
