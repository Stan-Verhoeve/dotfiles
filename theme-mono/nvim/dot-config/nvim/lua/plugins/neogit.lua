--[[
  Neogit - Git Interface

  Full git workflow from within nvim: stage files/hunks/lines,
  commit, push, pull, and branch management.

  Usage:
    <leader>gg  - open neogit status
    <leader>gp  - push
    <leader>gP  - pull

  In the status buffer:
    <Tab>       - toggle/expand section or hunk
    s / u       - stage / unstage file or hunk
    S / U       - stage / unstage all
    c           - open commit popup
    P           - open push popup
    =           - toggle inline diff for file
--]]

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", function()
        local oil = require("oil")
        local cwd = oil.get_current_dir() or vim.fn.expand("%:p:h")
        require("neogit").open({ cwd = cwd })
      end, desc = "[G]it Neo[g]it" },
    { "<leader>gp", "<cmd>Neogit push<cr>", desc = "[G]it [P]ush" },
    { "<leader>gP", "<cmd>Neogit pull<cr>", desc = "[G]it [P]ull" },
  },
  opts = {
    integrations = {
      diffview = true,
    },
  },
}
