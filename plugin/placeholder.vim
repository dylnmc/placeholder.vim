
" insert a placeholder; eg map: imap <c-l> <plug>(placeholder)
inoremap <expr> <plug>(placeholder) placeholder#text()

" select next placeholder; eg map: nmap <c-n> <plug>(placeholderNext)
xnoremap <silent> <plug>(placeholderNext) :<c-u>call placeholder#select(1, 1)<cr>
onoremap <silent> <plug>(placeholderNext) :<c-u>call placeholder#select(1, 0)<cr>
xnoremap <silent> <plug>(placeholderPrev) :<c-u>call placeholder#select(0, 1)<cr>
onoremap <silent> <plug>(placeholderPrev) :<c-u>call placeholder#select(0, 0)<cr>

