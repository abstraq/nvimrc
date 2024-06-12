-- bufferline.nvim [Indicators]
-- Displays the current buffers that are open.
--
-- See https://github.com/akinsho/bufferline.nvim for more information.
return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			mode = "buffers",
			diagnostics = "nvim_lsp"
		},
	},
}
