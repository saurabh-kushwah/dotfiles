vim.api.nvim_create_user_command("StackFormat", function(args)
	vim.api.nvim_command([[%s/\\n/\r/g]])
	vim.api.nvim_command([[%s/\\t/\t/g]])
end, { nargs = 0 })

vim.api.nvim_create_user_command("Tabedit", function(args)
	for file in args do
		print(file)
	end
end, { nargs = 1 })

vim.api.nvim_create_user_command("W", function(args)
  vim.api.nvim_command([[:write]])
end, { nargs = 0 })
