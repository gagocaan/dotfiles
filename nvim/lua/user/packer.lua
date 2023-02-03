-- Install packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Initialize packer
require('packer').init({
    compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'solid' })
        end,
    },
})

-- Install plugins
local use = require('packer').use

-- Dracula Theme
use 'Mofiqul/dracula.nvim'

-- LuaLine
use({
    'nvim-lualine/lualine.nvim',
    config = function()
        require('user.plugins.lualine')
    end,
})

-- Auto-pairs
use 'jiangmiao/auto-pairs'

-- Float Term
use({
    'voldikss/vim-floaterm',
    config = function()
        require('user.plugins.float-term')
    end,
})

-- Nvim tree
use({
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
        require('user.plugins.nvim-tree')
    end,
})

-- Automatically install plugins on first run
if packer_bootstrap then
    require('packer').sync()
end

-- Automatically regenerate compiled loader file on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
