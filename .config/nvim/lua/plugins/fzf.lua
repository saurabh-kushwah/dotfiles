-- [Buffers] Jump to the existing window if possible
vim.g.fzf_buffers_jump = 1

-- Preview window on the upper side of the window with 40% height,
-- hidden by default, alt-x to toggle (like hover)
vim.g.fzf_preview_window = { "down:70%:hidden", "alt-x" }

vim.g.fzf_action = {
	enter = "tab split",
}

-- Popup window (center of the current window)
-- vim.g.fzf_layout = { window = "enew" }

if os.getenv("TMUX") then
	vim.g.fzf_layout = { tmux = "--no-scrollbar -p80%,75%" }
else
	vim.g.fzf_layout = { window = { width = 0.8, height = 0.75, border = "rounded" } }
end

vim.g.fzf_colors = {
	fg = { "fg", "Normal" },
	bg = { "bg", "Normal" },
	hl = { "fg", "Comment" },
	["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
	["bg+"] = { "bg", "CursorLine", "CursorColumn" },
	["hl+"] = { "fg", "Statement" },
	info = { "fg", "PreProc" },
	border = { "fg", "Ignore" },
	prompt = { "fg", "Conditional" },
	pointer = { "fg", "Exception" },
	marker = { "fg", "Keyword" },
	spinner = { "fg", "Label" },
	header = { "fg", "Comment" },
}

nnoremap("<a-s>", ":Rg<CR>")
nnoremap("<a-f>", ":Files<CR>")
nnoremap("<a-b>", ":Buffers<CR>")
nnoremap("<a-c>", ":Commits<CR>")
nnoremap("<a-w>", ":Windows<CR>")

nnoremap("<leader>fc", ":Commands<CR>")
nnoremap("<leader>fm", ":Commands<CR>")

nnoremap("<leader>fh", ":History<CR>")
nnoremap("<leader>fm", ":History:<CR>")
nnoremap("<leader>fs", ":History/<CR>")
