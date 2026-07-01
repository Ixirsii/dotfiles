-- -------------------------------------------------------------------------- --
--                           Windows and workspaces                           --
-- -------------------------------------------------------------------------- --

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})

-- Worksapce 1 (Terminals)

hl.window_rule({
    name = "Wezterm",
    match = { class = "org.wezfurlong.wezterm" },
    workspace = 1,
})

-- Worksapce 2 (Web browsers)

hl.window_rule({
    name = "Zen",
    match = { class = "zen" },
    workspace = 2,
})

-- Worksapce 3 (File browsers)

hl.window_rule({
    name = "Dolphin",
    match = { class = "org.kde.dolphin" },
    workspace = 3,
})

-- Worksapce 6 (Media)

hl.window_rule({
    name = "Lollypop",
    match = { class = "org.gnome.Lollypop" },
    workspace = 6,
})

hl.window_rule({
    name = "Plexamp",
    match = { class = "Plexamp" },
    workspace = 6,
})

-- Worksapce 7 (Security)

hl.window_rule({
    name = "Proton Pass",
    match = { class = "Proton Pass" },
    workspace = 7,
})

hl.window_rule({
    name = "Proton VPN",
    match = { class = "proton.vpn.app.gtk" },
    workspace = 7,
})

-- Worksapce 8 (File sharing)

hl.window_rule({
    name = "Transmission",
    match = { class = "transmission-qt" },
    workspace = 8,
})

-- Worksapce 9 (Social)

hl.window_rule({
    name = "Proton Mail",
    match = { class = "Proton Mail" },
    workspace = 9,
})

hl.window_rule({
    name = "Legcord",
    match = { class = "legcord" },
    workspace = 9,
})
