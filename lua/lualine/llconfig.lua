-- lualine configuration
require('lualine').setup {
    options = {
	theme = 'onedark',
	section_separators = '',
	component_separators = ''
    },
    sections = {
	lualine_b = {'branch'},
	lualine_c = {'filename'},
	lualine_x = {''}
    }
}
