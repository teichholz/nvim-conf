local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local lspconf = {}
lspconf['sumneko_lua'] = {
	Lua = {
		runtime = {
			version = 'LuaJIT',
		},
		diagnostics = {
			globals = {'vim'},
		},
		workspace = {
			library = vim.api.nvim_get_runtime_file("", true),
		},
		telemetry = {
			enable = false,
		},
		format = {
			enable = true,
			defaultConfig = {
				indent_style = "space",
				indent_size = "2",
			}
		}
	},
}

lspconf['bashls'] = {
	filetypes = {"sh", "zsh", "bash"},
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)|*zsh*"
	},

}
lspconf['rnix'] = {}
lspconf['pyright'] = {}
lspconf['tsserver'] = {}

-- needed for jsonls
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconf['jsonls'] = {
  capabilities = capabilities,
}


local lspServers = { "sumneko_lua", "rnix", "bashls", "pyright", "tsserver" }

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>cD', vim.lsp.buf.type_definition, bufopts)
	map('n', '<space>ci', '<cmd>Telescope lsp_document_symbols theme=ivy<cr>', bufopts)
  vim.keymap.set('n', '<space>crn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<space>ca', vim.lsp.buf.code_action, bufopts)
  map('n', 'gr', '<cmd>Telescope lsp_references theme=ivy<cr>', bufopts)
  vim.keymap.set('n', '<space>cf', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('v', '<space>cf', vim.lsp.buf.range_formatting, bufopts)
end

local lsp_flags = {}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


for _, server in ipairs(lspServers) do
	require('lspconfig')[server].setup{
    on_attach = on_attach,
    flags = lsp_flags,
		settings = lspconf[server],
		capabilities = capabilities
	}
end

require("flutter-tools").setup{
	on_attach = on_attach
}

require("mason-lspconfig").setup{
  automatic_installation = true,
}
