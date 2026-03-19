--[[
  LSP Signature - Function Signature Completion

  Shows function signature while typing.
  Enabled in 11-lsp.lua with LSP attach.
--]]

return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  opts = {
    bind = true,
    handler_opts = { border = "rounded" },
  },
}