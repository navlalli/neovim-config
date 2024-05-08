vim.loader.enable()  -- byte compiles and caches Lua files

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General settings
vim.o.hlsearch = false
vim.opt.relativenumber = true 
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = '80'
vim.opt.mouse = 'a'
vim.cmd.colorscheme('gruvbox')

vim.cmd([[
autocmd BufRead * autocmd FileType <buffer> ++once
     \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

-- General keyboard shortcuts
vim.keymap.set('v', '<C-y>', '"+y', { desc = 'Copy to global clipboard' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-a>', '<C-w>8>', { desc = 'Increase window size horizontally' })
vim.keymap.set('n', '<C-s>', '<C-w>8<', { desc = '[S]hrink window size horizontally' })
vim.keymap.set('n', '<leader>a', '<C-w>8+', { desc = 'Increase window size vertically' })
vim.keymap.set('n', '<leader>d', '<C-w>8-', { desc = '[D]ecrease window size vertically' })

require('telescope/teleconfig')
require('lualine/llconfig')
require('treesitter/treeconfig')
require('lsp/lspconfig')
require('comment/comconfig')
require('cmp/cmpconfig')
require('snip/snipconfig')
require('run/run')

-- Plugins
return require('packer').startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'
  -- Colors
  use 'joshdick/onedark.vim'
  use 'EdenEast/nightfox.nvim'
  use 'ellisonleao/gruvbox.nvim'
  -- Line
  use 'nvim-lualine/lualine.nvim'
  -- Treesitter and lsp
  use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
  use 'neovim/nvim-lspconfig'
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
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  -- Code runner
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}
  -- Markdown preview
  use 'davidgranstrom/nvim-markdown-preview'
end)
