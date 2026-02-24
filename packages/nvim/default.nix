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
    require('config')

    -- Because I use matugen to dynamically style Neovim, and because such
    -- styling often requires full reloads of certain plugin files, some plugins
    -- will be located in the 'runtime' module, which is loaded once at startup
    -- and also every time Neovim receives `SIGUSR1`

    require('runtime')

    -- This is kind of a useless keybind lol, but it's sometimes used in #devMode
    vim.keymap.set("n", "<leader>r", ":source ${impure-path}/lua/config/init.lua<CR>")
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
      luasnip
      nvim-lspconfig
      yazi-nvim
      base16-nvim
      lualine-nvim
      nvim-autopairs
      bufferline-nvim
      conform-nvim
      markdown-preview-nvim
      uv-nvim
      term-edit-nvim
      typst-preview-nvim
      scope-nvim
      colorizer
      dashboard-nvim
      nvim-web-devicons
      gitsigns-nvim
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
        name = "project-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "DrKJeff16";
          repo = "project.nvim";
          rev = "61afe931e5e445a55b0845e18b261778dfbf08a3";
          hash = "sha256-kWFAU6a1ERy9kP+s5bom7AM9xKWfmgqGbY0dvkcTBUM=";
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
    lua-language-server     # Lua
    stylua

    rust-analyzer           # Rust
    rustfmt

    gcc                     # C/C++
    ccls

    nil                     # Nix
    nixd
    nixfmt

    gopls                   # Go
    go

    pyright                 # Python
    black
    uv
    
    marksman                # Markdown

    tinymist                # Typst

    ############### Other Utilities ############
    yazi                 # for yazi-nvim
    fzf                  # for fzf-lua
  ];
}
