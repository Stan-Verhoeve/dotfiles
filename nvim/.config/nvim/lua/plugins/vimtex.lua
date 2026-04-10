return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
  end,
  config = function()
    vim.g.vimtex_syntax_enabled = 0
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.keymap.set("i", "]]", function()
          local col = vim.fn.col(".")
          local next_char = vim.fn.getline("."):sub(col, col)
          if next_char == "}" then
            return "<Right><CR><plug>(vimtex-delim-close)<esc>O"
          else
            return "<CR><plug>(vimtex-delim-close)<esc>O"
          end
        end, { buffer = true, expr = true })
      end,
    })
  end,
}
