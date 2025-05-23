vim.opt.undofile = true -- safe undo history to file
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

--[[
-- Windows, Panes
--]]

vim.opt.splitbelow = true -- vertical split to bottom
vim.opt.splitright = true -- horizontal split to right

vim.opt.number = true -- show current line number
vim.opt.relativenumber = true -- show relative line numbers for upper/lower lines
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.showmode = false -- status line without mode (use plugin instead)

vim.opt.termguicolors = true -- 24 bit UI colors
vim.g.have_nerd_font = true -- variable to enable nerd-font features

vim.opt.guicursor = "" -- shows block in insert-mode as cursor

vim.opt.colorcolumn = "81,121" -- highlights column 81 & 121
vim.opt.cursorline = true -- highlights line of cursor

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

--[[
-- Search, Replace
--]]

vim.opt.ignorecase = true -- ignores casing
vim.opt.smartcase = true -- except if capital letter exists

vim.opt.inccommand = "split" -- :%s shows lines in split window

vim.opt.hlsearch = true -- highlight search results

--[[
-- Default Keymaps
--]]

vim.g.mapleader = " " -- set <leader> key to <Space>
vim.g.maplocalleader = " " -- set <leader> for local buffer

vim.keymap.set("n", "<esc>", "<cmd>:nohls<cr>", {
    desc = "Switch to Normal, Clear search highlights",
})

--[[
-- Diagnostics
--]]

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
    desc = "Go to previous [D]iagnostic message",
})

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
    desc = "Go to next [D]iagnostic message",
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
    desc = "Show diagnostic [E]rror messages",
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
    desc = "Open diagnostic [Q]uickfix list",
})

-- setup Lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- load plugins via Lazy
require("lazy").setup({
    spec = "moellh.custom", -- plugins are in custom/ directory
    change_detection = {
        notify = false, -- don't show notification on changes
    },
}, {})

local kitty_theme = vim.fn.system [[\
    grep '# name' ~/.config/kitty/current-theme.conf | \
    awk 'BEGIN { ORS = "" } {print $3}'
]]
if kitty_theme == "Catppuccin-Latte" then
    vim.cmd.colorscheme "catppuccin-latte"
else
    vim.cmd.colorscheme "catppuccin-mocha"
end
