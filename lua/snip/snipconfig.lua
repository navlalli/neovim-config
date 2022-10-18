-- luasnip
local cmp = require'cmp'
local lspkind = require'lspkind'
local ls = require'luasnip'
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

-- Save the file first and then resource snipconfig with this keymap to view new snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/snip/snipconfig.lua<CR>")
-- require("luasnip.loaders.from_lua").load({ paths = { "./snippets" } })

ls.add_snippets("all", {
	-- Available in any file type
    ls.snippet("test", {ls.text_node("printing static text"),
    }),
    ls.parser.parse_snippet("fprint", "print(f\"{$1 = }\")$0"),
    ls.parser.parse_snippet("def", "def $1($2):$0"),
    ls.parser.parse_snippet("sub", "fig, ax = plt.subplots($1)"),
    ls.parser.parse_snippet("reload", "!!Reloaded!!!"),

    },
    {
	key = "all",
})

-- ls.add_snippets("all", {
-- 	-- Available in any file type
--     ls.snippet("test", {ls.text_node("printing static text"), }),
--     ls.parser.parse_snippet("fprint", "print(f\"{$1 = }\")$0"),
--     ls.parser.parse_snippet("def", "def $1($2):$0"),
--     ls.parser.parse_snippet("sub", "fig, ax = plt.subplots($1)"),
--     },
--     {
-- 	key = "all",
-- })
