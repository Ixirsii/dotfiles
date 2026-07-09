-- ---------------------------------------------------------------------------------------------- --
--                                             Setup                                              --
-- ---------------------------------------------------------------------------------------------- --

local wezterm = require("wezterm")
local act = wezterm.action
local callback = wezterm.action_callback
local config = wezterm.config_builder()

local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end

    return "Dark"
end

local function get_color_scheme(appearance)
    if appearance:find("Dark") then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Frappe"
    end
end

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == "true"
end

-- ---------------------------------------------------------------------------------------------- --
--                                           Appearance                                           --
-- ---------------------------------------------------------------------------------------------- --

config.font = wezterm.font("SauceCodePro Nerd Font Mono")
config.font_size = wezterm.target_triple:find("windows") and 12 or 14
config.color_scheme = get_color_scheme(get_appearance())
if wezterm.target_triple:find("windows") then
    config.default_prog = { "pwsh.exe" }
end
config.enable_tab_bar = true
config.enable_wayland = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.use_fancy_tab_bar = false
if wezterm.target_triple:find("windows") then
    config.window_decorations = "TITLE | RESIZE"
elseif wezterm.target_triple:find("darwin") then
    config.window_decorations = "RESIZE"
else
    config.window_decorations = "NONE"
end
config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"

-- ---------------------------------------------------------------------------------------------- --
--                                        Update interval                                         --
-- ---------------------------------------------------------------------------------------------- --

config.status_update_interval = 1000

-- ---------------------------------------------------------------------------------------------- --
--                                          Key bindings                                          --
-- ---------------------------------------------------------------------------------------------- --

-- Disable default key bindings
config.disable_default_key_bindings = true

local paste_mod = wezterm.target_triple:find("darwin") and "SUPER" or "CTRL"

config.keys = {
    -- Manage Wezterm
    {
        mods = "SHIFT|CTRL",
        key = "k",
        action = act.ClearScrollback("ScrollbackOnly"),
    },
    {
        mods = "SHIFT|CTRL",
        key = "l",
        action = act.ShowDebugOverlay,
    },
    {
        mods = "CTRL",
        key = "n",
        action = act.SpawnWindow,
    },
    {
        mods = "CTRL",
        key = "p",
        action = act.ActivateCommandPalette,
    },
    {
        mods = "SHIFT|CTRL",
        key = "r",
        action = act.ReloadConfiguration,
    },
    {
        mods = "SHIFT",
        key = "PageUp",
        action = act.ScrollByPage(-1),
    },
    {
        mods = "SHIFT",
        key = "PageDown",
        action = act.ScrollByPage(1),
    },
    -- Copy/paste
    {
        mods = "SUPER",
        key = "c",
        action = act.CopyTo("Clipboard"),
    },
    {
        mods = "SHIFT|CTRL",
        key = "f",
        action = act.Search("CurrentSelectionOrEmptyString"),
    },
    {
        mods = paste_mod,
        key = "v",
        action = act.PasteFrom("Clipboard"),
    },
    {
        mods = "CTRL",
        key = "x",
        action = act.ActivateCopyMode,
    },
    {
        mods = "SHIFT",
        key = "Insert",
        action = act.PasteFrom("PrimarySelection"),
    },
    {
        mods = "NONE",
        key = "Copy",
        action = act.CopyTo("Clipboard"),
    },
    -- Font size
    {
        mods = "CTRL|SHIFT",
        key = "_",
        action = act.DecreaseFontSize,
    },
    {
        mods = "CTRL",
        key = "=",
        action = act.ResetFontSize,
    },
    {
        mods = "SHIFT|CTRL",
        key = "+",
        action = act.IncreaseFontSize,
    },
    -- Manage tabs
    {
        mods = "CTRL",
        key = "t",
        action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
        mods = "SHIFT|CTRL",
        key = "PageUp",
        action = act.MoveTabRelative(-1),
    },
    {
        mods = "SHIFT|CTRL",
        key = "PageDown",
        action = act.MoveTabRelative(1),
    },
    -- Navigate tabs
    {
        mods = "CTRL",
        key = "1",
        action = act.ActivateTab(0),
    },
    {
        mods = "CTRL",
        key = "2",
        action = act.ActivateTab(1),
    },
    {
        mods = "CTRL",
        key = "3",
        action = act.ActivateTab(2),
    },
    {
        mods = "CTRL",
        key = "4",
        action = act.ActivateTab(3),
    },
    {
        mods = "CTRL",
        key = "5",
        action = act.ActivateTab(4),
    },
    {
        mods = "CTRL",
        key = "6",
        action = act.ActivateTab(5),
    },
    {
        mods = "CTRL",
        key = "7",
        action = act.ActivateTab(6),
    },
    {
        mods = "CTRL",
        key = "8",
        action = act.ActivateTab(7),
    },
    {
        mods = "CTRL",
        key = "9",
        action = act.ActivateTab(8),
    },
    {
        mods = "CTRL",
        key = "0",
        action = act.ActivateTab(9),
    },
    {
        mods = "SHIFT|CTRL",
        key = "[",
        action = act.ActivateTabRelative(-1),
    },
    {
        mods = "SHIFT|CTRL",
        key = "]",
        action = act.ActivateTabRelative(1),
    },
    -- Manage pane(s)
    {
        mods = "CTRL",
        key = "w",
        action = act.CloseCurrentPane({ confirm = false }),
    },
    {
        mods = "CTRL",
        key = "z",
        action = act.TogglePaneZoomState,
    },
    {
        mods = "SHIFT|CTRL",
        key = "|",
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "CTRL",
        key = "-",
        action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    -- Navigate panes
    {
        mods = "CTRL",
        key = "h",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL", key = "h" },
                }, pane)
            else
                win:perform_action({ ActivatePaneDirection = "Left" }, pane)
            end
        end),
    },
    {
        mods = "CTRL",
        key = "j",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL", key = "j" },
                }, pane)
            else
                win:perform_action({ ActivatePaneDirection = "Down" }, pane)
            end
        end),
    },
    {
        mods = "CTRL",
        key = "k",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL", key = "k" },
                }, pane)
            else
                win:perform_action({ ActivatePaneDirection = "Up" }, pane)
            end
        end),
    },
    {
        mods = "CTRL",
        key = "l",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL", key = "l" },
                }, pane)
            else
                win:perform_action({ ActivatePaneDirection = "Right" }, pane)
            end
        end),
    },
    -- Resize panes
    {
        mods = "CTRL|META",
        key = "h",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT", key = "h" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Left", 5 } }, pane)
            end
        end),
    },
    {
        mods = "SHIFT|CTRL|META",
        key = "h",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT|META", key = "h" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Left", 1 } }, pane)
            end
        end),
    },
    {
        mods = "CTRL|META",
        key = "j",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT", key = "j" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Down", 5 } }, pane)
            end
        end),
    },
    {
        mods = "SHIFT|CTRL|META",
        key = "j",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT|META", key = "j" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Down", 1 } }, pane)
            end
        end),
    },
    {
        mods = "CTRL|META",
        key = "k",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT", key = "k" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Up", 5 } }, pane)
            end
        end),
    },
    {
        mods = "SHIFT|CTRL|META",
        key = "k",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT|META", key = "k" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Up", 1 } }, pane)
            end
        end),
    },
    {
        mods = "CTRL|META",
        key = "l",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT", key = "l" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Right", 5 } }, pane)
            end
        end),
    },
    {
        mods = "SHIFT|CTRL|META",
        key = "l",
        action = callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { mods = "CTRL|SHIFT|META", key = "l" },
                }, pane)
            else
                win:perform_action({ AdjustPaneSize = { "Right", 1 } }, pane)
            end
        end),
    },
}

config.key_tables = {
    copy_mode = {
        { key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
        { key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
        { key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
        {
            key = "Escape",
            mods = "NONE",
            action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
        },
        { key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
        { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
        { key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
        { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
        { key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
        {
            key = "F",
            mods = "NONE",
            action = act.CopyMode({ JumpBackward = { prev_char = false } }),
        },
        {
            key = "F",
            mods = "SHIFT",
            action = act.CopyMode({ JumpBackward = { prev_char = false } }),
        },
        { key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
        { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
        { key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
        { key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
        { key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
        { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
        { key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
        { key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
        {
            key = "O",
            mods = "NONE",
            action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
        },
        {
            key = "O",
            mods = "SHIFT",
            action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
        },
        {
            key = "T",
            mods = "NONE",
            action = act.CopyMode({ JumpBackward = { prev_char = true } }),
        },
        {
            key = "T",
            mods = "SHIFT",
            action = act.CopyMode({ JumpBackward = { prev_char = true } }),
        },
        { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
        { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
        { key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
        { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
        { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
        { key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
        { key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
        {
            key = "c",
            mods = "CTRL",
            action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
        },
        { key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
        { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
        {
            key = "f",
            mods = "NONE",
            action = act.CopyMode({ JumpForward = { prev_char = false } }),
        },
        { key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
        { key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
        { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
        {
            key = "g",
            mods = "CTRL",
            action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
        },
        { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
        { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
        { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
        { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
        { key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
        { key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
        {
            key = "q",
            mods = "NONE",
            action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }),
        },
        {
            key = "t",
            mods = "NONE",
            action = act.CopyMode({ JumpForward = { prev_char = true } }),
        },
        { key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
        { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
        {
            key = "v",
            mods = "CTRL",
            action = act.CopyMode({ SetSelectionMode = "Block" }),
        },
        { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
        {
            key = "y",
            mods = "NONE",
            action = act.Multiple({
                { CopyTo = "ClipboardAndPrimarySelection" },
                { Multiple = { "ScrollToBottom", { CopyMode = "Close" } } },
            }),
        },
        { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
        { key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
        { key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
        { key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
        { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
        { key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
        { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
        { key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
        { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
        { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
    },

    search_mode = {
        { key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
        { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
        { key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
        { key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
        { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
        { key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
        { key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
        { key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
        { key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
        { key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
    },
}

-- ---------------------------------------------------------------------------------------------- --
--                                            Tab bar                                             --
-- ---------------------------------------------------------------------------------------------- --

wezterm.on("format-tab-title", function(tab_info, _, _, conf, _, max_width)
    local palette = conf.resolved_palette

    local index = tab_info.tab_index + 1
    local title_size = max_width - 5
    local tab_color = tab_info.is_active and 7 or 1
    local title = tab_info.tab_title

    if not title or #title < 1 then
        title = tab_info.active_pane.title
    end

    -- Try to get just the application name first
    if #title > title_size then
        local start_index = title:find(" ")
        title = title:sub(0, start_index)
    end

    -- Truncate if still needed
    if #title > title_size then
        title = wezterm.truncate_right(title, title_size - 1) .. "…"
    end

    return {
        { Background = { Color = palette.tab_bar.background } },
        { Foreground = { Color = palette.ansi[tab_color] } },
        { Text = "" },
        { Background = { Color = palette.ansi[tab_color] } },
        { Foreground = { Color = palette.tab_bar.background } },
        { Text = tostring(index) },
        { Foreground = { Color = palette.ansi[tab_color] } },
        { Text = "█" },
        { Background = { Color = palette.tab_bar.background } },
        { Foreground = { Color = palette.tab_bar.background } },
        { Text = "█" },
        { Foreground = { Color = palette.foreground } },
        { Text = title },
        { Foreground = { Color = palette.tab_bar.background } },
        { Text = "█" },
    }
end)

-- ---------------------------------------------------------------------------------------------- --
--                                           Status bar                                           --
-- ---------------------------------------------------------------------------------------------- --

local ups_cache = nil
local ups_last_update = 0
local ups_update_interval = 10

local function get_ups_status()
    if not wezterm.target_triple:find("freebsd") then
        return nil
    end

    local now = os.time()
    if now - ups_last_update < ups_update_interval then
        return ups_cache
    end

    ups_last_update = now
    ups_cache = nil

    local ok, success, stdout = pcall(wezterm.run_child_process, { "/usr/local/bin/upsc", "ups@localhost" })
    if not ok or not success or type(stdout) ~= "string" then
        return nil
    end

    local fields = {}
    for line in stdout:gmatch("[^\r\n]+") do
        local key, value = line:match("^([^:]+):%s*(.*)$")
        if key and value then
            fields[key] = value
        end
    end

    if not fields["battery.charge"] or not fields["ups.status"] then
        return nil
    end

    local runtime = nil
    if fields["battery.runtime"] and fields["battery.runtime"]:match("^%d+$") then
        runtime = string.format("%dm", math.floor(tonumber(fields["battery.runtime"]) / 60))
    end

    ups_cache = {
        charge = fields["battery.charge"],
        runtime = runtime,
        status = fields["ups.status"],
    }

    return ups_cache
end

wezterm.on("update-status", function(window, pane)
    local palette = window:effective_config().resolved_palette
    local tab_bar_background = palette.tab_bar and palette.tab_bar.background or palette.background

    -- Right status
    local battery_text = ""
    local battery_icon = ""
    local ups = get_ups_status()
    local battery_icons = {
        charging = {
            "󰢜",
            "󰂆",
            "󰂇",
            "󰂈",
            "󰢝",
            "󰂉",
            "󰢞",
            "󰂊",
            "󰂋",
            "󰂅",
        },
        discharging = {
            "󰁺",
            "󰁻",
            "󰁼",
            "󰁽",
            "󰁾",
            "󰁿",
            "󰂀",
            "󰂁",
            "󰂂",
            "󰁹",
        },
    }
    local date = wezterm.strftime("%b %-d %H:%M:%S")

    local battery_ok, batteries = pcall(wezterm.battery_info)
    if battery_ok then
        for _, b in ipairs(batteries) do
            local icons = (b.state == "Charging" or b.state == "Full") and battery_icons.charging
                or battery_icons.discharging
            local battery_charge = b.state_of_charge * 100
            local icon_index = math.max(1, math.min(10, math.floor(battery_charge / 10) + 1))

            battery_text = string.format("%.0f%%", battery_charge)
            battery_icon = icons[icon_index]
        end
    end

    local status = {
        { Foreground = { Color = palette.ansi[3] } },
        { Text = "" },
        { Background = { Color = palette.ansi[3] } },
        { Foreground = { Color = tab_bar_background } },
        { Text = "  " },
        { Foreground = { Color = palette.ansi[3] } },
        { Text = "█" },
        { Background = { Color = tab_bar_background } },
        { Foreground = { Color = tab_bar_background } },
        { Text = "█" },
        { Foreground = { Color = palette.foreground } },
        { Text = pane:get_title() },
        { Foreground = { Color = tab_bar_background } },
        { Text = "█" },
        { Foreground = { Color = palette.ansi[5] } },
        { Text = "" },
        { Background = { Color = palette.ansi[5] } },
        { Foreground = { Color = tab_bar_background } },
        { Text = " 󰌢 " },
        { Foreground = { Color = palette.ansi[5] } },
        { Text = "█" },
        { Background = { Color = tab_bar_background } },
        { Foreground = { Color = tab_bar_background } },
        { Text = "█" },
        { Foreground = { Color = palette.foreground } },
        { Text = wezterm.hostname() },
        { Foreground = { Color = tab_bar_background } },
        { Text = "█" },
    }

    if battery_text ~= "" then
        table.insert(status, { Foreground = { Color = palette.ansi[6] } })
        table.insert(status, { Text = "" })
        table.insert(status, { Background = { Color = palette.ansi[6] } })
        table.insert(status, { Foreground = { Color = tab_bar_background } })
        table.insert(status, { Text = " " .. battery_icon .. " " })
        table.insert(status, { Foreground = { Color = palette.ansi[6] } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Background = { Color = tab_bar_background } })
        table.insert(status, { Foreground = { Color = tab_bar_background } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Foreground = { Color = palette.foreground } })
        table.insert(status, { Text = battery_text })
        table.insert(status, { Foreground = { Color = tab_bar_background } })
        table.insert(status, { Text = "█" })
    end

    if ups then
        local ups_text = string.format("%s%% %s", ups.charge, ups.status)
        if ups.runtime and ups.status:find("OB") then
            ups_text = ups_text .. " " .. ups.runtime
        end

        table.insert(status, { Foreground = { Color = palette.ansi[6] } })
        table.insert(status, { Text = "" })
        table.insert(status, { Background = { Color = palette.ansi[6] } })
        table.insert(status, { Foreground = { Color = tab_bar_background } })
        table.insert(status, { Text = " 󰚥 " })
        table.insert(status, { Foreground = { Color = palette.ansi[6] } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Background = { Color = tab_bar_background } })
        table.insert(status, { Foreground = { Color = tab_bar_background } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Foreground = { Color = palette.foreground } })
        table.insert(status, { Text = ups_text })
        table.insert(status, { Foreground = { Color = tab_bar_background } })
        table.insert(status, { Text = "█" })
    end

    table.insert(status, { Foreground = { Color = palette.ansi[7] } })
    table.insert(status, { Text = "" })
    table.insert(status, { Background = { Color = palette.ansi[7] } })
    table.insert(status, { Foreground = { Color = tab_bar_background } })
    table.insert(status, { Text = "  " })
    table.insert(status, { Foreground = { Color = palette.ansi[7] } })
    table.insert(status, { Text = "█" })
    table.insert(status, { Background = { Color = tab_bar_background } })
    table.insert(status, { Foreground = { Color = tab_bar_background } })
    table.insert(status, { Text = "█" })
    table.insert(status, { Foreground = { Color = palette.foreground } })
    table.insert(status, { Text = date })
    table.insert(status, { Foreground = { Color = tab_bar_background } })
    table.insert(status, { Text = "█" })

    window:set_right_status(wezterm.format(status))
end)

return config
