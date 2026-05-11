return {
  "Skardyy/neo-img",
  build = ":NeoImg Install",
  config = function()
    require("neo-img").setup({
      backend = "kitty",
      oil_preview = true,
      auto_open = true,
      size = "80%",
      center = true,
    })
  end,
}
