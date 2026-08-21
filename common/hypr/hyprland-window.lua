-- -------------------------------------------------------------------------- --
--                           Windows and workspaces                           --
-- -------------------------------------------------------------------------- --

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
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

local workspace_rules = {
    { name = "Ghostty", class = "com.mitchellh.ghostty", workspace = 1 },
    { name = "Wezterm", class = "org.wezfurlong.wezterm", workspace = 1 },
    { name = "Firefox", class = "firefox", workspace = 2 },
    { name = "Helium", class = "helium", workspace = 2 },
    { name = "Zen", class = "zen", workspace = 2 },
    { name = "Nautilus", class = "org.gnome.Nautilus", workspace = 3 },
    { name = "Lollypop", class = "org.gnome.Lollypop", workspace = 6 },
    { name = "Plexamp", class = "Plexamp", workspace = 6 },
    { name = "Proton Pass", class = "Proton Pass", workspace = 7 },
    { name = "Proton VPN", class = "proton.vpn.app.gtk", workspace = 7 },
    { name = "Proton Mail", class = "Proton Mail", workspace = 9 },
    { name = "Legcord", class = "legcord", workspace = 9 },
}

for _, rule in ipairs(workspace_rules) do
    hl.window_rule({
        name = rule.name,
        match = { class = rule.class },
        workspace = rule.workspace,
    })
end
