{
  profiles.dev =
    { self, ... }:
    {
      imports = with self.nixosModules; [
        cli
        fish
        nvim
        kitty
        wezterm
        languages
        tmux
        zellij
      ];
    };
}
