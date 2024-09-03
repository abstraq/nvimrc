-- Runs code formatter on buffer.
-- See https://github.com/stevearc/conform.nvim for more information.
return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang_format" }
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback"
			}
		})
	end
}
