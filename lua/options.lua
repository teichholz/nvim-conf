local function set(option, value)
  if value == nil then
    vim.api.nvim_set_option(option, true)
  else
    vim.api.nvim_set_option(option, value)
  end
end

-- no line wraps
--vim.api.nvim_set_option("nowrap", true)
set("shiftwidth", 2)
set("smarttab")
set("tabstop", 2)
set("softtabstop", 2)
set("expandtab")

set("completeopt", "menu,menuone,preview,noinsert")

-- relative line numbers
set("number")
set("relativenumber")

-- clipboard
set("clipboard", "unnamed")

set("mouse", "a")

-- no swapfiles
set("undofile", true)

-- smart search
set("smartcase", true)

-- cursor line
set("cursorline")

-- theme
set("termguicolors", true)
set("background", "dark")

vim.g.edge_style = "aura"
vim.g.edge_better_performance = 0
vim.cmd("colorscheme edge")
