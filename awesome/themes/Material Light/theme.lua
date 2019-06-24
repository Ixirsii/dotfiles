-- -------------------------------------------------------------------------- --
--                         Material Theme for Awesome                         --
-- -------------------------------------------------------------------------- --

local gfs               = require("gears.filesystem")
local theme_assets      = require("beautiful.theme_assets")
                          require("themes/material-theme-base")
local configuration_dir = gfs.get_configuration_dir()

local accent            = "#311b92"
local awesome_icon      = theme_assets.awesome_icon
local bg_primary        = "#eceff1"
local bg_secondary      = "#455a64"
local fg_primary        = "#263238"
local font              = "Noto Sans 9"
local icon_theme        = "Paper"
local opacity           = 0.8
local theme_name        = "Material Light"
local urgent            = "#b71c1c"

return get_theme(theme_name, fg_primary, bg_primary, bg_secondary, accent, urgent, font, opacity, awesome_icon, icon_theme)

-- -------------------------------------------------------------------------- --
--                                    EOF                                     --
-- -------------------------------------------------------------------------- --
