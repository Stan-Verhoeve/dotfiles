--[[
  Search keymaps via Snacks.picker

  Extends the snacks.nvim spec with search keymaps.
  telescope.nvim has been removed in favour of snacks.picker.
--]]

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>sh",       function() Snacks.picker.help() end,                                    desc = "[S]earch [H]elp" },
    { "<leader>sk",       function() Snacks.picker.keymaps() end,                                 desc = "[S]earch [K]eymaps" },
    { "<leader>sf",       function() Snacks.picker.files() end,                                   desc = "[S]earch [F]iles" },
    { "<leader>ss",       function() Snacks.picker.pickers() end,                                 desc = "[S]earch [S]elect Picker" },
    { "<leader>sw",       function() Snacks.picker.grep_word() end,                               desc = "[S]earch current [W]ord" },
    { "<leader>sg",       function() Snacks.picker.grep() end,                                    desc = "[S]earch by [G]rep" },
    { "<leader>sd",       function() Snacks.picker.diagnostics() end,                             desc = "[S]earch [D]iagnostics" },
    { "<leader>sr",       function() Snacks.picker.resume() end,                                  desc = "[S]earch [R]esume" },
    { "<leader>s.",       function() Snacks.picker.recent() end,                                  desc = "[S]earch Recent Files" },
    { "<leader><leader>", function() Snacks.picker.buffers() end,                                 desc = "[ ] Find existing buffers" },
    { "<leader>/",        function() Snacks.picker.lines() end,                                   desc = "[/] Fuzzily search in current buffer" },
    { "<leader>s/",       function() Snacks.picker.grep({ open_files = true }) end,               desc = "[S]earch [/] in Open Files" },
    { "<leader>sn",       function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },
  },
}
