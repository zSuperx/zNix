{
  unify.modules.zellij = {
    home = {
      pkgs,
      config,
      ...
    }: {
      programs.zellij.enable = true;
      home.file.".config/zellij/config.kdl".source = ./zellij-config.kdl;
      stylix.targets.zellij.enable = true;
    };
  };
}
