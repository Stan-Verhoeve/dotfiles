--[[
  Plugin Manager Setup (lazy.nvim)

  Bootstraps lazy.nvim and loads all plugin configs from lua/plugins/.
  To add a new plugin, create a file in lua/plugins/ and require it below.
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

-- Load all plugin configs (each plugin in its own file)
require("lazy").setup({
  require("plugins.telescope"),
  require("plugins.lsp"),
  require("plugins.completion"),
  require("plugins.treesitter"),
  require("plugins.gitsigns"),
  require("plugins.whichkey"),
  require("plugins.lazydev"),
  require("plugins.conform"),
  require("plugins.colorscheme"),
  require("plugins.todocomments"),
  require("plugins.mini"),
  require("plugins.guessindent"),
  require("plugins.signature"),
  require("plugins.vimtex"),
  require("plugins.markview"),
  require("plugins.oil"),
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
