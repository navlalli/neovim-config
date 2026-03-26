vim.loader.enable()  -- byte compiles and caches Lua files

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General settings
vim.o.hlsearch = false
vim.opt.number = true
vim.opt.relativenumber = true 
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = '80'
vim.opt.mouse = 'a'
vim.cmd.colorscheme('gruvbox')
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' }) -- Prevents comments rolling over
  end,
})

-- Return to previous place in file
vim.cmd([[
autocmd BufRead * autocmd FileType <buffer> ++once
     \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

-- Highlight on yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- General keyboard shortcuts
vim.keymap.set('v', '<C-y>', '"+y', { desc = 'Copy to global clipboard' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

require('telescope-config')
require('lualine-config')
require('lsp-config')
require('comment-config')
require('cmp-config')
require('run-config')
require('oil-config')
require('treesitter-config')
require('snip-config')
require('todo-comments').setup()

-- Plugins
return require('packer').startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'
  -- Colors
  use 'joshdick/onedark.vim'
  use 'ellisonleao/gruvbox.nvim'
  -- Line
  use 'nvim-lualine/lualine.nvim'
  -- Treesitter and lsp
  use {
	'nvim-treesitter/nvim-treesitter',
	run = function()
	    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
	    ts_update()
	end,
  }
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }
  -- Commenting
  use 'numToStr/Comment.nvim'
  -- Completion engine 
  use 'hrsh7th/nvim-cmp'
  -- Completion sources 
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  -- Snippets 
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  -- Displaying
  use 'onsails/lspkind.nvim'
  -- Fuzzy
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.2.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  -- Code runner
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}
  -- Markdown preview
  use 'davidgranstrom/nvim-markdown-preview'
  -- Oil
  use 'stevearc/oil.nvim'
  -- Todo
  use 'folke/todo-comments.nvim'
end)
