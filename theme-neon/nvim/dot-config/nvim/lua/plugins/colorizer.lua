return {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        user_default_options = {
            RGB = true,
            RRGGBB = true,
            RRGGBBAA = true,
            rgb_fn = true,
            hsl_fn = true,
            names = false,
        },
    },
}
