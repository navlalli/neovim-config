require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
    ensure_installed = { "python", "bash" },
 
    highlight = {
       enable = true,
       additional_vim_regex_highlighting = false,
    },
} 

