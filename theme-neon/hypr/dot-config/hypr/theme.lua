-- Theme configuration — neon
-- Required from hyprland.lua

hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 20,
        border_size      = 3,
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",

        col = {
            -- Cyan → pink gradient border
            active_border   = { colors = { "rgba(00fff7cc)", "rgba(ff66ccdd)" }, angle = 45 },
            inactive_border = "rgba(0d000d33)",
        },
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 18,
            render_power = 3,
            color        = "rgba(c20bde33)",
        },

        blur = {
            enabled  = true,
            size     = 6,
            passes   = 3,
            noise    = 0.02,
            vibrancy = 0.1696,
        },
    },
})
