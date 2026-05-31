--[[
  Keymaps

  All custom keybindings.
--]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut
-- (normally you need to press <C-\><C-n>)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode (forces using h,j,k,l)
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Run current file in a terminal split
local ft_runners = {
  python = "python3",
  lua = "lua",
  sh = "bash",
  bash = "bash",
  javascript = "node",
  typescript = "ts-node",
  ruby = "ruby",
  perl = "perl",
}
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("write")
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local dir  = vim.fn.expand("%:p:h")
  local runner = ft_runners[ft]
  local cmd = runner
    and ("split | term cd " .. vim.fn.shellescape(dir) .. " && " .. runner .. " " .. vim.fn.shellescape(file))
    or  ("split | term cd " .. vim.fn.shellescape(dir) .. " && ./" .. vim.fn.shellescape(file))
  vim.cmd(cmd)
end, { desc = "[R]un current file" })

-- Exit terminal and move to another window with Ctrl + h/j/k/l
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move focus to the right window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move focus to the upper window" })

--[[
  NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes.
  If you need to move windows, uncomment these:
  vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--]]