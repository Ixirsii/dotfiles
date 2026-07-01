-- -------------------------------------------------------------------------- --
--                                Key bindings                                --
-- -------------------------------------------------------------------------- --

-- Modifier key
local mainMod = "SUPER"

-- Input
hl.config({
    input = {
        follow_mouse = 1,

        kb_layout = "us",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        kb_variant = "",

        numlock_by_default = true,

        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- System
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
    mainMod .. " + SHIFT + Q",
    hl.dsp.exec_cmd(
        "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
    )
)
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Launch application
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("wezterm"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("dolphin"))

-- Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Workspace
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Screenshot
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot --mode window"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot --mode output"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --mode region"))
