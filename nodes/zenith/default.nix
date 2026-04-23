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
    inputs.fleet-services.nixosModules.reverse-proxy
    inputs.fleet-services.nixosModules.minecraft-servers
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
