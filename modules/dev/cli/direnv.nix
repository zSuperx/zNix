{
  unify.modules.direnv = {
    home = {pkgs, ...}: {
      programs.direnv = {
        enable = true;
        nix-direnv = true;
      };

      home.file.".config/direnv/direnv.toml".source =
        builtins.toFile "direnv.toml"
        ''
          [global]
          log_filter = "^$"
        '';
    };
  };
}
