{
  inputs,
  pkgs,
  system,
  ...
}:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "yy";
    keymap = {
      tasks.prepend_keymap = [
        {
          on = "i";
          run = "inspect";
        }
      ];
      mgr.prepend_keymap = [
        {
          on = ";";
          run = "shell --interactive --block";
          desc = "Run and block";
        }
        {
          on = ":";
          run = "shell --interactive --orphan";
          desc = "Run and orphan";
        }
        {
          on = "<Space>";
          run = "toggle";
          desc = "Toggle select";
        }
        {
          on = [
            "g"
            "p"
          ];
          run = "cd ~/Pictures";
          desc = "Go to ~/Pictures";
        }
        {
          on = [
            "g"
            "s"
          ];
          run = "cd ~/School/Current";
          desc = "Go to ~/School/Current";
        }
        {
          on = [
            "g"
            "r"
          ];
          run = "shell -- ya emit cd \$(git rev-parse --show-toplevel)";
          desc = "Go to git root";
        }

        # yacd
        {
          on = [
            "g"
            "v"
          ];
          run = "plugin yacd clipboard";
          desc = "Go to clipboard";
        }
        {
          on = [ "'" ];
          run = "plugin yacd goto_mark";
          desc = "Go to mark";
        }
        {
          on = [ "m" ];
          run = "plugin yacd set_mark";
          desc = "Set mark";
        }
      ];
    };

    plugins = {
      # https://github.com/zSuperx/yacd.yazi
      yacd = pkgs.fetchFromGitHub {
        owner = "zSuperx";
        repo = "yacd.yazi";
        rev = "ecba62e1c478e7daba434b7157cce344e99b25da";
        hash = "sha256-CFzzhR2ODkODeO0OUks4N7LO/mgY4AogB864L4c92RA=";
      };
    };
    initLua = ''
      require("yacd").setup()
    '';
  };
}
