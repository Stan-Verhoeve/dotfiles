--[[
  Plugin Manager Setup (lazy.nvim)

  This file sets up lazy.nvim and defines all plugins.
  To add a new plugin, create a new file in lua/plugins/ and add it here.
--]]

-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

-- Add lazy.nvim to runtime path
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Load all plugin files from this directory
-- The numbers (01-, 02-, etc.) determine load order
require("lazy").setup({
  -- Individual plugin configs (each in its own file)
  require("plugins.10-telescope"),
  require("plugins.11-lsp"),
  require("plugins.12-completion"),
  require("plugins.13-treesitter"),
  require("plugins.14-gitsigns"),
  require("plugins.15-whichkey"),
  require("plugins.16-lazydev"),
  require("plugins.17-conform"),
  require("plugins.18-colorscheme"),
  require("plugins.19-todocomments"),
  require("plugins.20-mini"),
  require("plugins.21-guessindent"),
  require("plugins.22-signature"),
  require("plugins.23-vimtex"),
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
