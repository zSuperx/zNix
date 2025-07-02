{
  unify.modules.yazi = {
    home = {pkgs, ...}: {
      programs.yazi = {
        enable = true;
        keymap = {
          manager.prepend_keymap = [
            {
              on = ";";
              run = "shell --interactive --block";
              desc = "Run shell in yazi and block until done";
            }
            {
              on = ":";
              run = "shell --interactive --orphan";
              desc = "Run shell and orphan";
            }
            {
              on = "<C-d>";
              run = "shell --block fish";
              desc = "Drop into terminal";
            }
            {
              on = "<Space>";
              run = "toggle";
              desc = "Toggle select on current file";
            }
            {
              on = ["g" "r"];
              run = "shell -- ya emit cd '$(git rev-parse --show-toplevel)'";
              desc = "Go to git repo root";
            }
          ];
        };
      };
    };
  };
}
