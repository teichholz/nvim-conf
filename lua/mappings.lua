local wk = require("which-key")

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local opts = { noremap=true, silent=true }

vim.cmd([[
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

function TrimEndLines()
    let save_cursor = getpos(".")
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

command! TrimWhitespace call TrimWhitespace()
command! TrimEndLines call TrimEndLines()
]])

local global = {
    f = {
      name = "Find files",
      f = { "<cmd>Telescope file_browser theme=ivy path=%:p:h<cr>", "File Browser" },
      s = { ":Telescope find_files theme=ivy find_command=fd,--hidden,--follow<CR>", "Fuzzy find files" },
      r = { ":Telescope oldfiles theme=ivy<CR>", "Recent files" },
    },
    c = {
      name = "Code",
      e = {":TroubleToggle<CR>", "Show code errors" },
    },
    p = {
      name = "Project",
      p = { ":Telescope projects theme=ivy<CR>", "Find project" }
    },
    b = {
      name = "Buffer",
      b = { ":Telescope buffers theme=ivy<CR>", "Find buffer" }
    },
    s = {
      name = "Search",
      p = { ":Telescope live_grep theme=ivy<CR>", "Search project" },
      b = { ":Telescope current_buffer_fuzzy_find theme=ivy<CR>", "Search buffer" }
    },
    e = { vim.diagnostic.open_float, "Show diagnostics" },
    o = {
     name = "Open",
     ["-"] = { "<cmd>Ex<cr>", "Open netrw" }
    },
    ["["] = {
      name = "Go to prev",
      d = { vim.diagnostic.goto_prev, "Previous diagnostic" }
    },
    ["]"] = {
      name = "Go to prev",
      d = { vim.diagnostic.goto_next, "Next diagnostic" }
    },
    ["'"] = {"<cmd>TrimWhitespace<CR><cmd>TrimEndLines<CR>", "Trim Whitespace and empty EOF lines" },
    ["<leader>"] = { ":Telescope find_files theme=ivy find_command=fd,--hidden,--follow<CR>", "Fuzzy find files" },
}
wk.register(global, { prefix = "<leader>" })

map("n", "H", "^", opts)
map("n", "L", "g_", opts)
map("n", "<C-q>", ":q!<CR>", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("n", "<tab>", "%", opts)
map("v", "<tab>", "%", opts)
map("n", "U", "<cmd>redo<cr>", opts)


map("n", "<C-j>", ":m .+1<CR>==")
map("n", "<C-k>", ":m .-2<CR>==")
-- map("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
-- map("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")


