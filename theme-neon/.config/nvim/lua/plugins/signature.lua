--[[
  LSP Signature - Function Signature Completion

  Shows function signature while typing.
  Enabled in 11-lsp.lua with LSP attach.
--]]

-- lsp_signature.nvim crashes on Neovim 0.12+ (nil node:range() in treesitter highlighter).
-- Signature help is provided by blink.cmp instead (see completion.lua).
return {
  "ray-x/lsp_signature.nvim",
  enabled = false,
}