return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            for key, direction in pairs({ ["]c"] = "next", ["[c"] = "prev" }) do
                map("n", key, function()
                    if vim.wo.diff then
                        vim.cmd.normal({ key, bang = true })
                    else
                        gs.nav_hunk(direction)
                    end
                end, direction == "next" and "Next Git hunk" or "Previous Git hunk")
            end

            map("n", "<leader>hs", gs.stage_hunk, "Stage/unstage hunk")
            map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
            map("v", "<leader>hs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage/unstage selected lines")
            map("v", "<leader>hr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset selected lines")
            map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>hb", gs.blame_line, "Blame line")
            map("n", "<leader>hd", gs.diffthis, "Diff against index")
            map({ "o", "x" }, "ih", gs.select_hunk, "Select Git hunk")
        end,
    },
}
