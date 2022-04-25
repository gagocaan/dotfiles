Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Specify a color theme and look cool
let g:airline_theme = 'dracula'

"Show the currently activated virtualenv to see if it recognizes the virtulenv(vim-extension of virtualenv)
let g:airline#extensions#virtualenv#enabled = 1

"Display errors and warnings from the Lint tool(ALE extension)
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'