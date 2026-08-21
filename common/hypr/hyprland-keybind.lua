local programs = require("hyprland-program")

-- -------------------------------------------------------------------------- --
--                                Key bindings                                --
-- -------------------------------------------------------------------------- --

local main_mod = "SUPER"

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,
        numlock_by_default = true,

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- System and layout
hl.bind(main_mod .. " + Q", hl.dsp.window.close())
hl.bind(
    main_mod .. " + SHIFT + Q",
    hl.dsp.exec_cmd(
        "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
    )
)
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())

-- Launch applications
hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(programs.terminal))
hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(programs.menu))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(main_mod .. " + F", hl.dsp.exec_cmd(programs.file_manager))

-- Screenshots
hl.bind(main_mod .. " + PRINT", hl.dsp.exec_cmd("hyprshot --mode window"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot --mode output"))
hl.bind(main_mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --mode region"))

-- Focus windows
hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(main_mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(main_mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(main_mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(main_mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(main_mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Switch workspaces and move windows to workspaces
for workspace = 1, 9 do
    hl.bind(main_mod .. " + " .. workspace, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. workspace, hl.dsp.window.move({ workspace = workspace }))
end

-- Volume. Brightness controls are intentionally omitted because the
-- authoritative FreeBSD systems do not expose backlight devices.
local volume_flags = { locked = true, repeating = true }
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    volume_flags
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    volume_flags
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    volume_flags
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    volume_flags
)

-- Media playback (requires playerctl)
local media_flags = { locked = true }
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), media_flags)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), media_flags)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), media_flags)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), media_flags)
