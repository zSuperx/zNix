{ pkgs }:
{
  term-edit-nvim = {
    name = "term-edit.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "zSuperx";
      repo = "term-edit.nvim";
      rev = "174d580359896c8a1d4c18b3017f390686ec1be3";
      hash = "sha256-Pr8JgEbY2bBz0GcXPnm5ccGmMQ6ZGYJIVPcIPA6dQCE=";
    };
  };
  tft-nvim = {
    name = "tft-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "zSuperx";
      repo = "tft-nvim";
      rev = "433e2c2e50ec9c47ed67d540a30393aea7309f95";
      hash = "sha256-uvnp9G3AIP66OeuEKjYG6ArbL1te6oPQM9IjRUgS+ZE=";
    };
  };
  fFtT-highlights-nvim = {
    name = "fFtT-highlights-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "samiulsami";
      repo = "fFtT-highlights.nvim";
      tag = "v0.1.0";
      hash = "sha256-+g6p0ecDLrAauo9Z8Hfm5Ml6r2SWxB47k/YKqZJW22M=";
    };
  };
  lsp-timeout-nvim = {
    name = "lsp-timeout-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "zSuperx";
      repo = "lsp-timeout.nvim";
      rev = "59dc5f1b491bf7d45b5b76d9b5993c55a905d386";
      hash = "sha256-oddg6EvI2x4Qk8KC2OntMIt5aYh/3vKmWAeCcI5LrCI=";
    };
  };
}
