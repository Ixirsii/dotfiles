local wezterm = require("wezterm")
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

-- Appearance
config.font = wezterm.font("SauceCodePro Nerd Font")
config.font_size = 14
config.color_scheme = get_color_scheme(get_appearance())
config.enable_tab_bar = true
config.enable_wayland = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8

-- Update interval
config.status_update_interval = 1000

-- Key bindings
config.keys = {
	-- Close pane
	{
		mods = "SUPER",
		key = "w",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- Split pane
	{
		mods = "SHIFT|SUPER",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "SUPER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Navigate panes
	{
		mods = "CTRL",
		key = "h",
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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
		action = wezterm.action_callback(function(win, pane)
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

-- Tab bar
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

-- Status bar
wezterm.on("update-status", function(window, pane)
	local palette = window:effective_config().resolved_palette

	-- Right status
	local battery_text = ""
	local battery_icon = ""
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

	for _, b in ipairs(wezterm.battery_info()) do
		local icons = (b.state == "Charging" or b.state == "Full") and battery_icons.charging
			or battery_icons.discharging
		local battery_charge = b.state_of_charge * 100

		battery_text = string.format("%.0f%%", battery_charge)
		battery_icon = icons[math.floor(battery_charge / 10)]
	end

	window:set_right_status(wezterm.format({
		{ Foreground = { Color = palette.ansi[3] } },
		{ Text = "" },
		{ Background = { Color = palette.ansi[3] } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "  " },
		{ Foreground = { Color = palette.ansi[3] } },
		{ Text = "█" },
		{ Background = { Color = palette.tab_bar.background } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
		{ Foreground = { Color = palette.foreground } },
		{ Text = pane:get_title() },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
		{ Foreground = { Color = palette.ansi[5] } },
		{ Text = "" },
		{ Background = { Color = palette.ansi[5] } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = " 󰌢 " },
		{ Foreground = { Color = palette.ansi[5] } },
		{ Text = "█" },
		{ Background = { Color = palette.tab_bar.background } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
		{ Foreground = { Color = palette.foreground } },
		{ Text = wezterm.hostname() },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
		{ Foreground = { Color = palette.ansi[6] } },
		{ Text = "" },
		{ Background = { Color = palette.ansi[6] } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = " " .. battery_icon .. " " },
		{ Foreground = { Color = palette.ansi[6] } },
		{ Text = "█" },
		{ Background = { Color = palette.tab_bar.background } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
		{ Foreground = { Color = palette.foreground } },
		{ Text = battery_text },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
		{ Foreground = { Color = palette.ansi[7] } },
		{ Text = "" },
		{ Background = { Color = palette.ansi[7] } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "  " },
		{ Foreground = { Color = palette.ansi[7] } },
		{ Text = "█" },
		{ Background = { Color = palette.tab_bar.background } },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
		{ Foreground = { Color = palette.foreground } },
		{ Text = date },
		{ Foreground = { Color = palette.tab_bar.background } },
		{ Text = "█" },
	}))
end)

return config
