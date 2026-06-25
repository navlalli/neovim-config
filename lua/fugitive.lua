vim.keymap.set('n', '<leader>di', function()
    vim.cmd('tabedit %')
    vim.cmd('Gvdiffsplit')
end, { desc = "Open git diff in a new tab" })

