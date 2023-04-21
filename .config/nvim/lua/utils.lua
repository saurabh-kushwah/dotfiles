-- Register it as global function as frequently used

local global = _G

global.nnoremap = function(lhs, rhs, silent)
	vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

global.inoremap = function(lhs, rhs)
	vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true })
end

global.vnoremap = function(lhs, rhs)
	vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true })
end

global.xnoremap = function(lhs, rhs)
	vim.api.nvim_set_keymap("x", lhs, rhs, { noremap = true })
end

global.tnoremap = function(lhs, rhs)
	vim.api.nvim_set_keymap("t", lhs, rhs, { noremap = true })
end

global.fn = vim.fn
global.env = vim.env
global.opt = vim.opt
global.command = vim.cmd
