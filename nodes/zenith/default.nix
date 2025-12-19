{
  self,
  pkgs,
  system,
  inputs,
  ...
}:
{
  imports = [
    ./disko.nix
    inputs.server-modules.nixosModules.reverse-proxy
    inputs.server-modules.nixosModules.minecraft-servers
  ];

  services.logind.settings.Login.HandleLidSwitch = "ignore";
  virtualisation.docker.enable = true;
  environment.systemPackages = [
    pkgs.yazi
  ]
  ++ (with self.packages.${system}; [
    # nvim
    tmux
  ]);
}
