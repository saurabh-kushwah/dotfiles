local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Misc
  "godlygeek/tabular",
  "tpope/vim-surround",
  "windwp/nvim-autopairs",

  -- indention
  "lukas-reineke/indent-blankline.nvim",

  -- AutoComplete
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",

  "nvim-treesitter/nvim-treesitter",

  -- tables..
  "dhruvasagar/vim-table-mode",

  -- statusline
  "nvim-lualine/lualine.nvim",

  -- fzf
  "junegunn/fzf.vim",

  -- ayu-vim
  "Shatur/neovim-ayu"
})
