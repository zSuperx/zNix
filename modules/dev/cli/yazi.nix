{
  unify.modules.yazi = {
    home = {pkgs, ...}: {
      programs.yazi = {
        enable = true;
        keymap = {
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
              on = ["g" "r"];
              run = "shell -- ya emit cd \$(git rev-parse --show-toplevel)";
              desc = "Go to git root";
            }
          ];
        };
      };
    };
  };
}
