local options = {
    number = true,
    mouse = 'a',
    numberwidth = 1,
    syntax = 'on',
    ruler = true,
    cursorline = true,
    showmatch = true,
    ts = 4,
    sw = 4,
    sts = 4,
    et = true,
    autoindent = true,
    laststatus = 2,
    hlsearch = true,
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    clipboard = 'unnamedplus',
}

vim.opt.matchpairs:append '<:>'

for k, v in pairs(options) do
    vim.opt[k] = v
end
