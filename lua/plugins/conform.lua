-- conform.nvim [Formatting]
-- Formats the buffer using the installed formatters.
--
-- See https://github.com/stevearc/conform.nvim for more information.
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
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
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
		},
		format_on_save = { timeous_ms = 300, lsp_fallback = true },
	},
}
