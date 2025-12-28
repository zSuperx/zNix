{
  inputs,
  pkgs,
  system,
  ...
}:
{
  programs.yazi = {
    package = inputs.yazi.packages.${system}.yazi;
    enable = true;
    enableFishIntegration = true;
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
      # yacd = pkgs.fetchFromGitHub {
      #   owner = "zSuperx";
      #   repo = "yacd.yazi";
      #   rev = "";
      #   hash = "";
      # };
    };
    initLua = ''
      require("yacd").setup()
    '';
  };
}
