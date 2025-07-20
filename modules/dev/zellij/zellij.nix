{
  unify.modules.zellij = {
    home = {
      pkgs,
      config,
      ...
    }: {
      programs.zellij.enable = true;
      home.file.".config/zellij/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "/home/zsuper/dotfiles/modules/dev/zellij/zellij-config.kdl";
      stylix.targets.zellij.enable = true;
    };
  };
}
