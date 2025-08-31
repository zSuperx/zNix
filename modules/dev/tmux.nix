{
  tmux =
    {
      self,
      config,
      info,
      ...
    }:
    {
      environment.systemPackages = [
        (self.packages.${info.system}.tmux.override { colorscheme = config.lib.stylix.colors; })
      ];
    };
}
