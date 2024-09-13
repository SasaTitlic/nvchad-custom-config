-- In your chadrc.lua or a new file like custom/init.lua:

local opt = vim.opt

-- Enable relative line numbers
opt.relativenumber = true
opt.number = true  -- This enables hybrid line numbers (current line shows absolute number)

-- You can add more core settings here if needed
-- For example:
-- opt.scrolloff = 8  -- Start scrolling when 8 lines from top or bottom
-- opt.sidescrolloff = 8  -- Start scrolling when 8 columns from left or right
-- opt.wrap = false  -- Disable line wrap

-- If you want to ensure these settings are applied after NvChad's defaults:
local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    opt.relativenumber = true
    opt.number = true
    -- Add any other settings here that you want to ensure override NvChad defaults
  end,
})

vim.api.nvim_create_user_command('CdInBufDir', 'execute "lcd %:p:h"', {})

vim.cmd('source ' .. vim.fn.stdpath('config') .. '/lua/custom/commands.vim')

vim.opt.termguicolors = true
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.opt.clipboard = "unnamedplus"
