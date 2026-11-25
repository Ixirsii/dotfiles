local function path()
    local git = vim.b.gitsigns_status_dict
    local relative = git and git.root and vim.fs.relpath(git.root, vim.api.nvim_buf_get_name(0))
    return (relative and relative:gsub("%%", "%%%%") or "%f") .. "%m%r"
end

local function file_options()
    if vim.bo.buftype ~= "" then
        return ""
    end
    local parts = {}
    local encoding = vim.bo.fileencoding
    if encoding ~= "" and encoding ~= "utf-8" then
        table.insert(parts, encoding)
    end
    local endings = { dos = "CRLF", mac = "CR" }
    table.insert(parts, endings[vim.bo.fileformat])
    table.insert(parts, vim.bo.expandtab and ("spaces:" .. vim.fn.shiftwidth()) or ("tabs:" .. vim.bo.tabstop))
    return table.concat(parts, " ")
end

local function update_formatter(buf)
    if not vim.api.nvim_buf_is_loaded(buf) or vim.bo[buf].buftype ~= "" then
        return
    end
    local names = {}
    for _, formatter in ipairs(require("conform").list_formatters(buf)) do
        if formatter.available and formatter.name ~= "trim_newlines" then
            table.insert(names, formatter.name)
        end
    end
    if #names == 0 and #vim.lsp.get_clients({ bufnr = buf, method = "textDocument/formatting" }) > 0 then
        table.insert(names, "LSP")
    end
    vim.b[buf].statusline_formatter = "fmt:" .. (#names > 0 and table.concat(names, ",") or "none")
    vim.cmd.redrawstatus()
end

local function escape(text)
    return (tostring(text):gsub("%%", "%%%%"))
end

local function width()
    return vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
end

-- Use named segments so their separators can blend into adjacent backgrounds.
local colors = {}
local function setup_highlights()
    local palette = require("catppuccin.palettes").get_palette()
    colors = {
        base = palette.base,
        normal = palette.blue,
        insert = palette.green,
        visual = palette.mauve,
        replace = palette.red,
        command = palette.peach,
        git = palette.yellow,
        file = palette.peach,
        diagnostic = palette.red,
        search = palette.yellow,
        type = palette.sapphire,
        format = palette.green,
        options = palette.surface0,
        cursor = palette.mauve,
    }
    for name, bg in pairs(colors) do
        if name ~= "base" then
            local strong = vim.tbl_contains({ "normal", "insert", "visual", "replace", "command" }, name)
            vim.api.nvim_set_hl(0, "StatusSegment" .. name, {
                fg = name == "options" and palette.text or palette.crust,
                bg = bg,
                bold = strong,
            })
        end
        for next_name, next_bg in pairs(colors) do
            vim.api.nvim_set_hl(0, "StatusEdge" .. name .. next_name, { fg = bg, bg = next_bg })
        end
    end
end

local function segments(items)
    if #items == 0 then
        return ""
    end
    local result = "%#StatusEdge" .. items[1][1] .. "base#"
    for i, item in ipairs(items) do
        local name, text = item[1], item[2]
        result = result .. "%#StatusSegment" .. name .. "# " .. text .. " "
        local next_name = items[i + 1] and items[i + 1][1] or "base"
        result = result .. "%#StatusEdge" .. name .. next_name .. "#" .. (next_name == "base" and "" or "")
    end
    return result .. "%#Slimline#"
end

local function left()
    local first = vim.fn.mode():sub(1, 1)
    local formats = require("slimline").config.configs.mode.format
    local mode = (formats[first] or formats.U).verbose
    local color = ({ i = "insert", v = "visual", V = "visual", ["\22"] = "visual", R = "replace", c = "command" })[first]
        or "normal"
    local items = { { color, escape(mode) } }
    local recording = vim.fn.reg_recording()
    if recording ~= "" then
        table.insert(items, { "diagnostic", " REC @" .. escape(recording) })
    end
    local git = vim.b.gitsigns_status_dict
    if width() >= 60 and git and git.head and git.head ~= "" then
        local text = " " .. escape(git.head)
        for _, entry in ipairs({ { "added", "+" }, { "changed", "~" }, { "removed", "-" } }) do
            local count = git[entry[1]] or 0
            if count > 0 then
                text = text .. " " .. entry[2] .. count
            end
        end
        table.insert(items, { "git", text })
    end
    return segments(items)
end

local function center()
    return segments({ { "file", path() } })
end

local function right()
    local items = {}
    if vim.v.hlsearch == 1 and vim.fn.getreg("/") ~= "" then
        local ok, search = pcall(vim.fn.searchcount, { recompute = true, maxcount = 999, timeout = 20 })
        if ok and search.total and search.total > 0 then
            table.insert(items, { "search", " " .. search.current .. "/" .. search.total })
        end
    end
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if errors + warnings > 0 then
        table.insert(items, { "diagnostic", (errors > 0 and " " .. errors .. " " or "") .. (warnings > 0 and " " .. warnings or "") })
    end
    local ft = vim.bo.filetype
    if ft ~= "" then
        local icon = require("mini.icons").get("filetype", ft)
        local clients = {}
        if width() >= 110 then
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                table.insert(clients, escape(client.name))
            end
        end
        table.insert(items, { "type", icon .. " " .. escape(ft) .. (#clients > 0 and " " .. table.concat(clients, ",") or "") })
    end
    if width() >= 100 and vim.b.statusline_formatter then
        table.insert(items, { "format", escape(vim.b.statusline_formatter) })
    end
    local options = file_options()
    if width() >= 90 and options ~= "" then
        table.insert(items, { "options", escape(options) })
    end
    table.insert(items, { "cursor", "%l:%c" })
    return segments(items)
end

return {
    "sschleemilch/slimline.nvim",
    dependencies = { "nvim-mini/mini.icons", "lewis6991/gitsigns.nvim", "stevearc/conform.nvim" },
    opts = {
        components = {
            left = { left },
            center = { center },
            right = { right },
        },
        configs = { mode = { verbose = true } },
    },
    config = function(_, opts)
        local slimline = require("slimline")
        slimline.setup(opts)
        local render = slimline.render
        slimline.render = function(active)
            if vim.bo.buftype ~= "" or vim.bo.filetype:match("^snacks_") then
                return ""
            end
            return render(active)
        end
        setup_highlights()
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("StatuslineColors", { clear = true }),
            callback = setup_highlights,
        })
        -- Keep formatter discovery off the statusline redraw path.
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType", "LspAttach", "LspDetach" }, {
            group = vim.api.nvim_create_augroup("StatuslineFormatter", { clear = true }),
            callback = function(ev)
                vim.schedule(function()
                    update_formatter(ev.buf)
                end)
            end,
        })
    end,
}
