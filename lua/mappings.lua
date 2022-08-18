local wk = require("which-key")

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true, }
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
      b = { ":Telescope current_buffer_fuzzy_find theme=ivy<CR>", "Search buffer" },
      h = { ":Telescope help_tags theme=ivy<CR>", "Search vim help" },
    },
    S = {
      name = "Snippets",
      r = { function() require'snippets' end, "Reload snippets" }
    },
    e = { vim.diagnostic.open_float, "Show diagnostics" },
    o = {
     name = "Open",
     ["-"] = { "<cmd>Ex<cr>", "Open netrw" }
    },
    g = {
      g = { "<cmd>Neogit<cr>", "Git overview" },
    },
    t = { "<Plug>PlenaryTestFile", "Plenary test file" },
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
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

local ls = require("luasnip")
-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
map({ "i", "s" }, "<c-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
map({ "i", "s" }, "<c-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
map("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

map("i", "<c-u>", require "luasnip.extras.select_choice")

