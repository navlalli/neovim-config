-- vim.loader.enable()  -- byte compiles and caches Lua files

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
vim.opt.splitright = true
vim.cmd.colorscheme('gruvbox')
vim.diagnostic.config({ virtual_text = true })

-- Terminal mode settings
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { desc = 'Escape terminal mode' })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>t', function() vim.cmd('vertical terminal') end, { desc = 'Open terminal in right split' })

vim.keymap.set('n', '<leader>p', function()
    -- Find the first available terminal buffer
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buftype == 'terminal' then
	    -- Save current buffer
	    vim.cmd('write')
	    -- Get name of current buffer
	    local fname = vim.api.nvim_buf_get_name(0)
	    local buf_dir = vim.fs.dirname(fname)
	    local ftype = vim.bo[0].filetype
            local job_id = vim.b[bufnr].terminal_job_id
            if job_id then
		vim.api.nvim_chan_send(job_id, "cd " .. buf_dir .. "\r")
		if ftype == "python" then
		    vim.api.nvim_chan_send(job_id, "python " .. fname .. "\r")
		    return
		elseif ftype == "sh" then
		    vim.api.nvim_chan_send(job_id, "bash " .. fname .. "\r")
		    return
		else
		    print("Non-implemented file type " .. ftype)
		    return
		end
            end
        end
    end
    print("No active terminal found")
end, { desc = "Python run current buffer" })

vim.api.nvim_create_autocmd({'BufEnter', 'TermOpen'}, {
    pattern = 'term://*',
    callback = function()
	vim.cmd.startinsert()
    end,
    })

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
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
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
vim.keymap.set('n', '<leader>u', function()
  vim.cmd('cd %:h')
  print("cwd changed to " .. vim.fn.getcwd())
end, { desc = '[u]pdate cwd to current file directory' })

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
require('fugitive')

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
    'nvim-treesitter/nvim-treesitter', branch = 'master',
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
       'nvim-telescope/telescope.nvim', tag = '0.2.*',
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
     -- git
     use 'tpope/vim-fugitive'
end)
