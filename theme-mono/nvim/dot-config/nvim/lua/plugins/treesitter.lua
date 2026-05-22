--[[
  Treesitter - Syntax Highlighting

  Provides better syntax highlighting and indentation.
  Run :TSUpdate to update parsers.
--]]

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main";
  build = ":TSUpdate",
  main = "nvim-treesitter",
  opts = {
    -- ensure_installed = {
    --   "bash",
    --   "c",
    --   "diff",
    --   "html",
    --   "lua",
    --   "luadoc",
    --   "latex",
    --   "markdown",
    --   "markdown_inline",
    --   "query",
    --   "vim",
    --   "vimdoc",
    -- },
    -- auto_install = true,
  },
  init = function()
    local ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "lua",
      "luadoc",
      "latex",
      "markdown",
      "markdown_inline",
      "query",
      "vim",
      "vimdoc",
    }
    local already_installed = require("nvim-treesitter.config").get_installed()
    local parsers_to_install = vim.iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end)
      :totable()
    require("nvim-treesitter").install(parsers_to_install)

    vim.api.nvim_create_autocmd('FileType', { 
      callback = function() 
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start) 
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
      end, 
  })
  end,
}
