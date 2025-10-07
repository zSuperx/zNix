{
  nvim =
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
        self.packages.${system}.nvim
      ];
    };
}
