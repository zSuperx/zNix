{
  programs.fish = {
    enable = true;

    shellAliases = {

      # Useful shorthands
      wlc = "wl-copy";
      wlp = "wl-paste";
      gs = "git status";
      gc = "git commit -m";
      ga = "git add";
      ls = "eza";
      l = "eza -alh";

      # Neovim redirects
      vim = "nvim";
      vi = "nvim";

      clera = "clear"; # Yes, I'm that bad at typing
    };

    interactiveShellInit = ''
      set fish_greeting
      nitch
    '';
  };
}
