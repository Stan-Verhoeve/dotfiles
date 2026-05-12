--[[
  Clipboard
  Uses OSC52 to sync clipboard over SSH to local machine.
  Falls back to system clipboard when not on SSH.
  Note: paste from local -> cluster via ctrl+shift+v in terminal.
--]]
if vim.env.SSH_CONNECTION ~= nil then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = { "false" },
      ["*"] = { "false" },
    },
  }
end
