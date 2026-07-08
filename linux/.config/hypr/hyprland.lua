require("hyprland-keybind")
require("hyprland-layout")
require("hyprland-theme")
require("hyprland-window")

-- -------------------------------------------------------------------------- --
--                                Environment                                 --
-- -------------------------------------------------------------------------- --

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Catppuccin Mocha Sky")
hl.env("HYPRSHOT_DIR", "~/Pictures/screenshots")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- -------------------------------------------------------------------------- --
--                                  Monitors                                  --
-- -------------------------------------------------------------------------- --

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-- -------------------------------------------------------------------------- --
--                                  Programs                                  --
-- -------------------------------------------------------------------------- --

-- Set programs that you use
BROWSER = "zen-browser"
FILE_MANAGER = "dolphin"
MENU = "hyprlauncher"
TERMINAL = "wezterm"
TORRENT = "transmission-gtk"

-- -------------------------------------------------------------------------- --
--                                 Auto start                                 --
-- -------------------------------------------------------------------------- --

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd(TERMINAL)
    hl.exec_cmd(BROWSER)
    hl.exec_cmd(TORRENT)
end)
