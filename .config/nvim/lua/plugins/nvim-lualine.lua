local lualine = require("lualine")

lualine.setup({
	options = {
		theme = "ayu_dark",
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = {
			{ "mode", right_padding = 2 },
		},
		lualine_b = { "filename", "branch" },
		lualine_c = { "fileformat" },
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {
		lualine_a = {
			{
				"tabs",
				mode = 1, -- tab_nr(0), tab_name(1), both(2)
				max_length = vim.o.columns, -- occupy full tabline
				tabs_color = {
					active = nil, -- color for active tab
					inactive = nil, -- color for inactive tab
				},
			},
		},
	},
	extensions = { "fzf" },
})
