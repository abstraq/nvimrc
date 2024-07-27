return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	keys = {
		{
			"<leader>sf",
			function()
				local fzf = require("fzf-lua")
				fzf.files()
			end,
			{ desc = "Search for a specific file in the current working directory." },
		},
		{
			"<leader>sg",
			function()
				local fzf = require("fzf-lua")
				fzf.live_grep()
			end,
			{ desc = "Search project files using live grep." },
		},
		{
			"<leader>sh",
			function()
				local fzf = require("fzf-lua")
				fzf.helptags()
			end,
			{ desc = "Search help tags." },
		},
	},
}
