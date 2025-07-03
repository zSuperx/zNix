{self, ...}: {
  unify.modules.profile-gaming = self.lib.importBoth [
    "gaming"
  ];
}
