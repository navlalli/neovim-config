:set number
:set relativenumber
:set shiftwidth=4
:autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
:set mouse=a
:set nohlsearch
:set cursorline
:set scrolloff=8
:set colorcolumn=80

let mapleader = " "

" Telescope
nnoremap <Space>ff <cmd>Telescope find_files<cr>
nnoremap <Space>fg <cmd>Telescope live_grep<cr> 

call plug#begin()
" Colors
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'https://github.com/ellisonleao/gruvbox.nvim'
" Line
Plug 'nvim-lualine/lualine.nvim'
" Treesitter and lsp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
" Commenting
Plug 'numToStr/Comment.nvim'
" Completion engine 
Plug 'hrsh7th/nvim-cmp'
" Completion sources 
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
" Snippets 
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/cmp-vsnip'
" Displaying
Plug 'onsails/lspkind.nvim'
" Fuzzy
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
call plug#end()

colorscheme gruvbox " nightfox  

lua << END
-- lualine configuration
require('lualine').setup {
    options = {
	theme = 'onedark',
	section_separators = '',
	component_separators = ''
    },
    sections = {
	lualine_b = {'filename'},
	lualine_c = {''},
	lualine_x = {''}
    }
}

-- treesitter configuration
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
    ensure_installed = { "python", "bash" },
 
    highlight = {
       enable = true,
       additional_vim_regex_highlighting = false,
    },
} 

-- lsp configuration 
-- bash
require'lspconfig'.bashls.setup{
    on_attach = function()
    print("Attached bashls")
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {buffer=0})
    end,  
}

-- python 
require'lspconfig'.pyright.setup{
    on_attach = function()
    print("Attached pyright")
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {buffer=0})
    end,  
}

-- nvim-cmp configuration
local cmp = require'cmp'
local lspkind = require'lspkind'
local ls = require'luasnip'
cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), 
      }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp', keyword_length = 2, max_item_count = 6 },
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'buffer', keyword_length = 2, max_item_count = 6},
    }),

    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
	require('luasnip').lsp_expand(args.body)
      end,
    },

    formatting = {
	-- How to set up nice formatting for your sources.
	format = lspkind.cmp_format {
	  with_text = true,
	  menu = {
	    buffer = "[BUF]",
	    nvim_lsp = "[LSP]",
	    path = "[PATH]",
	    luasnip = "[SNIP]",
	  },
	},
      },
})

-- luasnip
ls.config.set_config{
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
	ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
	ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set({ "i" }, "<c-l>", function()
    if ls.choice_active() then
	ls.change_choice(1)
    end
end)

ls.add_snippets("all", {
	-- Available in any file type
    ls.snippet("test", {ls.text_node("printing static text"),
    }),
    ls.parser.parse_snippet("fprint", "print(f\"{$1 = }\")$0"),
    ls.parser.parse_snippet("def", "def $1($2):$0"),
    ls.parser.parse_snippet("sub", "fig, ax = plt.subplots($1)"),

    },
    {
	key = "all",
})

-- Telescope
require('telescope').setup{
}

require('telescope').load_extension('fzf')

-- Comment.nvim 
require('Comment').setup{ 
    --Add a space b/w comment and the line
    padding = true,

    ---Whether the cursor should stay at its position
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ignore = nil,

    ---LHS of toggle mappings in NORMAL + VISUAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },

    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },

    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---NOTE: If `mappings = false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
        ---Extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = false,
    },
}

END
