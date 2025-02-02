-- remove trailing whitespaces on write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = "moellh",
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

return {

    {
        --[[
        formatting with external formatters
        --]]

        "stevearc/conform.nvim",

        opts = {
            notify_on_error = false,

            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { "prettierd" },
                java = { "google-java-format" },
                cpp = { "clang-format" },
                cuda = { "clang-format" },
                bash = { "shfmt" },
                bib = { "bibtex-tidy" },
            },

            formatters = {
                black = {
                    prepend_args = { "--line-length", "80" },
                },
                ["bibtex-tidy"] = {
                    args = {
                        "--curly",
                        "--wrap=80",
                        "--space=4",
                        "--blank-lines",
                    },
                },
            },
        },

        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>f",
                function()
                    require("conform").format { async = true }
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
    },

    {
        --[[
        install formatters using mason
        --]]

        "zapling/mason-conform.nvim",
        config = function()
            require("mason-conform").setup()
        end,
    },
}
