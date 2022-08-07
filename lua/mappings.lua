vim.g.mapleader = ' '
wk = require("which-key")

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local opts = { noremap=true, silent=true }

local global = {
    f = {
      name = "Find files",
      f = { "<cmd>Telescope file_browser theme=ivy path=%:p:h<cr>", "File Browser" },
      s = { ":Telescope find_files theme=ivy find_command=fd,--hidden,--follow<CR>", "Fuzzy find files" },
      r = { ":Telescope oldfiles theme=ivy<CR>", "Recent files" },
    },
    c = {
      e = {":TroubleToggle<CR>", "Show code errors" },
    },
    p = {
      p = { ":Telescope projects theme=ivy<CR>", "Find project" }
    },
    b = {
      b = { ":Telescope buffers theme=ivy<CR>", "Find buffer" }
    },
    s = {
      b = { ":Telescope live_grep theme=ivy<CR>", "Search buffer" }
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
    ["<leader>"] = { ":Telescope find_files theme=ivy find_command=fd,--hidden,--follow<CR>", "Fuzzy find files" },
}
wk.register(global, { prefix = "<leader>" })

map("n", "H", "^", opts)
map("n", "L", "g_", opts)
map("n", "<C-q>", ":q!<CR>", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("n", "<tab>", "%", opts)