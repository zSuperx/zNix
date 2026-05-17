{
  inputs,
  pkgs,
}:
let
  impure-path = "/home/zsuper/zNix/packages/nvim";
  extra-plugins = import ./extra-plugins.nix { inherit pkgs; };
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

  initViml = ''
    function OpenMarkdownPreview (url)
      execute "silent ! zen-beta --new-window " . a:url
    endfunction
    let g:mkdp_browserfunc = 'OpenMarkdownPreview'
    let g:omni_sql_default_compl_type = 'syntax'
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
      extra-plugins.tft-nvim
      extra-plugins.fFtT-highlights-nvim
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
