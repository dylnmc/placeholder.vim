
" insert a placeholder
inoremap <expr> <plug>(placeholder) placeholder#text()
inoremap <expr> <plug>(placeholderPrompt) placeholder#text(input('Default: '))

" select next placeholder
inoremap <silent> <plug>(placeholderNext) <c-g>u<esc>:call placeholder#snap(1)<cr>
nnoremap <silent> <plug>(placeholderNext) :call placeholder#snap(1)<cr>
snoremap <silent> <plug>(placeholderNext) <esc>:call placeholder#snap(1)<cr>
xnoremap <silent> <plug>(placeholderNext) <esc>:<c-u>call placeholder#select(1)<cr>
onoremap <silent> <plug>(placeholderNext) :<c-u>call placeholder#select(1)<cr>

" select prev placeholder
inoremap <silent> <plug>(placeholderPrev) <c-g>u<esc>:call placeholder#snap(0)<cr>
nnoremap <silent> <plug>(placeholderPrev) :call placeholder#snap(0)<cr>
snoremap <silent> <plug>(placeholderPrev) <esc>:call placeholder#snap(0)<cr>
xnoremap <silent> <plug>(placeholderPrev) <esc>:<c-u>call placeholder#select(0)<cr>
onoremap <silent> <plug>(placeholderPrev) :<c-u>call placeholder#select(0)<cr>

