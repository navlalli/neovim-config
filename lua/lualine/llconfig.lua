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
