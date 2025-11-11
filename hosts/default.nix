args:
let
  finalArgs = args // {
    userInfo = import ./userInfo.nix;
  };
in
{
  zero = import ./zero finalArgs;
}
