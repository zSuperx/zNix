{
  unify.modules.gnome = {
    nixos = {pkgs, ...}: {
      stylix = {
        targets = {
          gnome.enable = false;
          gtk.enable = false;
          gnome-text-editor.enable = false;
          gtksourceview.enable = false;
        };
      };
      services = {
        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        xserver = {
          # Enable the X11 windowing system.
          enable = true;

          # Configure keymap in X11
          xkb = {
            layout = "us";
            variant = "";
          };
        };
      };
    };
  };
}
