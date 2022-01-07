"--------------------------------------------------------------------------
" Ajustes Generales
"--------------------------------------------------------------------------

" Mostrar numero de linea
set number

" Manejar el cursor con el mouse
set mouse=a

" Numero de linea sin espacio a la izquierda
set numberwidth=1

" Activa la sintaxis del archivo si es detectada
syntax on

" Muestra la posicion del cursor en filas y columnas
set ruler

" Crea una linea horizontal donde se encuentre el cursor
set cursorline

" Resalta los paretesis
set showmatch

" Ajusta la identacion y tabulaciones a 4 espacios
set ts=4 sw=4 sts=4 et autoindent

" Muestra el numero de linea relativo al cursor
" set relativenumber

" Muestra la ruta del archivo y la ultima ubicacion del cursor
set laststatus=2

" Sombrea todos los resultados de la busqueda
set hlsearch

" Sobrea las coincidencias de busqueda a media que se escribe
set incsearch

" Ignora las mayusculas/minisculas en las busquedas
set ignorecase

" A menos que esten capitalizadas
set smartcase

" Elimina la informacion del terminal para que solo se vea lightline
set noshowmode

" Permite compartir el portapapeles entre vim y la maquina
set clipboard=unnamed

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = "\<space>"

" Split resize
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

" Abbreviations
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

" NERDTree
nnoremap <leader>b :NERDTreeFocus<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/nerdtree.vim

call plug#end()

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Tema de VIM
colorscheme dracula
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif