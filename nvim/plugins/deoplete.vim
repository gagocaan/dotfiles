Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#enable_at_startup = 1

Plug 'zchee/deoplete-jedi'

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
