vim:
  plugins:
    - VundleVim/vundle.vim
    - chriskempson/base16-vim
    - ctrlpvim/ctrlp.vim
    - editorconfig/editorconfig-vim
    - rking/ag.vim
    - saltstack/salt-vim
    - scrooloose/nerdtree
    - tpope/vim-surround
    - vim-airline/vim-airline
    - vim-airline/vim-airline-themes
  config:
    core: |
      " Base16 colour theme
      set termguicolors
      let base16colorspace = 256
      colorscheme base16-ocean

      " IBeam in insert, underline in replace and block in normal
      let &t_SI = "\<Esc>[5 q"
      let &t_SR = "\<Esc>[3 q"
      let &t_EI = "\<Esc>[1 q"

      " Don't be irritating
      set title
      set visualbell
      set noerrorbells

      " Don't write temporary files
      set nobackup
      set noswapfile

      " Disable F1 for help
      nmap <F1> <Nop>

      " Hybrid line numbering
      set number
      set relativenumber

      " Allow wrapping lines, but don't break mid-word
      set wrap
      set linebreak

      " Draw a ruler at 80 characters
      set colorcolumn=80

      " Highlight matching bracket
      set showmatch

      " Automatically indent according to previous line
      set autoindent
      set copyindent

      " Indent in multiples of shiftwidth
      set shiftround

      " Enable syntax highlighting
      syntax on

      " Enable mouse across all modes
      set mouse=a

      " Mimic shell path completion
      set wildmode=list:longest

      " Get closer to PCRE semantics
      nnoremap / /\v
      vnoremap / /\v

      " Perform searches globally by default
      set gdefault

      " Ignore case during searching if pattern contains no capitals
      set ignorecase
      set smartcase

      " Highlight search results
      set hlsearch
      set incsearch

      " Save as root
      cmap w!! w !sudo tee >/dev/null %

      " Make leader and ex-commands more accessible
      let mapleader=","
      nnoremap ; :

      " Tab management and switching
      nnoremap <Leader>ti :tabedit<Enter>
      nnoremap <Leader>tx :tabclose<Enter>
      nnoremap <Leader>th :tabfirst<Enter>
      nnoremap <Leader>tl :tablast<Enter>
      nnoremap <Leader>tj :tabprevious<Enter>
      nnoremap <Leader>tn :tabnext<Enter>

      " Save all buffers on loss of focus
      autocmd FocusLost * :wa

      " File types
      autocmd FileType sls setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
    ag: |
      nnoremap <Leader>/ :Ag<Space>
    airline: |
      " Colour scheme
      let g:airline_theme = 'base16_ocean'

      " Tabline (buffer list)
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#buffer_idx_mode = 1
    nerdtree: |
      " Configuration
      let g:NERDTreeShowHidden = 1
      let g:NERDTreeQuitOnOpen = 1
      let g:NERDTreeMinimalUI = 1
      let g:NERDTreeDirArrows = 1

      " Show NERDTree unless path specified on CLI
      autocmd StdinReadPre * let s:std_in = 1
      autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

      " Close tab if NERDTree is the last window
      autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

      " Useful keybindings
      nnoremap <Leader>ft :NERDTreeToggle<Enter>
      nnoremap <silent> <Leader>ff :NERDTreeFind<Enter>
