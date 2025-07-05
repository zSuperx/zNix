{self, ...}: {
  unify.modules.profile-hyprland = self.lib.importBoth [
    "hyprland"
    "hypr-util"
  ];
}
