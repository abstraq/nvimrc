-- Installs and configures language servers.
-- See the relevant link for more information:
-- LSPConfig https://github.com/neovim/nvim-lspconfig
-- Mason https://github.com/williamboman/mason.nvim
-- Mason LSPConfig https://github.com/williamboman/mason-lspconfig.nvim
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/lazydev.nvim", opts = {} },
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0
					}
				}
			}
		},
	},
	config = function()
		local mason = require("mason")
		local mason_config = require("mason-lspconfig")

		-- Use mason to ensure the required language servers are pre installed.
		mason.setup()
		mason_config.setup({
			ensure_installed = {
				"biome", -- Web Development Tooling
				"html", -- HTML Language Server
				"cssls", -- CSS Language Server
				"clangd", -- C++ Language Server
				"lua_ls", -- Lua Language Server
				"rust_analyzer", -- Rust Language Server
				"sqls", -- SQL Language Server
				"svelte", -- Svelte Language Server
				"taplo", -- TOML Language Server
				"yamlls", -- YAML Language Server

			}
		})

		-- Change the diagnostic icons that are displayed in the sign column.
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local lspconfig = require("lspconfig")

		-- Use cmp-nvim-lsp client capabilities instead as it supports more
		-- completion candidates.
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_config.setup_handlers({
			-- Fallback handlers that registers cmp capabilities.
			function(server_name)
				local server = lspconfig[server_name]
				server.setup({ capabilities = capabilities })
			end,
			-- Enable clippy support for cargo check and utilize nightly rustfmt.
			["rust_analyzer"] = function()
				local server = lspconfig["rust_analyzer"]
				server.setup({
					capabilities = capabilities,
					settings = {
						["rust-analyzer"] = {
							rustfmt = { extraArgs = { "+nightly" } },
							check = { command = "clippy" }
						}
					}
				})
			end
		})

		-- Register LSP keybinds
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP Keybinds",
			callback = function(event)
				local map = function(mode, input, action)
					vim.keymap.set(mode, input, action, { buffer = true })
				end

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp_highlight", { clear = false })
					local diagnostic_augroup = vim.api.nvim_create_augroup("lsp_diagnostic", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = diagnostic_augroup,
						callback = vim.diagnostic.open_float,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp_detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp_highlight", buffer = event2.buf })
						end,
					})
				end

				if vim.lsp.inlay_hint then
					map(
						"n",
						"<leader>ch",
						function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end
					)
				end
			end
		})
	end
}
