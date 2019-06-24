-- -------------------------------------------------------------------------- --
--                         Material Theme for Awesome                         --
-- -------------------------------------------------------------------------- --

-- {{{ Imports
local gears             = require("gears")
local awful             = require("awful")
local wibox             = require("wibox")
local xresources        = require("beautiful.xresources")
local dpi               = xresources.apply_dpi

local gfs               = require("gears.filesystem")
local themes_path       = gfs.get_themes_dir()
local configuration_dir = gfs.get_configuration_dir()
local naughty           = require("naughty")
local lain              = require("lain")

local markup            = lain.util.markup
-- }}}

-- {{{ get_battery_widget
local function get_battery_widget(theme)
    local battery_widget = wibox.widget.imagebox(theme.batt_020)
    local batt_tool_tip = awful.tooltip({
        objects = { battery_widget },
        margin_leftright = 15,
        margin_topbottom = 12,
    })
    batt_tool_tip.timeout = 0
    batt_tool_tip:set_shape(function(cr, width, height)
        gears.shape.infobubble(cr, width, height, corner_radius, arrow_size, width - 35)
    end)
    local batt_widget = lain.widget.bat({
        settings = function()
            bat_notification_charged_preset = {
                border_width = 0,
                bg = bg_secondary,
                fg = fg_primary,
                text = "You can unplug the cable",
                title = "Battery full",
            }
            bat_notification_low_preset = {
                border_width = 0,
                bg = bg_secondary,
                fg = fg_primary,
                text = "Plug in the cable",
                title = "Battery low",
            }
            bat_notification_critical_preset = {
                border_width = 0,
                bg = bg_secondary,
                fg = fg_primary,
                text = "Shutting down...",
                title = "Battery exhausted",
            }

            local index, perc = "batt_", tonumber(bat_now.perc) or 0

            if perc <= 20 then
                index = index .. "020"
            elseif perc <= 40 then
                index = index .. "040"
            elseif perc <= 60 then
                index = index .. "060"
            elseif perc <= 80 then
                index = index .. "080"
            else
                index = index .. "100"
            end

            if bat_now.ac_status == 1 then
                index = index .. "_charging"
            end

            battery_widget:set_image(theme[index])
            batt_tool_tip:set_markup(string.format("\n%s%%, %s", perc, bat_now.time))
        end
})
    return battery_widget
end
-- }}}

-- {{{ get_clock_widget
local function get_clock_widget(theme)
    local clock_widget = wibox.widget.textclock("<span font_weight=\"bold\"> %d %B %Y, %H:%M </span>")
    clock_widget.font = theme.font
    theme.cal = lain.widget.cal({
        attach_to = { clock_widget },
        notification_preset = {
            bg = bg_primary,
            fg = fg_primary,
            font = theme.font,
            position = "top_middle",
        }
    })

    return clock_widget
end
-- }}}

-- {{{ get_network_widget
local function get_network_widget(theme)
    local wifi_icon = wibox.widget.imagebox(theme.wifi_disc)
    local wifi_tool_tip = awful.tooltip({
        objects = { wifi_icon },
        margin_leftright = 15,
        margin_topbottom = 15,
    })
    wifi_tool_tip.wibox.fg = fg_primary
    wifi_tool_tip.textbox.font = theme.font
    wifi_tool_tip.timeout = 0
    wifi_tool_tip:set_shape(function(cr, width, height)
        gears.shape.infobubble(cr, width, height, corner_radius, arrow_size, width - 120)
    end)
    local wifi_widget = awful.widget.watch(
        { awful.util.shell, "-c", "awk 'NR==3 {printf(\"%d-%0.f\\n\", $2, $3 * 10 / 7)}' /proc/net/wireless; iw dev wlp2s0 link" },
        2,
        function(widget, stdout)
            local carrier, perc = stdout:match("(%d)-(%d+)")
            local tiptext = stdout:gsub("(%d)-(%d+)"):gsub("%s+$", "")
            perc = tonumber(perc)

            if carrier == "1" or not perc then
                wifi_icon:set_image(theme.wifi_disc)
                wifi_tool_tip.set_markup("Disconnected")
            else
                if perc <= 5 then
                    wifi_icon:set_image(theme.wifi_none)
                elseif perc <= 25 then
                    wifi_icon:set_image(theme.wifi_low)
                elseif perc <= 50 then
                    wifi_icon:set_image(theme.wifi_med)
                elseif perc <= 75 then
                    wifi_icon:set_image(theme.wifi_high)
                else
                    wifi_icon:set_image(theme.wifi_full)
                end
                wifi_tool_tip.set_markup(tiptext)
            end
        end
    )
    wifi_icon:connect_signal("button::press", function() awful.spawn(string.format("%s -e wavemon", awful.util.terminal)) end)

    return wifi_icon
end
-- }}}

-- {{{ at_screen_connect
local function get_at_screen_connect(theme)
    local battery_widget = get_battery_widget(theme)
    local clock_widget = get_clock_widget(theme)
    local network_widget = get_network_widget

    local function at_screen_connect(s)
        s.quake = lain.util.quake({ app = awful.util.terminal, border = theme.border_width }) 
        -- Wallpaper
        awful.util.set_wallpaper(s)

        -- Tags
        awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
            awful.button({ }, 1, function() awful.layout.inc( 1) end),
            awful.button({ }, 3, function() awful.layout.inc(-1) end),
            awful.button({ }, 4, function() awful.layout.inc( 1) end),
            awful.button({ }, 5, function() awful.layout.inc(-1) end)
        ))

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

        -- Create the wibox
        s.mywibox = awful.wibar({ height = 24, position = "top", screen = s })

        -- Add widgets to the wibox
        s.mywibox:setup {
            expand = "none",
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.align.horizontal,
                s.mytaglist,
                s.mypromptbox,
            },
            { -- Middle widgets
                layout = wibox.layout.align.horizontal,
                clock_widget,
            },
            { -- Right widgets
                layout = wibox.layout.align.horizontal,
                wibox.widget.systray(),
                -- network_widget
                battery_widget,
                s.mylayoutbox,
            },
        }
    end

    return at_screen_connect
end
-- }}}

-- {{{ set_layout_icons
local function set_layout_icons(theme)
    theme.layout_fairh          = themes_path .. "default/layouts/fairhw.png"
    theme.layout_fairv          = themes_path .. "default/layouts/fairvw.png"
    theme.layout_floating       = themes_path .. "default/layouts/floatingw.png"
    theme.layout_magnifier      = themes_path .. "default/layouts/magnifierw.png"
    theme.layout_max            = themes_path .. "default/layouts/maxw.png"
    theme.layout_fullscreen     = themes_path .. "default/layouts/fullscreenw.png"
    theme.layout_tilebottom     = themes_path .. "default/layouts/tilebottomw.png"
    theme.layout_tileleft       = themes_path .. "default/layouts/tileleftw.png"
    theme.layout_tile           = themes_path .. "default/layouts/tilew.png"
    theme.layout_tiletop        = themes_path .. "default/layouts/tiletopw.png"
    theme.layout_spiral         = themes_path .. "default/layouts/spiralw.png"
    theme.layout_dwindle        = themes_path .. "default/layouts/dwindlew.png"
    theme.layout_cornernw       = themes_path .. "default/layouts/cornernww.png"
    theme.layout_cornerne       = themes_path .. "default/layouts/cornernew.png"
    theme.layout_cornersw       = themes_path .. "default/layouts/cornersww.png"
    theme.layout_cornerse       = themes_path .. "default/layouts/cornersew.png"

    -- lain layout icons
    theme.lain_icons            = configuration_dir .. "lain/icons/layout/default/"
    theme.layout_termfair       = theme.lain_icons .. "termfairw.png"
    theme.layout_centerfair     = theme.lain_icons .. "centerfairw.png"  -- termfair.center
    theme.layout_cascade        = theme.lain_icons .. "cascadew.png"
    theme.layout_cascadetile    = theme.lain_icons .. "cascadetilew.png" -- cascade.tile
    theme.layout_centerwork     = theme.lain_icons .. "centerworkw.png"
    theme.layout_centerworkh    = theme.lain_icons .. "centerworkhw.png" -- centerwork.horizontal<Paste>

    return theme
end
-- }}}

-- {{{ set_title_bar
local function set_title_bar(theme)
    theme.titlebar_close_button_normal              = themes_path .. "default/titlebar/close_normal.png"
    theme.titlebar_close_button_focus               = themes_path .. "default/titlebar/close_focus.png"

    theme.titlebar_floating_button_normal_inactive  = themes_path .. "default/titlebar/floating_normal_inactive.png"
    theme.titlebar_floating_button_focus_inactive   = themes_path .. "default/titlebar/floating_focus_inactive.png"
    theme.titlebar_floating_button_normal_active    = themes_path .. "default/titlebar/floating_normal_active.png"
    theme.titlebar_floating_button_focus_active     = themes_path .. "default/titlebar/floating_focus_active.png"

    theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
    theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
    theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
    theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"

    theme.titlebar_minimize_button_normal           = themes_path .. "default/titlebar/minimize_normal.png"
    theme.titlebar_minimize_button_focus            = themes_path .. "default/titlebar/minimize_focus.png"

    theme.titlebar_ontop_button_normal_inactive     = themes_path .. "default/titlebar/ontop_normal_inactive.png"
    theme.titlebar_ontop_button_focus_inactive      = themes_path .. "default/titlebar/ontop_focus_inactive.png"
    theme.titlebar_ontop_button_normal_active       = themes_path .. "default/titlebar/ontop_normal_active.png"
    theme.titlebar_ontop_button_focus_active        = themes_path .. "default/titlebar/ontop_focus_active.png"

    theme.titlebar_sticky_button_normal_inactive    = themes_path .. "default/titlebar/sticky_normal_inactive.png"
    theme.titlebar_sticky_button_focus_inactive     = themes_path .. "default/titlebar/sticky_focus_inactive.png"
    theme.titlebar_sticky_button_normal_active      = themes_path .. "default/titlebar/sticky_normal_active.png"
    theme.titlebar_sticky_button_focus_active       = themes_path .. "default/titlebar/sticky_focus_active.png"

    return theme
end
-- }}}

-- {{{ set_theme_vars
local function set_theme_vars(accent,
                        bg_primary,
                        bg_secondary,
                        fg_primary,
                        opacity,
                        urgent,
                        theme)
    theme.bg_normal            = bg_primary
    theme.bg_focus             = bg_secondary
    theme.bg_urgent            = accent
    theme.bg_minimize          = bg_secondary
    theme.bg_systray           = theme.bg_normal

    theme.border_focus         = accent
    theme.border_normal        = bg_primary
    theme.border_width         = dpi(2)

    theme.fg_normal            = fg_primary
    theme.fg_focus             = accent
    theme.fg_urgent            = fg_primary
    theme.fg_minimize          = fg_primary

    theme.menu_height          = dpi(15)
    theme.menu_submenu_icon    = themes_path .. "default/submenu.png"
    theme.menu_width           = dpi(100)

    theme.notification_opacity  = opacity

    theme.taglist_bg_empty     = bg_primary
    theme.taglist_bg_focus     = bg_primary
    theme.taglist_bg_occupied  = bg_primary
    theme.taglist_bg_urgent    = bg_primary
    theme.taglist_bg_focus     = bg_primary

    theme.tooltip_bg           = bg_secondary
    theme.tooltip_border_width = 0
    theme.tooltip_fg           = fg_primary
    theme.tooltip_font         = theme.font
    theme.tooltip_opacity      = opacity

    theme.useless_gap          = dpi(5)

    return theme
end
-- }}}

-- {{{ set_widget_icons
local function set_widget_icons(theme)
    theme.batt_020          = theme.icons_dir .. "battery-020.png"
    theme.batt_020_charging = theme.icons_dir .. "battery-020-charging.png"
    theme.batt_040          = theme.icons_dir .. "battery-040.png"
    theme.batt_040_charging = theme.icons_dir .. "battery-040-charging.png"
    theme.batt_060          = theme.icons_dir .. "battery-060.png"
    theme.batt_060_charging = theme.icons_dir .. "battery-060-charging.png"
    theme.batt_080          = theme.icons_dir .. "battery-080.png"
    theme.batt_080_charging = theme.icons_dir .. "battery-080-charging.png"
    theme.batt_100          = theme.icons_dir .. "battery-100.png"
    theme.batt_100_charging = theme.icons_dir .. "battery-100-charging.png"
    theme.wifi_disc         = theme.icons_dir .. "wireless-disconnected.png"
    theme.wifi_full         = theme.icons_dir .. "wireless-full.png"
    theme.wifi_high         = theme.icons_dir .. "wireless-high.png"
    theme.wifi_low          = theme.icons_dir .. "wireless-low.png"
    theme.wifi_med          = theme.icons_dir .. "wireless-medium.png"
    theme.wifi_none         = theme.icons_dir .. "wireless-none.png"

    return theme
end
-- }}}

-- {{{ get_theme
function get_theme(theme_name,
                   fg_primary,
                   bg_primary,
                   bg_secondary,
                   accent,
                   urgent,
                   font,
                   opacity,
                   awesome_icon,
                   icon_theme,
                   icons_dir)
    local theme_base        = configuration_dir .. "themes/"
    local theme             = {}
    theme.font              = font
    theme.dir               = theme_base .. theme_name
    theme.icons_dir         = theme_base .. icons_dir
    theme.wallpaper         = configuration_dir .. "wallpaper.png"

    theme                   = set_theme_vars(accent,
                                             bg_primary,
                                             bg_secondary,
                                             fg_primary,
                                             opacity,
                                             urgent,
                                             theme
    )
    theme                   = set_title_bar(theme)
    theme                   = set_layout_icons(theme)
    theme                   = set_widget_icons(theme)

    theme.at_screen_connect = get_at_screen_connect(theme)
    theme.awesome_icon      = awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
    theme.icon_theme        = icon_theme

    return theme
end
-- }}}


-- -------------------------------------------------------------------------- --
--                                    EOF                                     --
-- -------------------------------------------------------------------------- --
