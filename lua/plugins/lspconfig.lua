-- nvim-lspconfig [LSP]
-- Configures installed language servers.
--
-- See https://github.com/neovim/nvim-lspconfig for more information.
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} }, -- Initialize mason before all of its dependents.
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim",       opts = {} },
		{ "folke/lazydev.nvim",      opts = {} },
	},
	config = function()
		local mason_lsp_config = require("mason-lspconfig")
		local lsp_config = require("lspconfig")
		local lsp_cmp = require("cmp_nvim_lsp")

		local language_servers = {
			["lua_ls"] = {},
			["typos_lsp"] = {},
			["grammarly"] = {},
			["vimls"] = {},
			["rust_analyzer"] = {
				-- check = {
				-- command = "clippy"
				-- }
			}
		}

		local default_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = vim.tbl_deep_extend("force", default_capabilities, lsp_cmp.default_capabilities())

		mason_lsp_config.setup({
			ensure_installed = language_servers,
			automatic_installation = true,
			handlers = {
				-- Default handler for language servers that do not have a
				-- dedicated handler.
				function(server_name)
					lsp_config[server_name].setup({
						capabilities = capabilities,
						settings = language_servers[server_name]
					})
				end,
			},
		})
	end,
}
