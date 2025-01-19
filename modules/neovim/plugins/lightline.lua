vim.g.lightline = {
    colorscheme = 'wombat',
    active = {
        left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' }, { 'gitbranch' } },
        right = { { 'lineinfo' }, { 'percent' }, { 'filetype' } },
    },
    component_function = { gitbranch = 'gitbranch#name' },
    separator = { left = '', right = '' },
}
vim.o.showmode = false
