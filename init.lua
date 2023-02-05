vim.cmd([[
set number
set relativenumber
set shiftwidth=4
autocmd BufRead * autocmd FileType <buffer> ++once
     \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
set mouse=a
set nohlsearch
set cursorline
" set scrolloff=8
set colorcolumn=80
]])

vim.g.mapleader = " "
vim.cmd([[colorscheme gruvbox]])

-- General keyboard shortcuts
vim.keymap.set('v', '<C-y>', '"+y', {})


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
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  -- Code runner
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}
end)
