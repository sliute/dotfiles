" legacy code sucks
set nocompatible

" automatic reloading is cool
au! BufWritePost .vimrc source %

" miscellaneous editing preferences
set number
set nowrap

" set indentation widths, spaces < tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent

" customise the above based on language
filetype plugin indent on
autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et

" pretty colours -- like a freaking rainbow!
syntax on
colorscheme zenburn

" write to files not owned by us
cmap w!! w !sudo tee >/dev/null %

" highlight whitespace
set showbreak=>\ \ \

" make window splits easier to navigate /*{{{*/
nnoremap <A-Up> :normal <c-r>=SwitchWindow('+')<CR><CR>
nnoremap <A-Down> :normal <c-r>=SwitchWindow('-')<CR><CR>
nnoremap <A-Left> :normal <c-r>=SwitchWindow('<')<CR><CR>
nnoremap <A-Right> :normal <c-r>=SwitchWindow('>')<CR><CR>

function! SwitchWindow(dir)
  let this = winnr()
  if '+' == a:dir
    execute "normal \<c-w>k"
    elseif '-' == a:dir
    execute "normal \<c-w>j"
    elseif '>' == a:dir
    execute "normal \<c-w>l"
    elseif '<' == a:dir
    execute "normal \<c-w>h"
  else
    echo "oops. check your ~/.vimrc"
    return ""
  endif
endfunction
" /*}}}*/


