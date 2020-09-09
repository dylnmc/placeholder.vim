
if !exists('g:placeholder#text')
    let g:placeholder#text = '{@}'
endif

" get placeholder from buffer context if defined;
" else get placeholder from global context if defined;
" otherwise, use g:placeholder#text
function! placeholder#text()
    return get(b:, 'placeholder', get(g:, 'placeholder', g:placeholder#text))
endfunction

" get regular expression that matches the for placeholder
function! placeholder#regex()
    return '\V'.escape(placeholder#text(), '\/')
endfunction

" in insert/op-pending mode, select next placeholder, delete it, enter insert;
" in visual mode, select only next place holder and remain in visual mode;
" if no match, return to normal mode no matter what
function! placeholder#select(forwards, visual)
    let l:pat = placeholder#regex()
    if !search(l:pat, 'cw'.(a:forwards?'':'b'))
        if exists('?feedkeys')
            call feedkeys("\<c-bslash>\<c-n>", 'nx')
        endif
        return
    endif
    normal! v
    call search(l:pat, 'e')
    if (a:visual && col('.') ==# col('''>'))
        normal! v
        call search(l:pat, 'w'.(a:forwards?'':'b'))
        normal! v
        call search(l:pat, 'e')
    endif
    if !a:visual && v:operator == 'g@'
        silent! call repeat#set("g@\<plug>(placeholder".(a:forwards ? 'Next' : 'Prev').')')
    endif
endfunction

