return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    view_options = {
      show_hidden = true,
    },
    preview = {
      update_on_cursor_moved = true,
    },
    keymaps = {
      ["<CR>"] = {
        callback = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          if entry and entry.type == "file" and entry.name:match("%.pdf$") then
            local dir = oil.get_current_dir()
            if dir then
              vim.fn.jobstart({ "xdg-open", dir .. entry.name }, { detach = true })
            end
          else
            oil.select()
          end
        end,
        desc = "Open file, or open PDF externally without leaving oil",
      },
    },
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  config = function(_, opts)
    require("oil").setup(opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = vim.schedule_wrap(function(args)
        local oil = require("oil")
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.open_preview()
        end
      end),
    })
  end,
}
