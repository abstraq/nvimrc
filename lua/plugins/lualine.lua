-- Customizes the status line at the bottom of the screen.
-- See https://github.com/nvim-lualine/lualine for more information.
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		local lualine = require("lualine")
		lualine.setup({
			options = { theme = "modus-vivendi" },
		})
	end
}
