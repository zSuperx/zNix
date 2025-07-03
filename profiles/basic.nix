{self, ...}: {
  unify.modules.profile-basic = self.lib.importBoth [
    "vesktop"
    "apps"
  ];
}
