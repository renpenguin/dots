-- neovim/plugins/telescope.lua

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<space>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<space>hf', builtin.git_files, { desc = 'Telescope find files' })
