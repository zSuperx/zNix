{
  unify.modules.zoxide = {
    home = {pkgs, ...}: {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = ["--cmd cd"];
      };
    };
  };
}
