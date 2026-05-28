--[[
  Gitsigns - Git Integration

  Shows git status in the sign column and provides hunk operations.

  Keymaps (when in git repo):
    ]c / [c          - next / previous hunk
    <leader>hs       - stage hunk
    <leader>hu       - undo stage hunk
    <leader>hr       - reset hunk
    <leader>hR       - reset buffer
    <leader>hp       - preview hunk
    <leader>hb       - blame line
    <leader>hd       - diff against index
--]]

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Git: " .. desc })
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next hunk")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev hunk")

      -- Hunk operations
      map("n", "<leader>hs", gs.stage_hunk,           "[H]unk [S]tage")
      map("n", "<leader>hu", gs.undo_stage_hunk,      "[H]unk [U]ndo stage")
      map("n", "<leader>hr", gs.reset_hunk,           "[H]unk [R]eset")
      map("n", "<leader>hR", gs.reset_buffer,         "[H]unk [R]eset buffer")
      map("n", "<leader>hp", gs.preview_hunk,         "[H]unk [P]review")
      map("n", "<leader>hb", gs.blame_line,           "[H]unk [B]lame line")
      map("n", "<leader>hd", gs.diffthis,             "[H]unk [D]iff index")

      -- Visual mode: stage/reset selected lines
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "[H]unk [S]tage selection")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "[H]unk [R]eset selection")
    end,
  },
}
