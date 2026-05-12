--[[
  LazyDev - Lua Development

  Provides type checking and autocompletion for Neovim Lua config.
  Enabled automatically when editing Lua files in ~/.config/nvim.
--]]

return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}