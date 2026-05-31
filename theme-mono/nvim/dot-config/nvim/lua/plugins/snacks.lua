return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile       = { enabled = true },
    dashboard     = { enabled = true },
    explorer      = { enabled = false },
    indent        = { enabled = true },
    input         = { enabled = true },
    picker        = {
      enabled = true,
      confirm = function(picker, item)
        if not item then return end
        local path = item.file
        if not path then
          -- Non-file item (keymaps, pickers list, etc.): default behaviour
          return Snacks.picker.actions.jump(picker, item)
        end
        picker:close()
        vim.schedule(function()
          -- If oil is open, focus its window and use :only to close all splits
          -- (including the preview window) before doing a clean edit
          local oil_win
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "oil" then
              oil_win = win
              break
            end
          end
          if oil_win then
            vim.api.nvim_set_current_win(oil_win)
            pcall(vim.cmd, "only")
          end
          vim.cmd("edit " .. vim.fn.fnameescape(path))
          if item.pos then
            pcall(vim.api.nvim_win_set_cursor, 0, { item.pos[1], item.pos[2] })
          end
        end)
      end,
    },
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
