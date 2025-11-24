{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  services.logind.settings.Login.HandleLidSwitch = "ignore";
  virtualisation.docker.enable = true;
  environment.systemPackages = [
    pkgs.yazi
  ]
  ++ (with self.packages.${pkgs.system}; [
    nvim
    tmux
  ]);
}
