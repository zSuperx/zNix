-- As described in the package's `default.nix`, this file sets up an auxiliary function
-- that is run once at the start (from config/init.lua), and also upon every `SIGUSR1`

-- Helper function to open a file and source it if it exists. This should prevent exception slop
local function source(path)
  local file, err = io.open(path, "r")
  -- If the matugen file does not exist (yet or at all), we must initialize a color scheme ourselves
  if err ~= nil then
    -- Some placeholder theme, this will be overwritten once matugen kicks in
    vim.cmd('colorscheme base16-catppuccin-mocha')
    vim.print("WARNING:")
    vim.print("A matugen style file was not found, but that's okay! The colorscheme will dynamically change if matugen runs!")
  else
    dofile(path)
    io.close(file)
  end
end


-- Main entrypoint on matugen reloads
local function auxiliary_function()
  -- Load the matugen style file to get all the new colors
  local matugen_path = os.getenv("HOME") .. "/.config/nvim/matugen.lua"
  source(matugen_path)

  -- Because reloading base16 overwrites lualine configuration, just source lualine here
  package.loaded['runtime.plugins.lualine-nvim'] = nil -- This is some cursed lua shit right here, but hey if it works...
  require('runtime.plugins.lualine-nvim')
end

-- Register an autocmd to listen for matugen updates
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = auxiliary_function,
})

auxiliary_function()
