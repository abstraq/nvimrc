-- Edit filesystem as a buffer.
-- See https://github.com/stevearc/oil.nvim for more information.
return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		experimental_watch_for_changes = true,
		view_options = { show_hidden = true },
		float = { padding = 8 },
	},
	keys = {
		{
			"-",
			function()
				local oil = require("oil")
				oil.open()
			end,
			{ desc = "Opens the file browser for the parent directory." }
		}
	}
}
