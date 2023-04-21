local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = {
		"c",
		"go",
		"java",
		"rust",
		"python",

		"html",
		"css",
		"javascript",
		"typescript",

		"lua",
		"bash",

		"toml",
		"yaml",
		"json",

		"dockerfile",
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml" } },
})
