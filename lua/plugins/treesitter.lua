-- Provides interface for treesitter in neovim.
-- See https://github.com/nvim-treesitter/nvim-treesitter for more information.
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local languages = {
			"vim",
			"vimdoc",
			"lua",
			"rust",
			"c",
			"cpp",
			"toml",
			"json",
			"markdown",
		}

		treesitter.setup({
			ensure_installed = languages,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
