local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerCompile", group = packer_group, pattern = "plugins.lua" }
)

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end
vim.api.nvim_command("packadd packer.nvim")


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

	use "rktjmp/hotpot.nvim"

  -- lsp code completion
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

	-- nice ui
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")

			saga.init_lsp_saga({
				-- your configuration
			})
		end,
	})

	use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use  'L3MON4D3/LuaSnip'
	  use 'saadparwaiz1/cmp_luasnip'

	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup { }
		end
	}


  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

	use {'nvim-telescope/telescope-ui-select.nvim' }

	use {
		"nvim-telescope/telescope-file-browser.nvim" ,
		config = function()
			require("telescope").setup {
				extensions = {
					file_browser = {
						theme = "ivy",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							["i"] = {
								-- your custom insert mode mappings
							},
							["n"] = {
								-- your custom normal mode mappings
							},
						},
					},
				}
			}
		end
	}

	use {
		'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
		config = function()
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
		end
	}


  use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

	-- task runner
	--use "stevearc/overseer.nvim"

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".projectile" }
    }
    end
  }

	use {
		"norcalli/nvim-colorizer.lua",
		config = function()
			require'colorizer'.setup()
		end
	}

  use {
    "windwp/nvim-autopairs"
  }

  use "machakann/vim-sandwich"

	use "tpope/vim-sensible"
  use "TimUntersberger/neogit"
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}

	use "ggandor/leap.nvim"

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use "sainnhe/edge"

  use {'glepnir/dashboard-nvim'}

	-- Lua
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {
        height = { min = 4, max = 45 }, -- min and max height of the columns
        width = { min = 20, max = 35 }, -- min and max width of the columns
        spacing = 0, -- spacing between columns
        align = "left", -- align columns left, center or right
			}
		end
	}

  use "rcarriga/nvim-notify"

	use "tpope/vim-commentary"

  use({
    "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({})
    end
  })

  -- Emmet
  use "mattn/emmet-vim"
  use "windwp/nvim-ts-autotag"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
