{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./disko.nix
  ];
  virtualisation.docker.enable = true;
  environment.systemPackages = [
    pkgs.yazi
  ]
  ++ (with self.packages.${pkgs.system}; [
    nvim
    tmux
  ]);
}
