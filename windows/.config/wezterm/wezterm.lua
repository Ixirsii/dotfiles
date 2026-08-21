-- ---------------------------------------------------------------------------------------------- --
--                                             Setup                                              --
-- ---------------------------------------------------------------------------------------------- --

local wezterm = require("wezterm")
local act = wezterm.action
local callback = wezterm.action_callback
local config = wezterm.config_builder()

-- Default shell on Windows
if wezterm.target_triple:find("windows") then
    config.default_prog = { "pwsh.exe" }
end

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == "true"
end

-- ---------------------------------------------------------------------------------------------- --
--                                           Appearance                                           --
-- ---------------------------------------------------------------------------------------------- --

config.font = wezterm.font("Source Code Pro")
config.font_size = wezterm.target_triple:find("windows") and 10 or 14
local catppuccin = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
catppuccin.tab_bar.active_tab.bg_color = "#89dceb"

config.color_scheme = "Catppuccin Mocha"
config.colors = {
    tab_bar = catppuccin.tab_bar,
}
config.enable_tab_bar = true
config.enable_wayland = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = true

if wezterm.target_triple:find("darwin") or wezterm.target_triple:find("windows") then
    config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
else
    config.window_decorations = "NONE"
end

config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"

config.window_frame = {
    font = wezterm.font("SauceCodePro NFM"),
    font_size = 14.0,
    active_titlebar_bg = catppuccin.tab_bar.background,
    inactive_titlebar_bg = catppuccin.tab_bar.background,
    active_titlebar_fg = catppuccin.foreground,
    inactive_titlebar_fg = catppuccin.foreground,
    button_fg = catppuccin.foreground,
    button_bg = catppuccin.background,
}

config.window_padding = {
    bottom = 0,
    left = 0,
    right = 0,
    top = 0,
}

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
        mods = "SHIFT",
        key = "Insert",
        action = act.PasteFrom("PrimarySelection"),
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

wezterm.on("format-tab-title", function(tab_info, _, _, _, _, max_width)
    local index = tab_info.tab_index + 1
    local prefix = string.format("%d ", index)
    local title_size = math.max(1, max_width - wezterm.column_width(prefix))
    local title = tab_info.tab_title

    if not title or #title < 1 then
        title = tab_info.active_pane.title
    end

    -- Try to get just the application name first
    if wezterm.column_width(title) > title_size then
        title = title:match("^%S+") or title
    end

    -- Truncate if still needed
    if wezterm.column_width(title) > title_size then
        title = wezterm.truncate_right(title, math.max(0, title_size - 1)) .. "…"
    end

    return { { Text = prefix .. title } }
end)

-- ---------------------------------------------------------------------------------------------- --
--                                           Status bar                                           --
-- ---------------------------------------------------------------------------------------------- --

local function get_battery_status()
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
    local battery_icon = ""
    local battery_text = ""

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

    return battery_icon, battery_text
end

local function get_hostname(cwd_uri)
    local hostname = ""

    if cwd_uri then
        local cwd = ""

        if type(cwd_uri) == "userdata" then
            -- Running on a newer version of wezterm and we have
            -- a URL object here, making this simple!

            cwd = cwd_uri.file_path
            hostname = cwd_uri.host or wezterm.hostname()
        else
            -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
            -- which doesn't have the Url object
            cwd_uri = cwd_uri:sub(8)
            local slash = cwd_uri:find("/")
            if slash then
                hostname = cwd_uri:sub(1, slash - 1)
                -- and extract the cwd from the uri, decoding %-encoding
                cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
                    return string.char(tonumber(hex, 16))
                end)
            end
        end

        -- Remove the domain name portion of the hostname
        local dot = hostname:find("[.]")
        if dot then
            hostname = hostname:sub(1, dot - 1)
        end
    end

    return hostname
end

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

    local ok, success, stdout =
        pcall(wezterm.run_child_process, { "/usr/local/bin/upsc", "ups@localhost" })
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
    local background = palette.tab_bar.background
    local foreground = palette.foreground

    window:set_left_status(" ")

    -- Right status
    local battery_icon, battery_text = get_battery_status()
    local date = wezterm.strftime("%a %b %d %H:%M:%S")
    local hostname = get_hostname(pane:get_current_working_dir())
    local ups = get_ups_status()

    local status = {
        { Foreground = { Color = "#a6e3a1" } },
        { Text = "" },
        { Background = { Color = "#a6e3a1" } },
        { Foreground = { Color = background } },
        { Text = " 󰌢 " },
        { Foreground = { Color = "#a6e3a1" } },
        { Text = "█" },
        { Background = { Color = background } },
        { Foreground = { Color = background } },
        { Text = "█" },
        { Foreground = { Color = foreground } },
        { Text = hostname },
        { Foreground = { Color = background } },
        { Text = "█" },
    }

    if battery_text ~= "" then
        table.insert(status, { Foreground = { Color = "#89b4fa" } })
        table.insert(status, { Text = "" })
        table.insert(status, { Background = { Color = "#89b4fa" } })
        table.insert(status, { Foreground = { Color = background } })
        table.insert(status, { Text = " " .. battery_icon .. " " })
        table.insert(status, { Foreground = { Color = "#89b4fa" } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Background = { Color = background } })
        table.insert(status, { Foreground = { Color = background } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Foreground = { Color = foreground } })
        table.insert(status, { Text = battery_text })
        table.insert(status, { Foreground = { Color = background } })
        table.insert(status, { Text = "█" })
    end

    if ups then
        local ups_text = string.format("%s%% %s", ups.charge, ups.status)
        if ups.runtime and ups.status:find("OB") then
            ups_text = ups_text .. " " .. ups.runtime
        end

        table.insert(status, { Foreground = { Color = "#b4befe" } })
        table.insert(status, { Text = "" })
        table.insert(status, { Background = { Color = "#b4befe" } })
        table.insert(status, { Foreground = { Color = background } })
        table.insert(status, { Text = " 󰚥 " })
        table.insert(status, { Foreground = { Color = "#b4befe" } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Background = { Color = background } })
        table.insert(status, { Foreground = { Color = background } })
        table.insert(status, { Text = "█" })
        table.insert(status, { Foreground = { Color = foreground } })
        table.insert(status, { Text = ups_text })
        table.insert(status, { Foreground = { Color = background } })
        table.insert(status, { Text = "█" })
    end

    table.insert(status, { Foreground = { Color = "#cba6f7" } })
    table.insert(status, { Text = "" })
    table.insert(status, { Background = { Color = "#cba6f7" } })
    table.insert(status, { Foreground = { Color = background } })
    table.insert(status, { Text = "  " })
    table.insert(status, { Foreground = { Color = "#cba6f7" } })
    table.insert(status, { Text = "█" })
    table.insert(status, { Background = { Color = background } })
    table.insert(status, { Foreground = { Color = background } })
    table.insert(status, { Text = "█" })
    table.insert(status, { Foreground = { Color = foreground } })
    table.insert(status, { Text = date })
    table.insert(status, { Foreground = { Color = background } })
    table.insert(status, { Text = "█" })

    window:set_right_status(wezterm.format(status))
end)

return config
