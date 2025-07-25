{self, ...}: {
  unify.modules.profile-niri = self.lib.importBoth [
    "niri"
    "waybar"
  ];
}
