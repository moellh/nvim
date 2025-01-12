vim.g.netrw_banner = 0

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },

    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
}
