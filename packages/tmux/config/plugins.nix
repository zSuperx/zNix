{
  lib,
  writeText,
}:
let
  inherit (lib) types;
  pluginName = p: if types.package.check p then p.pname else p.plugin.pname;
  plugins = [];
in
writeText "plugins.conf" ''
  ${
    (lib.concatMapStringsSep "\n\n" (p: ''
      # ${pluginName p}
      # ---------------------
      ${p.extraConfig or ""}
      run-shell ${if types.package.check p then p.rtp else p.plugin.rtp}
    '') plugins)
  }
''
