{
  zellij = {
    hm = {
      programs.zellij.enable = true;
      home.file.".config/zellij/config.kdl".source = ./zellij-config.kdl;
      stylix.targets.zellij.enable = true;
    };
  };
}
