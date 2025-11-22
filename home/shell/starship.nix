{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = builtins.fromTOML ''
      [gcloud]
      disabled = true
    '';
  };
}
