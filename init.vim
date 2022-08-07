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

nnoremap <space>ff :Telescope file_browser theme=ivy path=%:p:h<CR>
nnoremap <space>pp :Telescope projects theme=ivy<CR>
nnoremap <space>bb :Telescope buffers theme=ivy<CR>
nnoremap <space>sb :Telescope live_grep theme=ivy<CR>
nnoremap <space>fs :Telescope find_files theme=ivy find_command=fd,--hidden,--follow<CR>
nnoremap <space><space> :Telescope find_files theme=ivy find_command=fd,--hidden,--follow<CR>
nnoremap <space>fr :Telescope oldfiles theme=ivy<CR>
nnoremap <space>ce :TroubleToggle<CR>
nnoremap <C-q> :q!<CR>
vnoremap < <gv
nnoremap <tab> %
vnoremap > >gv

