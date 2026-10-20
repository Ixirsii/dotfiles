return {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
    init = function()
        vim.g.rustaceanvim = function()
            return {
                tools = { test_executor = "neotest" },
                server = {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    on_attach = function(_, bufnr)
                        local function map(lhs, command, desc)
                            vim.keymap.set("n", lhs, function()
                                vim.cmd.RustLsp(command)
                            end, { buffer = bufnr, desc = desc })
                        end
                        map("<leader>rr", "runnables", "Rust runnables")
                        map("<leader>rm", "expandMacro", "Expand Rust macro")
                        map("<leader>rc", "openCargo", "Open Cargo.toml")
                    end,
                },
            }
        end
    end,
}
