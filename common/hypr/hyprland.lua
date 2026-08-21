local programs = require("hyprland-program")

require("hyprland-keybind")
require("hyprland-layout")
require("hyprland-theme")
require("hyprland-window")

-- -------------------------------------------------------------------------- --
--                                Environment                                 --
-- -------------------------------------------------------------------------- --

hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Catppucin-Mocha-Sky")

-- -------------------------------------------------------------------------- --
--                                  Monitors                                  --
-- -------------------------------------------------------------------------- --

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-- -------------------------------------------------------------------------- --
--                                 Auto start                                 --
-- -------------------------------------------------------------------------- --

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")

    hl.exec_cmd(programs.terminal)
    hl.exec_cmd(programs.browser)
end)
