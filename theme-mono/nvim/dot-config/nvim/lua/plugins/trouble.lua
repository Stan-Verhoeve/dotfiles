--[[
  Trouble - Diagnostics & Quickfix Panel

  A pretty list for diagnostics, references, quickfix, and todo-comments.
  Replaces the plain loclist / quickfix workflow with a navigable side panel.

  Usage:
    <leader>xx  - toggle diagnostics (current buffer)
    <leader>xX  - toggle diagnostics (workspace)
    <leader>xt  - toggle todo-comments list
    <leader>xq  - toggle quickfix list
    [d / ]d     - jump to prev/next diagnostic item inside trouble
--]]

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[X] Buffer diagnostics" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>",              desc = "[X] Workspace diagnostics" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                     desc = "[X] Todo list" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "[X] Quickfix list" },
    {
      "[d",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          vim.diagnostic.goto_prev()
        end
      end,
      desc = "Prev diagnostic / Trouble item",
    },
    {
      "]d",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          vim.diagnostic.goto_next()
        end
      end,
      desc = "Next diagnostic / Trouble item",
    },
  },
  opts = {
    modes = {
      diagnostics = { auto_close = true },
    },
  },
}
