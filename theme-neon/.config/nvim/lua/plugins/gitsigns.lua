--[[
  Gitsigns - Git Integration

  Shows git status in the sign column.
  Keymaps (when in git repo):
    - ]c / [c : next/previous hunk
    - <leader>hs : stage hunk
    - <leader>hu : undo stage
    - <leader>hr : reset hunk
    - <leader>hR : reset buffer
    - <leader>hp : preview hunk
    - <leader>hb : blame line
--]]

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  },
}