-- nvim-lspconfig [LSP]
-- Configures installed language servers.
--
-- See https://github.com/neovim/nvim-lspconfig for more information.
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} }, -- Initialize mason before all of its dependents.
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			local mason_lsp_config = require("mason-lspconfig")
			local lsp_config = require("lspconfig")
			local lsp_cmp = require("cmp_nvim_lsp")

			local language_servers = {
				["lua_ls"] = {},
				["harper_ls"] = {},
				["rust_analyzer"] = {
					["rust-analyzer"] = {
						rustfmt = {
							extraArgs = { "+nightly" },
						},
						check = {
							command = "clippy",
						},
					},
				},
				["wgsl_analyzer"] = {},
			}

			local default_capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = vim.tbl_deep_extend("force", default_capabilities, lsp_cmp.default_capabilities())

			mason_lsp_config.setup({
				ensure_installed = vim.tbl_keys(language_servers or {}),
				automatic_installation = true,
				handlers = {
					-- Default handler for language servers that do not have a
					-- dedicated handler.
					function(server_name)
						lsp_config[server_name].setup({
							capabilities = capabilities,
							settings = language_servers[server_name],
						})
					end,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp", { clear = true }),
				callback = function(event)
					local fzf = require("fzf-lua")
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", function()
						fzf.lsp_code_actions()
					end, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap.
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", function()
						fzf.declarations()
					end, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
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

					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
		end,
	},
}
