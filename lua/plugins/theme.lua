return {
  { 'rakr/vim-one' },
  { 'Mofiqul/dracula.nvim', config = function()
      vim.g.edge_style = "aura"
      vim.g.edge_better_performance = 0
      vim.cmd("colorscheme dracula")
    end
  }
}
