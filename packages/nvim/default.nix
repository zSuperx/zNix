{
  inputs,
  pkgs,
  colorscheme,
}:
let
  otherPlugins = [
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
  ];
  impure-path = "/home/zsuper/zNix/packages/nvim";
  base16-colors = with colorscheme.withHashtag; ''
    base00 = '${base00}',
    base01 = '${base01}',
    base02 = '${base02}',
    base03 = '${base03}',
    base04 = '${base04}',
    base05 = '${base05}',
    base06 = '${base06}',
    base07 = '${base07}',
    base08 = '${base08}',
    base09 = '${base09}',
    base0A = '${base0A}',
    base0B = '${base0B}',
    base0C = '${base0C}',
    base0D = '${base0D}',
    base0E = '${base0E}',
    base0F = '${base0F}',
  '';
in
inputs.mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  initLua = ''
    require('config')
    vim.keymap.set("n", "<leader>r", ":source ${impure-path}/lua/config/init.lua<CR>")

    require('base16-colorscheme').setup({
      ${base16-colors}
    })
  '';
  plugins = {
    start =
      with pkgs.vimPlugins;
      [
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
        guess-indent-nvim
        vim-nix
        markdown-preview-nvim
        colorizer
        uv-nvim
      ]
      ++ otherPlugins;
    dev.myconfig = {
      pure = ./.;
      impure = impure-path;
    };
  };
  # Mostly LSPs and formatters, along with a few helper binaries
  extraBinPath = with pkgs; [
    lua-language-server
    stylua

    rust-analyzer
    rustfmt

    nil
    nixd
    nixfmt

    pyright
    black

    marksman

    yazi # for yazi-nvim
    fzf # for fzf-lua
  ];
}
