require("utils")

vim.g.mapleader = ","

-- syntax highlight for blocks
vim.g.markdown_fenced_languages = {
	"javascript",
	"java",
	"go",
	"python",
	"c",
	"sql",
	"rust",
}

-- stylua: ignore start
opt.wildoptions = "pum" -- display options using popup menu
opt.wildmenu    = true  -- Menu completion in command mode on <Tab>
opt.pumblend    = 17    -- floating window popup menu for completion on command line
opt.pumheight   = 10    -- limit completion items
opt.lazyredraw  = true  -- prevent unncessary redraw b/w macros

opt.wildmode = { "longest:full", "full" }

opt.showmode  = false -- disable message about different modes
opt.showmatch = true  -- show matching brackets when text indicator is over them
opt.showcmd   = true  -- show the command in the command mode
opt.cmdheight = 1     -- Height of the command bar

opt.shortmess:append("c") -- shorter messages

opt.wrap           = false
opt.relativenumber = true
opt.number         = true
opt.linebreak      = true -- do not break word b/w wrap words
opt.autoindent     = true -- follow indent rule from previous lines

opt.hidden     = true -- I like having buffers stay around
opt.smartcase  = true -- ... unless there is a capital letter in the query
opt.cursorline = true -- Highlight the current line

opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom

opt.autowrite  = true -- autowrite buffer when it's not focused
opt.timeoutlen = 500  -- faster timeout wait time
opt.updatetime = 300  -- Make updates happen faster
opt.scrolloff  = 4    -- Make it so there are always ten lines below my cursor

opt.hlsearch   = false -- Don't continue to highlight searched phrases.
opt.ignorecase = true  -- Ignore case when searching...
opt.incsearch  = true  -- Makes search act like search in modern browsers

-- No Backups..
opt.backup      = false
opt.writebackup = false
opt.swapfile    = false

-- tab specific
opt.tabstop     = 2
opt.shiftwidth  = 2
opt.softtabstop = 2
opt.expandtab   = true

opt.signcolumn  = "yes:1" -- Always show sign column
opt.showtabline = 2       -- Show tabline even if for one file is opened

opt.mouse      = "nv"          -- enable mouse for normal and visual mode
opt.clipboard  = "unnamedplus" -- use global clipboard buffer
opt.mousefocus = true

opt.laststatus    = 3    -- global statusline instead of window specific
opt.termguicolors = true -- truecolours for better experience

-- stylua: ignore end

-- Fillchars
opt.fillchars = {
	vert = "│",
	fold = "⠀",
	eob = " ", -- suppress ~ at EndOfBuffer
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

-- infinite undo history
opt.undofile = true

-- use ripgrep as grepprg
if fn.executable("rg") > 0 then
	vim.o.grepprg = "rg --no-heading --smart-case --vimgrep --follow $*"
	vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
end

require("cmd")
require("autocmd")
require("mappings")
require("terminal")

require("plugins.fzf")
require("plugins.lazy")

require("plugins.treesitter")
require("plugins.nvim-lualine")

require("plugins.nvim-cmp")
require("plugins.indentline")
require("plugins.nvim-autopairs")
require("plugins.vim-table-mode")

require("plugins.ayu-vim")

-- https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
-- Run after the colorscheme as the colorsheme changes it
-- command [[highlight Comment cterm=italic gui=italic]]

opt.background = "dark"
command([[
  highlight Comment    cterm=none guibg=none guifg=none
  highlight CursorLine cterm=none guibg=none guifg=none

  colorscheme ayu
]])

--opt.colorcolumn="80"
