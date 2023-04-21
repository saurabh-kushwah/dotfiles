-- remove trailing whitespaces before write
command([[
  autocmd BufWritePre * silent! %s/\s\+$//e
  autocmd FileType yaml setlocal nowrap softtabstop=2 tabstop=2 expandtab
]])
