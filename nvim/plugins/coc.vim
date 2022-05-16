Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code action on <leader>a
vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a <Plug>(coc-codeaction-selected)<CR>

" Format action on <leader>f
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Goto definition
nmap <silent> gd <Plug>(coc-definition)
" Open definition in a split window
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L


" Automatically install coc-plugins
" coc-spell-checker: The general spell checker for neovim
" coc-prettier: A very popular code formatter
" coc-git: A git plugin to show which line is added/deleted and not committed
" coc-pyright: The main Python plugin I use
" coc-json: JSON file formatting plugin
" coc-docker: Dockerfile and docker-compose formatters
" coc-yaml: Yaml plugin for Kubernetes and terraform files
let g:coc_global_extensions = ['coc-spell-checker', 'coc-prettier', 'coc-git', 'coc-pyright', 'coc-json', 'coc-docker', 'coc-yaml']
