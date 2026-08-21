return {
    -- The upstream config only looks for a generically named config.yml. SQL
    -- projects normally keep connection settings in ~/.config/sqls/config.yml.
    root_markers = { ".git" },
}
