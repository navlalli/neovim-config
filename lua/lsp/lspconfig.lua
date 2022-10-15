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

