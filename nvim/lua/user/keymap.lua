local keymap = function(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

vim.g.mapleader = ' '

-- Split resize
keymap('n', '<Leader>>', '10<C-w>>')
keymap('n', '<Leader><', '10<C-w><')

-- Abbreviations
keymap('n', '<Leader>q', ':q<CR>')
keymap('n', '<Leader>w', ':w<CR>')

-- NERDTree
keymap('n', '<leader>n', ':NvimTreeToggle<CR>')
keymap('n', '<C-n>', ':NvimTreeFocus<CR>')
keymap('n', '<C-t>', ':NvimTreeCollapse<CR>')
keymap('n', '<C-f>', ':NvimTreeFindFile<CR>')

-- Python
keymap('n', '<leader>l', ':! python3 -m black %; python3 -m isort %<CR>')
