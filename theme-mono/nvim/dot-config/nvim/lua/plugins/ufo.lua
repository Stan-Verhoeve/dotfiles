--[[
  nvim-ufo - Modern fold provider

  Uses LSP + treesitter for accurate semantic folds.

  Usage:
    zc / zo  - close / open fold under cursor
    zM / zR  - close all / open all folds
    zp       - peek inside fold without opening
--]]

return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  init = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldcolumn = "0"
  end,
  config = function()
    require("ufo").setup({
      provider_selector = function(_, filetype, buftype)
        local ignore = { oil = true, help = true, Trouble = true, lazy = true, mason = true }
        if ignore[filetype] or buftype == "nofile" then
          return ""
        end
        -- treesitter is more reliable than LSP for fold ranges;
        -- indent as final fallback ensures folds always exist
        return { "treesitter", "indent" }
      end,
    })
  end,
  keys = {
    { "zR", function() require("ufo").openAllFolds() end,               desc = "Open all folds" },
    { "zM", function() require("ufo").closeAllFolds() end,              desc = "Close all folds" },
    { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
  },
}
