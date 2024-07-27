-- conform.nvim [Formatting]
-- Formats the buffer using the installed formatters.
--
-- See https://github.com/stevearc/conform.nvim for more information.
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim"
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[C]ode [F]ormatting",
		},
	},
	config = function()
		local conform = require("conform")
		local mason_tool_installer = require("mason-tool-installer")

		local formatters = {
			"stylua",
		}

		mason_tool_installer.setup({ ensure_installed = formatters })
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = { timeous_ms = 300, lsp_fallback = true },
		})
	end,
}
