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
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.expandtab = true -- Use spaces instead of tabs
    vim.opt_local.shiftwidth = 4 -- Indent size
    vim.opt_local.softtabstop = 4 -- Tab key inserts 4 spaces
  end,
})

-- Open PDFs in the system default viewer instead of nvim.
-- Guard: skip when the buffer is being loaded in the background (e.g. oil preview),
-- only intercept explicit opens where the PDF buffer is the current buffer.
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function(args)
    if vim.api.nvim_get_current_buf() ~= args.buf then return end
    vim.fn.jobstart({ "xdg-open", args.match }, { detach = true })
    vim.api.nvim_buf_delete(args.buf, { force = true })
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