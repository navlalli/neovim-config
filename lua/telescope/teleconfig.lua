-- Telescope
require('telescope').setup{
}

require('telescope').load_extension('fzf')

-- Keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files <CR>", {}) -- FindFiles (current directory)
-- vim.keymap.set('n', '<leader>hh', ":Telescope find_files cwd=~/navScripts/ <CR>", {})  -- Also works
vim.keymap.set('n', '<leader>fn', "<cmd>Telescope find_files cwd=~/navScripts/ <CR>", {}) -- FindNav
vim.keymap.set('n', '<leader>fh', "<cmd>Telescope find_files cwd=~/OneDrive/PhD/howTo/ <CR>", {}) -- FindHow
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
