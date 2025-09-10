{
  tmux =
    {
      self,
      config,
      pkgs,
      ...
    }:
    let
      inherit (pkgs) system;
    in
    {
      environment.systemPackages = [
        (self.packages.${system}.tmux.override { colorscheme = config.lib.stylix.colors; })
      ];
    };
}
