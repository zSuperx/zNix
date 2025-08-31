## NixOS Configuration

I have run through my fair share of flake libaries over the past few months
(`flake-parts`, `unify`, `import-tree`), but I'm now proud to say that with the
exception of `base16.nix`, the entire flake structure is dependency-less!

That is to say, any utility function used in this flake (again, with the
exception of `mkSchemeAttrs` from `base16.nix`) can be found within this flake
itself.

### Modules

This flake exposes a **lot** of `nixosModules`. I follow a simple preference:
all modules should be named and unreliant on their place in the file system.
What does this mean?

Unlike a normal `nixosModule`, which takes the form...

```nix
{ pkgs, ... }: {
  # NixOS options go here
}
```

... all imported `.nix` files will instead have the form:

```nix
{
  module-name = 
  { pkgs, ... }: {
    # NixOS options go here
  };
}
```

This form allows me to recursively import all files from a set of root
directories, and every file will be a named NixOS module! And because it is a
recursive import, the `.nix` files for modules can be freely moved or renamed
at any time!

### Profiles

Profiles have one semantic purpose: group regular modules together into a
collection that can all be  imported at once. Syntactically, they are actually
no different than modules, as a typical profile looks like:

```nix
{
  profile-name =
  { self, ... }:
  {
    imports = with self.nixosModules; [
      module1
      module2
      module3
      module4
    ];
  };
}
```

This allows for modules to be as granular as they want while still being able
to connect together like pieces of a puzzle. For example, `niri` relies on
`wayland-utils`, but so does `hyprland`. Thus, it makes sense to define a
`niri` profile that imports the `niri` and `wayland-utils` modules. Similarily,
a `hyprland` profile exists to import `hyprland`, `hyprutils`, and
`wayland-utils`.

### Hosts

Finally, hosts are system configurations that consume modules and profiles. A
helper function (`self.lib.mkSystem`) exists to call `nixpkgs.lib.nixosSystem`
and import prerequisite modules (namely `mkAliasOptionModule [ "hm" ] [
"home-manager" "users" username ]`.

```nix
# hosts/gzero/default.nix
{
  self,
  userInfo,
  ...
}:
self.lib.mkSystem {
  inherit (userInfo) username;
  hostname = "gzero";
  system = "x86_64-linux";
  insanelySpecialArgs = userInfo;
  modules = with self.nixosModules; [
    profiles.basic
    profiles.dev
    profiles.hyprland
    profiles.gaming
    profiles.niri

    wayland-utils
    gBar
    gnome

    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
```
