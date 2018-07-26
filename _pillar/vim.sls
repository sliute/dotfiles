vim:
  plugins:
    - VundleVim/vundle.vim
    - chriskempson/base16-vim
    - ctrlpvim/ctrlp.vim
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
      colorscheme base16-default-dark

      " IBeam in insert, underline in replace and block in normal
      let &t_SI = "\<Esc>[6 q"
      let &t_SR = "\<Esc>[4 q"
      let &t_EI = "\<Esc>[2 q"

      " Don't write temporary files
      set nobackup
      set noswapfile

      " Hybrid line numbering
      set number
      set relativenumber

      " Enable syntax highlighting
      syntax on

      " File types
      autocmd FileType sls setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

      " Mimic shell path completion
      set wildmode=list:longest

      " Highlight search results
      set hlsearch
      set incsearch

      " Save as root
      cmap w!! w !sudo tee >/dev/null %
    airline: |
      " Colour scheme
      let g:airline_theme = 'base16color'

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
