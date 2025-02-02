--[[
LSP setup
--]]

-- else ~/.local/state/nvim/lsp.log will grow to huge size
vim.lsp.set_log_level "off"

-- add keymaps on attach of an lsp to current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("moellh", { clear = false }),
    callback = function(e)
        local opts = { buffer = e.buf }

        -- goto definition
        vim.keymap.set("n", "<leader>ld", function()
            vim.lsp.buf.definition()
        end, opts)

        -- goto definition
        vim.keymap.set("n", "<leader>li", function()
            vim.lsp.buf.implementation()
        end, opts)

        -- query symbols of workspace to quickfix window
        vim.keymap.set("n", "<leader>ls", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)

        -- calls code actions of current line
        vim.keymap.set("n", "<leader>la", function()
            vim.lsp.buf.code_action()
        end, opts)

        -- quicklists references of current token
        vim.keymap.set("n", "<leader>lr", function()
            vim.lsp.buf.references()
        end, opts)

        -- rename current token
        vim.keymap.set("n", "<leader>lm", function()
            vim.lsp.buf.rename()
        end, opts)

        -- displays function name, parameters and return type
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)

        -- show next diagnostic
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_prev()
        end, opts)

        -- show previous diagnostic
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_next()
        end, opts)

        vim.keymap.set("n", "<leader>lsl", "<CMD>LspStop ltex<CR>", opts)
    end,
})

return {

    "williamboman/mason-lspconfig.nvim",

    {
        --[[
        lsp features for neovim configuration
        --]]

        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },

    {
        -- required by lazydev.nvim
        "Bilal2453/luvit-meta",
        lazy = true,
    },

    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },

        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                automatic_installation = true,
                ensure_installed = {
                    "pyright", -- python
                    "lua_ls", -- lua
                    "jdtls", -- java
                    "ts_ls", -- js, ts
                    "marksman", -- markdown
                    "texlab", -- latex
                    "ltex", -- latex
                    "bashls", -- bash
                    "clangd", -- cpp
                    "rust_analyzer", -- rust
                    "bashls", -- bash
                    "cmake", -- cmake
                    "html", -- html
                },
            }

            local lspconfig = require "lspconfig"

            -- python
            lspconfig.pyright.setup {
                filetypes = { "python" },
            }
            lspconfig.lua_ls.setup { -- lua
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                    },
                },
            }
            lspconfig.ts_ls.setup {} -- js, ts
            lspconfig.marksman.setup {} -- markdown

            -- latex
            lspconfig.texlab.setup {
                root_dir = lspconfig.util.root_pattern(
                    ".latexmkrc",
                    ".texlabroot",
                    "texlabroot",
                    "Tectonic.toml",
                    "Makefile",
                    ".git"
                ),
            }
            lspconfig.ltex.setup {}

            lspconfig.bashls.setup {}

            lspconfig.clangd.setup {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--log=verbose",
                    "--limit-results=0",
                    "--suggest-missing-includes",
                },
                init_options = {
                    fallbackFlags = { "-std=c++17" },
                    clangdFileStatus = true,
                },
                root_dir = lspconfig.util.root_pattern(
                    "compile_commands.json",
                    ".clangd",
                    ".clang-format",
                    ".git"
                ),
            }

            lspconfig.cmake.setup {}

            lspconfig.html.setup {}
        end,
    },

    "mfussenegger/nvim-jdtls",

    {
        "barreiroleo/ltex_extra.nvim",
        ft = { "markdown", "tex", "bib" },
        dependencies = { "neovim/nvim-lspconfig" },
        -- yes, you can use the opts field, just I'm showing the setup explicitly
        config = function()
            require("ltex_extra").setup {
                load_langs = { "en-US", "de-DE" },
                -- your_ltex_extra_opts,
                server_opts = {
                    -- capabilities = your_capabilities,
                    on_attach = function(client, bufnr)
                        -- your on_attach process
                    end,
                    settings = {
                        ltex = {},
                    },
                },
            }
        end,
    },
}
