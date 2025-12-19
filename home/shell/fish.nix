{
  programs.fish = {
    enable = true;

    shellAliases = {
      # Remaps to modern versions
      ls = "eza";
      l = "eza -alh";
      grep = "rg --color=auto";
      cat = "bat --paging=never";

      # Useful shorthands
      wlc = "wl-copy";
      wlp = "wl-paste";
      gs = "git status";
      gc = "git commit -m";
      ga = "git add";
      ww = "wonderwall";
      nv = "nvim";

      clera = "clear"; # Yes, I'm that bad at typing

      # Actual shortcuts
      y = "cd $(yazi --cwd-file=/dev/stdout)";
    };

    interactiveShellInit = ''
      set fish_greeting
      nitch
      if test -f ~/todo.md
        echo
        echo === YOUR TODO ===
        echo
        cat ~/todo.md
      end
    '';
  };
}
