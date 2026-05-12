--[[
  Colorscheme - Tokyo Night

  A dark theme for Neovim.
  To change: vim.cmd.colorscheme 'tokyonight-night'
             or 'tokyonight-storm', 'tokyonight-moon', 'tokyonight-day'
--]]

return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      styles = {
        comments = { italic = false },
      },
    })
    -- Uncomment to load the colorscheme (or load manually with :colorscheme)
    -- vim.cmd.colorscheme 'tokyonight-night'
  end,
}