-- neovim/options.lua

-- Maps <Leader> in keybindings to space bar
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clipboard fix
vim.o.clipboard = 'unnamedplus'

vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.updatetime = 300

vim.o.number = true
vim.o.linebreak = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.mouse = ''

-- Open changed files in current git project
vim.api.nvim_create_user_command('GitDiff', function(_)
    local handle = io.popen("git status --porcelain | awk '{print $2}'")
    local result = handle:read("*a")
    handle:close()

    for line in (result..'\n'):gmatch'(.-)\r?\n' do 
        if line == "" then break end
        vim.cmd.edit(line)
    end
end, {})

