
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'StanAngeloff/php.vim'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"" set tab width to be 4 spaces
set tabstop=4
" set the size of an 'indent' to be 4 spaces
set shiftwidth=4
" Insert 4 spaces when pressing tab instead of the tab character
set expandtab

autocmd vimenter * ++nested colorscheme gruvbox
set background=dark
"set background=light

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

