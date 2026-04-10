return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    preview = {
      modes = { "n", "c" },
      hybrid_modes = { "n" },
      debounce = 100,
    },
  },
  config = function(_, opts)
    require("markview").setup(opts)
    vim.keymap.set("n", "<leader>tm", "<cmd>Markview toggle<cr>", { desc = "Toggle Markview" })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        vim.cmd("Markview attach")
      end,
    })
  end,
}
