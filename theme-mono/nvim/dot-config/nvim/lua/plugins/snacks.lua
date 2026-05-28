return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile       = { enabled = true },
    dashboard     = { enabled = true },
    explorer      = { enabled = true },
    indent        = { enabled = true },
    input         = { enabled = true },
    picker        = { enabled = true },
    notifier      = { enabled = true },
    quickfile     = { enabled = true },
    scope         = { enabled = true },
    scroll        = { enabled = true },
    statuscolumn  = { enabled = true },
    words         = { enabled = false },
  },
  keys = {
    { "<leader>n",  nil,                                           desc = "[N]otifications" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "[N]otification [H]istory" },
  },
}
