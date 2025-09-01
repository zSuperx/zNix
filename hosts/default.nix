args:
let
  finalArgs = args // {
    userInfo = import ./userInfo.nix;
  };
in
{
  gzero = import ./gzero finalArgs;
}
