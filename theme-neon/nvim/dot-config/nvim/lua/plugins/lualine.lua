-- Custom component: show selected chars/lines only in visual modes
local function visual_selection()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    return ""
  end
  local lines = math.abs(vim.fn.line(".") - vim.fn.line("v")) + 1
  if mode == "V" then
    return lines .. "L"
  end
  local chars = (vim.fn.wordcount().visual_chars or 0)
  return chars .. "C " .. lines .. "L"
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        -- Single global statusline (laststatus=3): no bar in preview splits
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          "filename",
          { visual_selection, color = { fg = "#ff9e64" } },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "searchcount", "location" },
      },
      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
    })
  end,
}
