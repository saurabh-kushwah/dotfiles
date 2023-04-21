_G.term_buf = 0
_G.term_win = 0

function TermToggle(height)
	if vim.fn.win_gotoid(term_win) > 0 then
		command("hide")
	else
		-- occupy only the split width
		command("new")
		command("resize " .. height)

		-- make sure the command exists otherwise always fails
		success, result = pcall(command, "buffer " .. term_buf)

		if not success then
			vim.fn.termopen(env.SHELL, { detach = 0 })
			term_buf = vim.fn.bufnr("")

			opt.bufhidden = "hide"
			opt.buflisted = false
			opt.showmatch = false

			opt.number = false
			opt.relativenumber = false
		end

		command("startinsert")
		term_win = vim.fn.win_getid()
	end
end

-- Terminal go back to normal mode
tnoremap("jk", [[<C-\><C-n>]])

command([[command! -bang Terminal lua TermToggle(15)]])

-- Toggle terminal on/off (neovim)
nnoremap("<F1>", ":lua TermToggle(15)<CR>")
inoremap("<F1>", "<Esc>:lua TermToggle(15)<CR>")
tnoremap("<F1>", [[<C-\><C-n>:lua TermToggle(15)<CR>]])

-- Move between windows terminal
tnoremap("<A-h>", [[<C-\><C-n><C-w>h]])
tnoremap("<A-j>", [[<C-\><C-n><C-w>j]])
tnoremap("<A-k>", [[<C-\><C-n><C-w>k]])
tnoremap("<A-l>", [[<C-\><C-n><C-w>l]])

command([[
  autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
]])

