---@type ChadrcConfig
local M = {}

M.ui = { theme = 'catppuccin' }
M.plugins = "custom.plugins"

-- Vim Settings
vim.opt.relativenumber = true
vim.opt.nu = true
vim.o.statuscolumn = '%s %l %r %s'

-- custom keymaps
vim.keymap.set("n", "<leader>mg","<cmd> MavenExec <CR>")

return M
