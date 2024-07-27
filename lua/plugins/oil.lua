return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		experimental_watch_for_changes = true,
		view_options = {
			show_hidden = true,
		},
		float = {
			padding = 8,
		},
	},
	keys = {
		{
			"<leader><leader>",
			function()
				local oil = require("oil")
				oil.toggle_float()
			end,
			{ desc = "Opens the file browser in the parent of the current buffer." },
		},
	},
}
