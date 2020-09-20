
if !exists('g:placeholder#text')
    let g:placeholder#text = '{@}'
endif
if !exists('g:placeholder#sep')
    let g:placeholder#sep = ':'
endif
if !exists('g:placeholder#seppos')
    let g:placeholder#seppos = 2
endif
if !exists('g:placeholder#verbosity')
    let g:placeholder#verbosity = 1
endif

function! s:warn(msg)
    if g:placeholder#verbosity is 0
        return
    endif
    echohl WarningMsg
    unsilent echom a:msg
    echohl NONE
endfunction

function! s:error(msg)
    if g:placeholder#verbosity < 2
        return
    endif
    echohl ErrorMsg
    unsilent echom a:msg
    echohl NONE
endfunction

" get placeholder from buffer context if defined;
" else get placeholder from global context if defined;
" otherwise, use g:placeholder#text
function! placeholder#text(...)
    let text = get(b:, 'placeholder_text', g:placeholder#text)
    if a:0
        let out  = strpart(text, 0, g:placeholder#seppos)
        let out .= g:placeholder#sep
        let out .= a:1
        let out .= strpart(text, g:placeholder#seppos)
        return out
    endif
    return text
endfunction

" get regular expression that matches the for placeholder
function! placeholder#regex()
    let text = g:placeholder#text
    let reg  = '\m'
    let reg .= escape(strpart(text, 0, g:placeholder#seppos), '^$.*~\[]')
    let reg .= '\%('
    let reg .= escape(g:placeholder#sep, '^$.*~\[]')
    let reg .= '\(.\{-}\)\)\?'
    let reg .= escape(strpart(text, g:placeholder#seppos), '^$.*~\[]')
    return reg
endfunction

" snap to next placeholder and:
" - no default text? enter insert mode
" - default text? insert default text and select
function! placeholder#snap(forwards, ...)
    let savs = [@-, @", @/]
    let zsav = @0
    if placeholder#select(a:forwards)
        normal! ygv"_d
        if a:0
            execute 'normal!' '".'.'Pp'[col("'[") == col('$')]
        else
            startinsert
            call setpos('.', getpos("'["))
            " execute 'normal!' 'Pp'[col("'[") == col('$')]
            " execute "normal! `[v`]\<c-g>"
            call setreg('0', substitute(@", placeholder#regex(), '\1', ''))
            if empty(@0)
                let @0 = zsav
            else
                call s:warn('@0 -> "'.escape(@0, '"\').'"')
            endif
        endif
    endif
    call repeat#set(":call placeholder#snap(".a:forwards.", 1)\<cr>")
    let [@-, @", @/] = savs
endfunction

" visually select next placeholder; return 1 if found else 0
function! placeholder#select(forwards)
    let pat = placeholder#regex()
    if !a:forwards && !search(pat, 'eb') || !search(pat, a:forwards ? 'cw' : 'cwb')
        call s:warn('No placeholder found!')
        return 0
    endif
    normal! v
    call search(pat, 'e')
    if v:operator == 'g@'
        silent! call repeat#set("g@:call placeholder#select(".a:forwards.")\<cr>")
    endif
    return 1
endfunction

