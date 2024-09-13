---@type ChadrcConfig
local M = {}

M.ui = { theme = 'catppuccin' }
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
-- Neovide configuration
if vim.g.neovide then
    vim.g.neovide_show_border = true
end

return M
