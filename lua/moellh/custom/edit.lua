-- places spaces instead of tabs
vim.opt.expandtab = true

-- interpret 4 spaces as tab
vim.opt.tabstop = 4

-- shifts insert/delete 4 spaces
vim.opt.shiftwidth = 4

-- tab/backspace create/delete 4 spaces
vim.opt.softtabstop = 4

-- auto-indent new lines
vim.opt.autoindent = true

-- smart-indenting
vim.opt.smartindent = true

-- enable mouse
vim.opt.mouse = "a"
vim.o.mousescroll = "ver:1,hor:1"

-- Move selected lines up/down one line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- delete to black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- start substituting token, for similar name
-- - case-sensitive
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { noremap = true, desc = "Substitute token under cursor" }
)

-- copy entire file content to clipboard
vim.keymap.set("n", "<leader>yy", [[:%y+<CR>]])

return {

    "tpope/vim-sleuth", -- auto-detect tabstop & shiftwidth

    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
        -- keymaps:
        -- gcc: toggle comment line
        -- gcb: toggle comment block of code
        -- gc:  toggle comment visual region
        -- gb:  toggle comment visual region as block
    },

    {
        "mbbill/undotree",

        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },

    {
        "stevearc/aerial.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("aerial").setup {
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set(
                        "n",
                        "{",
                        "<cmd>AerialPrev<CR>",
                        { buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "}",
                        "<cmd>AerialNext<CR>",
                        { buffer = bufnr }
                    )
                end,
            }
            -- You probably also want to set a keymap to toggle aerial
            vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },

    {
        "yetone/avante.nvim",

        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change

        opts = {
            provider = "copilot",
            auto_suggestions_provider = "copilot",
            copilot = {
                max_tokens = 4096,
            },
            hints = { enabled = false },
        },

        -- `make BUILD_FROM_SOURCE=true` to build from source
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
        },
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup {
                suggestion = {
                    auto_trigger = true,
                },
            }
        end,
    },

    {
        "danymat/neogen",
        config = true,
    },
}
