{
  inputs,
  pkgs,
  colorscheme,
}:
let
  impure-path = "/home/zsuper/zNix/packages/nvim";
  matugen-path = "/home/zsuper/zNix/matugen_runtime";
in
inputs.mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  initLua = ''
    require('config')
    vim.keymap.set("n", "<leader>r", ":source ${impure-path}/lua/config/init.lua<CR>")


    -- In order to load matugen's saved changes, attempt to load it's file
    local matugen_path = os.getenv("HOME") .. "/.config/nvim/matugen/style.lua"
    dofile(matugen_path)

    -- We must also register an autocmd to listen for matugen updates
    vim.api.nvim_create_autocmd("Signal", {
      pattern = "SIGUSR1",
      callback = function()
        dofile(matugen_path)
      end
    })
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
      guess-indent-nvim
      vim-nix
      markdown-preview-nvim
      uv-nvim
      term-edit-nvim
      typst-preview-nvim
      scope-nvim
      colorizer
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
        name = "select-undo-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "SunnyTamang";
          repo = "select-undo.nvim";
          rev = "d5aa1f0dbef93b7ed4219ef8c7bfae9691264ef7";
          hash = "sha256-DQcUwuHRfpFuab7Gx6vIgOHGI2HJ4WMSvOqMtXnej6U=";
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
