{
  inputs,
  pkgs,
}:
let
  impure-path = "/home/zsuper/zNix/packages/nvim";
in
inputs.mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  initLua = ''
    -- Source the main config
    require('config')

    -- Because I use matugen to dynamically style Neovim, and because such
    -- styling often requires full reloads of certain plugin files, some plugins
    -- will be located in the 'runtime' module, which is loaded once at startup
    -- and also every time Neovim receives `SIGUSR1`
    require('runtime')
  '';

  # This vim script is needed to hint :MarkdownPreview to open each preview in
  # a separate browser window
  initViml = ''
    function OpenMarkdownPreview (url)
      execute "silent ! zen --new-window " . a:url
    endfunction
    let g:mkdp_browserfunc = 'OpenMarkdownPreview'
  '';

  plugins = {
    start = with pkgs.vimPlugins; [
      vim-visual-multi
      neogit
      fzf-lua
      transparent-nvim
      blink-cmp
      noice-nvim
      luasnip
      nvim-lspconfig
      yazi-nvim
      base16-nvim
      lualine-nvim
      nvim-autopairs
      conform-nvim
      markdown-preview-nvim
      typst-preview-nvim
      uv-nvim
      scope-nvim
      colorizer
      dashboard-nvim
      nvim-web-devicons
      gitsigns-nvim
      baleia-nvim
      {
        name = "term-edit.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "zSuperx";
          repo = "term-edit.nvim";
          rev = "174d580359896c8a1d4c18b3017f390686ec1be3";
          hash = "sha256-Pr8JgEbY2bBz0GcXPnm5ccGmMQ6ZGYJIVPcIPA6dQCE=";
        };
      }
      {
        name = "tft-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "zSuperx";
          repo = "tft-nvim";
          rev = "433e2c2e50ec9c47ed67d540a30393aea7309f95";
          hash = "sha256-uvnp9G3AIP66OeuEKjYG6ArbL1te6oPQM9IjRUgS+ZE=";
        };
      }
      {
        name = "fFtT-highlights-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "samiulsami";
          repo = "fFtT-highlights.nvim";
          tag = "v0.1.0";
          hash = "sha256-+g6p0ecDLrAauo9Z8Hfm5Ml6r2SWxB47k/YKqZJW22M=";
        };
      }
    ];
    dev.myconfig = {
      pure = ./.;
      impure = impure-path;
    };
  };

  # Mostly LSPs and formatters, along with a few helper binaries
  extraBinPath = with pkgs; [
    ################# LSPs #####################
    lua-language-server # Lua
    stylua

    rust-analyzer # Rust
    rustfmt

    gcc # C/C++
    ccls

    nil # Nix
    nixd
    nixfmt

    gopls # Go
    go

    pyright # Python
    black
    uv

    marksman # Markdown

    tinymist # Typst

    ############### Other Utilities ############
    yazi # for yazi-nvim
    fzf # for fzf-lua
  ];
}
