--[[
  render-markdown.nvim - In-buffer Markdown Rendering

  Renders markdown visually in normal mode: headings, tables, code blocks,
  checkboxes, callouts, and more. Reverts to plain text in insert mode.

  Also supports rendering markdown cells in Jupyter notebooks (works with Molten).
  Note: inline images are disabled (Alacritty does not support inline image protocols).

  Dependencies: nvim-treesitter with markdown + markdown_inline parsers (already installed).
--]]

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown", "quarto" },
  opts = {
    render_modes = { "n", "c" },
    image = { enabled = false },
  },
}
