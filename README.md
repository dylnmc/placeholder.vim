# placeholder.vim

*Placeholder plugin for vim done right.*

![animated image showing placeholder selection][placeholder_gif]

As you can see, this is very simple yet very powerful.

**Important**: If you want the dot operator (repeating) to work, you need to
also install [vim-repeat](https://github.com/tpope/vim-repeat/)!

## Example Vimrc

This is how I like to configure this plugin in my vimrc:

```vim
" Example Placeholder Mappings

if !has('nvim') && !has('gui_running')
    " allow M-h, M-l, and M-; to be mapped properly in term vim
    exe "set <m-h>=\<esc>h"
    exe "set <m-l>=\<esc>l"
    exe "set <m-;>=\<esc>;"

    if exists(':tnoremap')
        " fix above maps in terminal mode
        tnoremap <m-h> <esc>h
        tnoremap <m-l> <esc>l
        tnoremap <m-;> <esc>;
    endif
endif

" M-h  =>  select prev placeholder
imap <m-h> <c-g>u<esc>c<plug>(placeholderPrev)
nmap <m-h> c<plug>(placeholderPrev)
xmap <m-h> <plug>(placeholderPrev)
omap <m-h> <plug>(placeholderPrev)

" M-l  =>  select next placeholder
imap <m-l> <c-g>u<esc>c<plug>(placeholderNext)
nmap <m-l> c<plug>(placeholderNext)
xmap <m-l> <plug>(placeholderNext)
omap <m-l> <plug>(placeholderNext)

" M-;  =>  insert placeholder
imap <m-;> <plug>(placeholder)

" use vim-plug <https://github.com/junegunn/vim-plug> to install placeholder.vim
call plug#begin(printf('%s/%s/plugged', $HOME, has('nvim') ? '.config/nvim' :
\ (has('win32') || has('win64')) ? 'vimfiles' : '.vim'))
Plug 'dylnmc/placeholder.vim'
Plug 'tpope/vim-repeat'
" ...
call plug#end()
```

[placeholder_gif]:https://raw.githubusercontent.com/dylnmc/i/master/placeholder.gif

