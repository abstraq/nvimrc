-- Fuzzy finder that can search multiple sources.
-- See https://github.com/ibhagwan/fzf-lua for more information.
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
			{ desc = "Search for a file in the current working directory." }
		},
		{
			"<leader>sg",
			function()
				local fzf = require("fzf-lua")
				fzf.live_grep()
			end,
			{ desc = "Search project files using live grep." }
		},
		{
			"<leader>sh",
			function()
				local fzf = require("fzf-lua")
				fzf.helptags()
			end,
			{ desc = "Search help tags." }
		},
		{
			"<leader>sb",
			function()
				local fzf = require("fzf-lua")
				fzf.buffers()
			end
		},
		{
			"<leader>ca",
			function()
				local fzf = require("fzf-lua")
				fzf.lsp_code_actions()
			end
		}
	}
}
