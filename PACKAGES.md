# Exposed Packages

Along with my system configuration, this flake also exposes customized programs
that I use. 

## Try It Out

If you're curious, you can run most exposed applications out of the box as long
as you have the Nix programming language. For example, to take my personalized
Neovim out for a spin, you can run:

```
$ nix run github:zSuperx/zNix#nvim
```

## Installing

To add this to your NixOS or Home Manager configuration, simply include it in
your environment.systemPackages or equivalent:

```nix
{
  inputs,
  pkgs,
  system,
  ...
}:
{
  environment.systemPackages = [
    inputs.zNix.packages.${system}.nvim
    inputs.zNix.packages.${system}.tmux
  ];
}
```

## Theming

The base packages come with their own preset theme, but these can very easily
be changed with `.override`. This ends up working pretty well with
[Stylix](https://github.com/nix-community/stylix)...

```nix
{
  inputs,
  pkgs,
  system,
  config,
  ...
}:
{
  environment.systemPackages = [
    (inputs.zNix.packages.${system}.nvim.override { colorscheme = config.lib.stylix.colors; })
  ];
}
```

