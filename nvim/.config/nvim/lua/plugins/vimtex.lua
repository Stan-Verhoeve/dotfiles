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
        vim.keymap.set("i", "]]", "<CR><plug>(vimtex-delim-close)<esc>O", { buffer = true })
      end,
    })
  end,
}
