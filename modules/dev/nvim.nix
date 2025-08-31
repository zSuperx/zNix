{
  nvim =
    {
      self,
      config,
      info,
      ...
    }:
    {
      environment.systemPackages = [
        (self.packages.${info.system}.nvim.override { colorscheme = config.lib.stylix.colors; })
      ];
    };
}
