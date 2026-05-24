-- Hyprland configuration (Lua)
-- https://wiki.hypr.land/Configuring/Start/

-- Theme (colors, decoration, gaps)
require("theme")

-- Animations (curves + animation timings)
require("animations")

-----------------
---- PLUGINS ----
-----------------
-- split-monitor-workspaces: per-monitor independent workspace sets
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/hypr/plugins/?.lua"
local smw = require("split-monitor-workspaces")
smw.setup({
    workspace_count = 10,
})

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})


---------------------
---- DISPLAYLINK ----
---------------------

hl.env("AQ_MGPU_NO_EXPLICIT", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")


---------------------
---- MY PROGRAMS ----
---------------------

local terminal     = "kitty"
local fileManager  = "thunar"
local menu         = "~/.config/hypr/scripts/applauncher.sh"
local windowSearch = "~/.config/hypr/scripts/windowswitch.sh"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("~/.config/hypr/scripts/battery-notify")
    hl.exec_cmd("~/.config/hypr/scripts/monitor-watch.sh")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE",    "24")
hl.env("HYPRCURSOR_SIZE", "24")


------------------
---- LAYOUTS ----
------------------

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- 3-finger horizontal swipe switches workspaces
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + Q",           hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",           hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M",   hl.dsp.exit())
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",           hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W",           hl.dsp.exec_cmd(windowSearch))
hl.bind(mainMod .. " + P",           hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",           hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + L",           hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + S",           hl.dsp.exec_cmd("slack"))
hl.bind(mainMod .. " + SHIFT + S",   hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- Focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down"  }))

-- Workspaces (split-monitor-workspaces — per-monitor independent sets)
for i = 1, smw.get_amount_of_workspaces() do
    local n = tostring(i)
    if n == "10" then n = "0" end  -- bind workspace 10 to SUPER + 0
    hl.bind(mainMod .. " +" .. n,         smw.workspace(n))
    hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace(n))
end

-- Scroll through workspaces on current monitor
hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + mouse_up",   smw.cycle_workspaces("prev"))

-- Move / resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 6.25%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 6.25%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),        { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                     { locked = true, repeating = true })

-- Media player (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })




--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Ignore maximize requests
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix XWayland drag issues
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Firefox: focus when activated (e.g. clicking a link from another app)
hl.window_rule({
    name  = "firefox-focus-on-activate",
    match = { class = "^firefox$" },
    focus_on_activate = true,
})

-- hyprland-run: float at bottom-left
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
