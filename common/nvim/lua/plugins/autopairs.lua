return {
    "windwp/nvim-autopairs",

    event = "InsertEnter",

    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,

            ts_config = {
                java = false,
                javascript = { "template_string" },
                lua = { "string" },
            },
        })
    end,
}
