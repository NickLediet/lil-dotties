---@type ChadrcConfig
local M = {}

M.ui = { theme = 'catppuccin' }
M.plugins = "custom.plugins"

vim.opt.relativenumber = true
vim.opt.nu = true
vim.o.statuscolumn = '%s %l %r'

return M
