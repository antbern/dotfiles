" To use dd to remove an item in the quickfix list
" Source: https://stackoverflow.com/a/56122471
nnoremap <buffer> <silent> dd <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>
