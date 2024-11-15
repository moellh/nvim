return {
    {
        'lervag/vimtex',
        lazy = false,
        init = function()
            -- VimTeX configuration goes here
        end,
        keys = {
            { '<leader>rl', '<Plug>(vimtex-compile)' }
        }
    },
}
