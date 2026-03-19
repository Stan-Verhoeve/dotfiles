--[[
  Autocommands

  Automatic commands that run on specific events.
--]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Use spaces instead of tabs for C/C++ files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.expandtab = true -- Use spaces instead of tabs
    vim.opt_local.shiftwidth = 4 -- Indent size
    vim.opt_local.softtabstop = 4 -- Tab key inserts 4 spaces
  end,
})

-- Use spaces instead of tabs for LaTeX files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true -- use spaces instead of real tabs
  end,
})