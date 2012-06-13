" pathogen simplifies plugin management
exec ':source ' . vimconfdir . '/.vim/bundle/vim-pathogen/autoload/pathogen.vim'
call pathogen#infect(vimconfdir . '/.vim/bundle')

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

" show end of line marker
set colorcolumn=81

" quick toggles
nmap <F1> :NERDTreeToggle<CR>
nmap <F2> :TagbarToggle<CR>
nmap <F3> :set wrap!<CR>

" automatically redraw the screen after running an external command
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

" hide redundant UI components
set guioptions+=LlRrb
set guioptions-=LlRrb

" improve the file menu
:amenu &File.Vertical\ Split-Open<Tab>:vsp :browse vsp<CR>

" handy Rails shortcuts
:menu Rails.Run\ server <Esc>:Silent xterm -hold -e rails server &<CR>
:menu Rails.Launch\ Ruby\ console <Esc>:Silent xterm -hold -e rails console &<CR>
:menu Rails.Launch\ DB\ console <Esc>:Silent xterm -hold -e rails db &<CR>
