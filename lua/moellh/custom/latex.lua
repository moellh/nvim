return {
    {
        'lervag/vimtex',
        lazy = false,
        init = function()
            -- VimTeX configuration goes here

            -- don't show quickfix window after compilation
            vim.g.vimtex_quickfix_mode = 0
        end,
        keys = {
            { '<leader>rl', '<Plug>(vimtex-compile)' }
        }
    },
}
