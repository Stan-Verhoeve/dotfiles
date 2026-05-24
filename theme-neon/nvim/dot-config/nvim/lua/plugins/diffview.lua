--[[
  Diffview - Git Diff & History Viewer

  Full-screen diff viewer and file history browser powered by git.

  Usage:
    :DiffviewOpen           - open diff against HEAD (or uncommitted changes)
    :DiffviewOpen HEAD~1    - diff against a specific ref
    :DiffviewFileHistory %  - history for the current file
    :DiffviewFileHistory    - history for the whole repo
    :DiffviewClose          - close the view

  Inside diffview, <tab>/<s-tab> cycle through changed files.
  Use standard nvim motions to navigate diffs.
--]]

return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "[G]it [D]iff (working tree)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it file [H]istory" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "[G]it repo [H]istory" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "[G]it diff [C]lose" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff2_horizontal",
      },
    },
  },
}
