local colors = require("ayu.colors")
colors.generate() -- Pass `true` to enable mirage

local ayu = require("ayu")

ayu.setup({
	overrides = function()
		return { Comment = { fg = colors.comment } }
	end,
})

ayu.colorscheme({
	mirage = false,
	overrides = {},
})
