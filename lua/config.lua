require'nvim-treesitter.configs'.setup {
	-- ensure_installed = "all",
	auto_intall = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- This is your opts table
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_ivy {}
    }
  }
}

require('leap').set_default_keymaps(true)


require("mason").setup()

