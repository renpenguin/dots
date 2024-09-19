" Ren's neovim config
" This can be linked to your .vimrc with a line like: source ~/Documents/dots/rc/my_configs.vim

" Clipboard fix
set clipboard+=unnamedplus
set clipboard+=unnamedplus

set mouse= " Disable mouse

set number " Show line numbers

" Transparent background
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none

delc W

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \       [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \       [ 'percent' ],
    \       [ 'filetype' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
  \ }

set showtabline=0 " Hide tabline (and that annoying X)
