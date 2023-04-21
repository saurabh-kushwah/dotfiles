-- Only required if you have packer in your `opt` pack

local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	-- TODO: Maybe handle windows better?
	if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
		return
	end

	local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

	vim.fn.mkdir(directory, "p")

	local out = vim.fn.system(
		string.format('git clone %s "%s"', "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
	)

	print(out)
	print("Downloading packer.nvim...")
	print("( You'll need to restart now )")

	return
end

return require("packer").startup({
	function(use)
		use({ "wbthomason/packer.nvim", opt = true })

		-- Misc
		use("godlygeek/tabular")
		use("tpope/vim-surround")
		use("windwp/nvim-autopairs")

		-- indention
		use("lukas-reineke/indent-blankline.nvim")

		-- AutoComplete
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")

		-- Post-install/update hook with neovim command
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

		-- tables..
		use("dhruvasagar/vim-table-mode")

		-- statusline
		use("nvim-lualine/lualine.nvim")

		-- fzf
		use("junegunn/fzf.vim")

		-- ayu-vim
		use("Shatur/neovim-ayu")
	end,
})
