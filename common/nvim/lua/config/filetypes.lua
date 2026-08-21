vim.filetype.add({
    pattern = {
        [".*/templates/.*%.html"] = function(path)
            if vim.fs.root(vim.fs.dirname(path), "Cargo.toml") then
                -- Askama uses Jinja-like template syntax. Using htmldjango gives
                -- us compatible syntax support without routing the file through
                -- the generic HTML formatter.
                return "htmldjango"
            end
        end,
    },
})
