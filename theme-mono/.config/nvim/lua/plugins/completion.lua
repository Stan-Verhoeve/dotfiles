--[[
  Autocompletion

  Blink.cmp - Modern completion plugin
  LuaSnip - Snippet engine

  Usage: Start typing to see completions, Tab to accept
--]]

return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "VimEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- 'rafamadriz/friendly-snippets',
        },
        opts = {},
      },
      "folke/lazydev.nvim",
      "krissen/blink-cmp-bibtex", -- [1] Added dependency
    },
    opts = {
      keymap = {
        preset = "default",
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = function(ctx)                     -- [2] Changed from table to function
          local list = { "lsp", "path", "snippets", "lazydev" }
          table.insert(list, "bibtex")
          return list
        end,
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
          bibtex = {                                -- [3] Added provider
            module = "blink-cmp-bibtex",
            name = "BibTeX",
            min_keyword_length = 2,
            score_offset = 10,
            async = true,
            opts = {},
          },
        },
      },
      snippets = { preset = "luasnip" },
      fuzzy = { implementation = "lua" },
      signature = { enabled = false },
    },
  },
}
