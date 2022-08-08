"lua require('hotpot')
lua require('plugins')

lua require('options')
lua require('config')
lua require('_cmp')
lua require('_lsp')
lua require('mappings')
lua require('evil-lualine')
lua require("telescope").load_extension "file_browser"
lua require('telescope').load_extension "projects"
lua require('telescope').load_extension "fzf"
lua require("telescope").load_extension "ui-select"
lua require("telescope").load_extension "file_browser"
lua require('telescope').load_extension "projects"
lua require('telescope').load_extension "fzf"
lua require("telescope").load_extension "ui-select"
lua require("telescope").load_extension("ui-select")



nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

nnoremap <Leader>w  <cmd>TrimWhitespace<CR>
