--[[
  Mini Plugins - Collection of small independent plugins

  Includes:
  - mini.ai: Better around/inside textobjects (e.g. va), yi", ci', etc.)
  - mini.surround: Add/delete/replace surroundings (brackets, quotes, etc.)
  - mini.statusline: Simple statusline
--]]

return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    -- Examples: va) = visually select around paren, ci' = change inside quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings
    -- Examples: saiw) = add around inner word with parens, sd' = delete quotes
    require("mini.surround").setup()
    require("mini.pairs").setup()
  end,
}