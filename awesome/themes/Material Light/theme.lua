-- -------------------------------------------------------------------------- --
--                         Material Theme for Awesome                         --
-- -------------------------------------------------------------------------- --

-- {{{ Imports
local gears             = require("gears")
local awful             = require("awful")
local wibox             = require("wibox")
local theme_assets      = require("beautiful.theme_assets")
local xresources        = require("beautiful.xresources")
local dpi               = xresources.apply_dpi

local gfs               = require("gears.filesystem")
local themes_path       = gfs.get_themes_dir()
local configuration_dir = gfs.get_configuration_dir()
local naughty           = require("naughty")
local lain              = require("lain")

local markup = lain.util.markup
-- }}}

-- {{{ Colorscheme
local accent                = "#512da8"
local background_primary    = "#eceff1"
local background_secondary  = "#455a64"
local font_primary          = "#212121"
local urgent                = "#d32f2f"
-- }}}

-- {{{ Set theme variables
local theme                                     = {}

theme.dir                                       = configuration_dir .. "themes/Material Light"
theme.wallpaper                                 = theme.dir .. "/wallpaper.png"

theme.font                                      = "Noto Sans 9"

theme.bg_normal                                 = background_primary
theme.bg_focus                                  = accent
theme.bg_urgent                                 = accent
theme.bg_minimize                               = background_secondary
theme.bg_systray                                = theme.bg_normal

theme.fg_normal                                 = font_primary
theme.fg_focus                                  = accent
theme.fg_urgent                                 = font_primary
theme.fg_minimize                               = font_primary

theme.taglist_bg_empty                          = background_primary
theme.taglist_bg_focus                          = background_primary
theme.taglist_bg_occupied                       = background_primary
theme.taglist_bg_urgent                         = background_primary
theme.taglist_bg_volatile                       = background_primary

theme.useless_gap                               = dpi(5)
theme.border_width                              = dpi(2)
theme.border_normal                             = theme.bg_normal
theme.border_focus                              = theme.bg_focus
theme.border_marked                             = "#90a4ae"

theme.menu_submenu_icon                         = themes_path .. "default/submenu.png"
theme.menu_height                               = dpi(15)
theme.menu_width                                = dpi(100)

theme.titlebar_close_button_normal              = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "default/titlebar/close_focus.png"

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

theme.titlebar_floating_button_normal_inactive  = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh                              = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv                              = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating                           = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier                          = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max                                = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen                         = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom                         = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft                           = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile                               = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop                            = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral                             = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle                            = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw                           = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne                           = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw                           = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse                           = themes_path .. "default/layouts/cornersew.png"

-- lain layout icons
theme.lain_icons                                = configuration_dir .. "lain/icons/layout/default/"
theme.layout_termfair                           = theme.lain_icons .. "termfairw.png"
theme.layout_centerfair                         = theme.lain_icons .. "centerfairw.png"  -- termfair.center
theme.layout_cascade                            = theme.lain_icons .. "cascadew.png"
theme.layout_cascadetile                        = theme.lain_icons .. "cascadetilew.png" -- cascade.tile
theme.layout_centerwork                         = theme.lain_icons .. "centerworkw.png"
theme.layout_centerworkh                        = theme.lain_icons .. "centerworkhw.png" -- centerwork.horizontal<Paste>

-- Icons
theme.awesome_icon                              = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
theme.icon_theme                                = "Flat-Remix"

-- Widget icons
theme.batt_020                                  = theme.dir .. "/icons/battery-020.png"
theme.batt_020_charging                         = theme.dir .. "/icons/battery-020-charging.png"
theme.batt_040                                  = theme.dir .. "/icons/battery-040.png"
theme.batt_040_charging                         = theme.dir .. "/icons/battery-040-charging.png"
theme.batt_060                                  = theme.dir .. "/icons/battery-060.png"
theme.batt_060_charging                         = theme.dir .. "/icons/battery-060-charging.png"
theme.batt_080                                  = theme.dir .. "/icons/battery-080.png"
theme.batt_080_charging                         = theme.dir .. "/icons/battery-080-charging.png"
theme.batt_100                                  = theme.dir .. "/icons/battery-100.png"
theme.batt_100_charging                         = theme.dir .. "/icons/battery-100-charging.png"
theme.wifi_disc                                 = theme.dir .. "/icons/wireless-disconnected.png"
theme.wifi_full                                 = theme.dir .. "/icons/wireless-full.png"
theme.wifi_high                                 = theme.dir .. "/icons/wireless-high.png"
theme.wifi_low                                  = theme.dir .. "/icons/wireless-low.png"
theme.wifi_med                                  = theme.dir .. "/icons/wireless-medium.png"
theme.wifi_none                                 = theme.dir .. "/icons/wireless-none.png"
-- }}}

-- {{{ Widgets
-- {{{ Battery
local batt_icon = wibox.widget.imagebox(theme.batt_020)
local batt_tool_tip = awful.tooltip({
    objects = { batt_icon },
    margin_leftright = 15,
    margin_topbottom = 12,
})
batt_tool_tip.wibox.fg = theme.fg_normal
batt_tool_tip.textbox.font = theme.font
batt_tool_tip.timeout = 0
batt_tool_tip:set_shape(function(cr, width, height)
    gears.shape.infobubble(cr, width, height, corner_radius, arrow_size, width - 35)
end)
local batt_widget = lain.widget.bat({
    settings = function()
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

        batt_icon:set_image(theme[index])
        batt_tool_tip:set_markup(string.format("\n%s%%, %s", perc, bat_now.time))
    end
})
-- }}}

-- {{{ Clock
local mytextclock = wibox.widget.textclock("<span font_weight=\"bold\"> %d %B %Y, %H:%M </span>")
mytextclock.font = theme.font
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        bg = background_primary,
        fg = font_primary,
        font = theme.font,
        position = "top_middle",
    }
})
-- }}}

-- {{{ Network
local wifi_icon = wibox.widget.imagebox(theme.wifi_disc)
local wifi_tool_tip = awful.tooltip({
    objects = { wifi_icon },
    margin_leftright = 15,
    margin_topbottom = 15,
})
wifi_tool_tip.wibox.fg = theme.fg_normal
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
-- }}}
-- }}}

-- {{{ at_screen_connect
function theme.at_screen_connect(s)
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
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        { -- Middle widgets
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            -- wifi_icon,
            batt_icon,
            s.mylayoutbox,
        },
    }
end
-- }}}

return theme

-- -------------------------------------------------------------------------- --
--                                    EOF                                     --
-- -------------------------------------------------------------------------- --
