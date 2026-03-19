--[[
  Nvim Configuration Entry Point

  This file sets up the plugin manager and loads all modules.
  Modular structure:
    - lua/core/options.lua    : Vim options
    - lua/core/keymaps.lua    : Keybindings
    - lua/core/autocmds.lua   : Autocommands
    - lua/plugins/            : Plugin configurations (one file per plugin)

  See lua/plugins/lazy.lua to add new plugins.
--]]

-- Set <space> as the leader key (must happen before plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- IMPORTANT: Change this to true if you use a Nerd Font!
vim.g.have_nerd_font = true

-- Disable default LSP signature handler (we use a plugin instead)
vim.lsp.handlers["textDocument/signatureHelp"] = nil

-- Load core options
require("core.options")

-- Load keymaps and autocommands
require("core.keymaps")
require("core.autocmds")

-- Set up terminal colors for theme
vim.o.termguicolors = true
vim.cmd([[
  hi Normal guibg=NONE guifg=NONE
  hi LineNr guibg=NONE guifg=gray
  hi StatusLine guibg=NONE guifg=white
]])

-- Load lazy.nvim plugin manager and all plugins
require("plugins.lazy")

